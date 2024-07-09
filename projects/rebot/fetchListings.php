<?php
// Cache directory
$cacheDir = __DIR__ . '/cache/';
// Cache expiration time (1 hour)
$cacheTime = 3600;

function fetchListings($pdo, $cacheDir, $cacheTime) {
    // Check if cache directory exists, create if not
    if (!file_exists($cacheDir)) {
        mkdir($cacheDir, 0777, true);
    }

    // Cache file path
    $cacheFile = $cacheDir . 'listings_cache.json';

    // Check if cache file exists and not expired
    if (file_exists($cacheFile) && (time() - filemtime($cacheFile) < $cacheTime)) {
        // Cache file is valid, return data from cache
        return json_decode(file_get_contents($cacheFile), true);
    }

    // Veritabanı bağlantı bilgileri
    $dsn = 'mysql:host=localhost;dbname=rayestor_emlakdb;charset=utf8mb4';
    $username = 'rayestor_emlakuser';
    $password = '1453Emlak@';

    try {
        // PDO ile veritabanına bağlanma
        $pdo = new PDO($dsn, $username, $password);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $pdo->exec("SET NAMES 'utf8mb4'");
        $pdo->exec("SET CHARACTER SET utf8mb4");
        $pdo->exec("SET COLLATION_CONNECTION = 'utf8mb4_unicode_ci'");

        // Emlakjet.com adresine HTTP isteği göndererek sayfayı çekelim
        $url = 'https://www.emlakjet.com/satilik-konut/';

        // cURL özkaynağını oluşturalım
        $ch = curl_init();

        // cURL ayarlarını yapılandıralım
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); // Sonucu doğrudan almak için
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true); // Yönlendirmeleri takip et
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true); // SSL sertifikası doğrulamasını etkinleştir
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2); // Host adının eşleşmesini gerektir

        // İsteği gerçekleştirelim
        $response = curl_exec($ch);

        // Hata kontrolü yapalım
        if (curl_errno($ch)) {
            throw new Exception('cURL Hatası: ' . curl_error($ch));
        }

        // cURL bağlantısını kapat
        curl_close($ch);

        // Yanıtı işleyebiliriz, örneğin DOMDocument kullanarak
        $dom = new DOMDocument();
        @$dom->loadHTML('<?xml encoding="UTF-8">' . $response); // Hata mesajlarını bastırmamak için @ kullanıyoruz

        // DOMXPath oluşturalım ve XPath sorgusu yapalım
        $xpath = new DOMXPath($dom);

        // İlanları içeren elementleri seçmek için XPath sorgusu
        $nodes = $xpath->query('//div[contains(@class, "_3qUI9q")]');

        // Verileri saklamak için bir dizi oluşturalım
        $listings = array();

        // Her bir element için başlık, fiyat, data-id, details, features ve href bilgilerini alalım
        foreach ($nodes as $node) {
            // Başlıkı çekelim ve yazım kurallarına göre düzenleyelim
            $titleNode = $xpath->query('.//h3', $node)->item(0);
            $title = $titleNode ? trim(mb_convert_case($titleNode->nodeValue, MB_CASE_TITLE, 'UTF-8')) : 'Başlık bulunamadı';

            // Fiyatı çekelim
            $priceNode = $xpath->query('.//p[contains(@class, "_2C5UCT")]/span/span', $node)->item(0);
            $price = $priceNode ? trim($priceNode->nodeValue) : 'Fiyat bulunamadı';

            // Data-id değerini çekelim
            $dataId = $node->getAttribute('data-id');

            // Details bilgisini çekelim
            $detailsNode = $xpath->query('.//div[contains(@class, "_2UELHn")]', $node)->item(0);
            $detailsSpans = $xpath->query('.//span', $detailsNode);

            // Detayları saklamak için bir dizi oluşturalım
            $details = array();
            foreach ($detailsSpans as $span) {
                // Span içindeki iconları almamak için gerekli kontrolleri yapalım
                $innerText = '';
                foreach ($span->childNodes as $childNode) {
                    if ($childNode->nodeType === XML_TEXT_NODE) {
                        $innerText .= $childNode->nodeValue;
                    }
                }
                // Alınan içerik boş olmadığında ekleyelim
                if (!empty(trim($innerText))) {
                    $details[] = trim($innerText);
                }
            }
            // Details bilgisini bir satırda toplayalım
            $detailsString = implode(' | ', $details);

            // Features bilgisini çekelim
            $featuresNode = $xpath->query('.//div[contains(@class, "_2wVG12")]', $node)->item(0);
            $featuresSpans = $xpath->query('.//span', $featuresNode);

            // Özellikleri saklamak için bir dizi oluşturalım
            $features = array();
            foreach ($featuresSpans as $span) {
                // Span içindeki iconları almamak için gerekli kontrolleri yapalım
                $innerText = '';
                foreach ($span->childNodes as $childNode) {
                    if ($childNode->nodeType === XML_TEXT_NODE) {
                        $innerText .= $childNode->nodeValue;
                    }
                }
                // Alınan içerik boş olmadığında ekleyelim
                if (!empty(trim($innerText))) {
                    $features[] = trim($innerText);
                }
            }
            // Features bilgisini bir satırda toplayalım
            $featuresString = implode(' | ', $features);

            // Href bilgisini çekelim
            $hrefNode = $xpath->query('.//a', $node)->item(0);
            $href = $hrefNode ? trim($hrefNode->getAttribute('href')) : 'Link bulunamadı';

            // Veritabanında bu verinin olup olmadığını kontrol edelim
            $stmt = $pdo->prepare("SELECT COUNT(*) FROM listings WHERE data_id = :data_id");
            $stmt->execute(['data_id' => $dataId]);
            $count = $stmt->fetchColumn();

            // Eğer veri yoksa ekleyelim
            if ($count == 0) {
                // Başlık, fiyat, data-id, details, features ve href bilgilerini bir diziye ekleyelim
                $listing = array(
                    'title' => $title,
                    'price' => $price,
                    'data-id' => $dataId,
                    'details' => $detailsString, // Tek satırda toplanmış details bilgisi
                    'features' => $featuresString, // Tek satırda toplanmış features bilgisi
                    'source' => 'emlakjet.com', // Kaynak bilgisi eklendi
                    'href' => $href // Href bilgisi eklendi
                );

                // Veritabanına ekle
                $stmt = $pdo->prepare("INSERT INTO listings (title, price, data_id, details, features, source, href) VALUES (:title, :price, :data_id, :details, :features, :source, :href)");
                $stmt->execute([
                    'title' => $listing['title'],
                    'price' => $listing['price'],
                    'data_id' => $listing['data-id'],
                    'details' => $listing['details'],
                    'features' => $listing['features'],
                    'source' => $listing['source'],
                    'href' => $listing['href']
                ]);

                // Oluşturulan listing'i listeye ekleyelim
                $listings[] = $listing;
            }
        }

        // Önbelleğe alınacak veriyi JSON formatında kaydedelim
        file_put_contents($cacheFile, json_encode($listings));

        // Sonuçları döndürelim
        return $listings;

    } catch (PDOException $e) {
        echo 'Veritabanı bağlantı hatası: ' . $e->getMessage();
    } catch (Exception $e) {
        echo $e->getMessage();
    }
}
?>
