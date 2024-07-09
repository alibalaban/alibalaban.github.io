<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Satılık Konut</title>
</head>
<body>
    <h1>Satılık Konut Listesi</h1>
    <form method="post" action="">
        <button type="submit" name="clear_cache">Önbelleği Temizle ve Verileri Yeniden Çek</button>
    </form>

    <?php
    if (isset($_POST['clear_cache'])) {
        // Önbellek dosyasını silelim
        $cacheFile = __DIR__ . '/cache/emlakjet_cache.json';
        if (file_exists($cacheFile)) {
            unlink($cacheFile);
            echo "<p>Önbellek temizlendi. Veriler yenilendi.</p>";
        }
    }

    // Emlakjet.php dosyasını çağırarak verileri çekelim ve işleyelim
    include 'emlakjet.php';

    // Listelenen ilanları gösterelim
    foreach ($listings as $listing) {
        echo "<div>";
        echo "<h2>{$listing['title']}</h2>";
        echo "<p>Fiyat: {$listing['price']}</p>";
        echo "<p>Detaylar: {$listing['details']}</p>";
        echo "<p>Özellikler: {$listing['features']}</p>";
        echo "<a href='{$listing['href']}'>İlanı Görüntüle</a>";
        echo "</div>";
    }
    ?>
</body>
</html>
