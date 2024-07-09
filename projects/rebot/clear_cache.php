<?php
// Cache dosyasını kontrol edelim ve varsa silelim
$cacheFile = 'cache/listings.json';

if (file_exists($cacheFile)) {
    unlink($cacheFile); // Dosyayı sil
}

// Anasayfaya yönlendir
header('Location: index.php');
exit;
?>
