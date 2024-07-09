<?php
// Önbellek dosyasının yolu
$cacheFile = __DIR__ . '/cache/emlakjet_cache.json';
// Önbellek süresi (saniye cinsinden)
$cacheTime = 3600; // 1 saat

function fetchData() {
    global $cacheFile, $cacheTime;
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
        $url = 'https://www.uygunev.com.tr/emlak/test/satilik-konut.html';

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

        // Her bir element için başlık, fiyat, data-id, details, features ve href bilgilerini alalım
        $listings = [];
        foreach ($nodes as $node) {
            // Data-id değerini çekelim
            $dataId = $node->getAttribute('data-id');

            // Başlıkı çekelim ve yazım kurallarına göre düzenleyelim
            $titleNode = $xpath->query('.//h3', $node)->item(0);
            $title = $titleNode ? trim(mb_convert_case($titleNode->nodeValue, MB_CASE_TITLE, 'UTF-8')) : 'Başlık bulunamadı';

            // Fiyatı çekelim
            $priceNode = $xpath->query('.//p[contains(@class, "_2C5UCT")]/span/span', $node)->item(0);
            $price = $priceNode ? trim($priceNode->nodeValue) : 'Fiyat bulunamadı';

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
            $stmt = $pdo->prepare("SELECT * FROM listings WHERE data_id = :data_id");
            $stmt->execute(['data_id' => $dataId]);
            $listing = $stmt->fetch(PDO::FETCH_ASSOC);

            // Eğer veri varsa ve farklılık varsa güncelle
            if ($listing) {
                if ($listing['title'] !== $title || $listing['price'] !== $price || $listing['details'] !== $detailsString || $listing['features'] !== $featuresString) {
                    // Veriyi güncelle
                    $stmt = $pdo->prepare("UPDATE listings SET title = :title, price = :price, details = :details, features = :features, price_changes_count = price_changes_count + 1 WHERE data_id = :data_id");
                    $stmt->execute([
                        'title' => $title,
                        'price' => $price,
                        'details' => $detailsString,
                        'features' => $featuresString,
                        'data_id' => $dataId
                    ]);

                    // Eski fiyatı old_prices tablosuna ekle
                    $stmtOldPrices = $pdo->prepare("SELECT prices FROM old_prices WHERE data_id = :data_id");
                    $stmtOldPrices->execute(['data_id' => $dataId]);
                    $oldPricesJson = $stmtOldPrices->fetchColumn();

                    // Eski fiyatları diziye çevirelim
                    $oldPrices = json_decode($oldPricesJson, true);

                    // Eğer eski fiyatlar daha önce kaydedilmemişse yeni bir dizi oluşturalım
                    if (!$oldPrices) {
                        $oldPrices = [];
                    }

                    // Yeni fiyatı eski fiyatlar dizisine ekleyelim
                    $oldPrices[] = $listing['price'];

                    // JSON formatına çevirelim
                    $newOldPricesJson = json_encode($oldPrices);

                    // old_prices tablosunu güncelle veya ekle
                    if ($oldPricesJson) {
                        // Eğer kayıt varsa güncelle
                        $stmtUpdateOldPrices = $pdo->prepare("UPDATE old_prices SET prices = :prices WHERE data_id = :data_id");
                        $stmtUpdateOldPrices->execute([
                            'prices' => $newOldPricesJson,
                            'data_id' => $dataId
                        ]);
                    } else {
                        // Eğer kayıt yoksa ekle
                        $stmtInsertOldPrices = $pdo->prepare("INSERT INTO old_prices (data_id, prices) VALUES (:data_id, :prices)");
                        $stmtInsertOldPrices->execute([
                            'data_id' => $dataId,
                            'prices' => $newOldPricesJson
                        ]);
                    }
                }
            } else {
                // Eğer veri yoksa yeni veri olarak ekle
                $stmt = $pdo->prepare("INSERT INTO listings (data_id, title, price, details, features, href) VALUES (:data_id, :title, :price, :details, :features, :href)");
                $stmt->execute([
                    'data_id' => $dataId,
                    'title' => $title,
                    'price' => $price,
                    'details' => $detailsString,
                    'features' => $featuresString,
                    'href' => $href
                ]);
            }

            // Veriyi listings dizisine ekleyelim
            $listings[] = [
                'data_id' => $dataId,
                'title' => $title,
                'price' => $price,
                'details' => $detailsString,
                'features' => $featuresString,
                'href' => $href
            ];
        }

        // Önbellek dosyasına veriyi yazalım
        file_put_contents($cacheFile, json_encode($listings));

        // Verileri fiyatlarına göre sırala
        usort($listings, function($a, $b) {
            return str_replace(['.', ',', ' TL'], '', $b['price']) - str_replace(['.', ',', ' TL'], '', $a['price']);
        });

        return $listings;
    } catch (PDOException $e) {
        die('Veritabanı bağlantı hatası: ' . $e->getMessage());
    } catch (Exception $e) {
        die('Hata: ' . $e->getMessage());
    }
}

if (isset($_POST['clear_cache'])) {
    // Önbellek dosyasını sil
    if (file_exists($cacheFile)) {
        unlink($cacheFile);
    }
    // Veriyi yeniden çek
    $listings = fetchData();
    header('Location: ' . $_SERVER['PHP_SELF']);
    exit;
}

// Eğer önbellek dosyası mevcut ve süresi geçmemişse, önbellekten veriyi okuyalım
if (file_exists($cacheFile) && (time() - filemtime($cacheFile) < $cacheTime)) {
    $listings = json_decode(file_get_contents($cacheFile), true);
} else {
    // Veriyi yeniden çek
    $listings = fetchData();
}

// Verileri işle ve index.php dosyasına gönder
