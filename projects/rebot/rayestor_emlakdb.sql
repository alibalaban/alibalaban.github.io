-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: localhost:3306
-- Üretim Zamanı: 09 Tem 2024, 14:20:49
-- Sunucu sürümü: 10.6.18-MariaDB
-- PHP Sürümü: 8.1.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `rayestor_emlakdb`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `fetch_log`
--

CREATE TABLE `fetch_log` (
  `id` int(11) NOT NULL,
  `last_fetch` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `fetch_log`
--

INSERT INTO `fetch_log` (`id`, `last_fetch`) VALUES
(1, '2024-07-08 22:23:43'),
(2, '2024-07-08 22:29:34'),
(3, '2024-07-08 22:36:51'),
(4, '2024-07-08 22:57:45'),
(5, '2024-07-08 23:07:15'),
(6, '2024-07-08 23:12:32'),
(7, '2024-07-08 23:47:30'),
(8, '2024-07-08 23:54:52'),
(9, '2024-07-09 00:05:46');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `listings`
--

CREATE TABLE `listings` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `price` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `details` text DEFAULT NULL,
  `features` text DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `href` varchar(255) DEFAULT NULL,
  `data_id` varchar(255) NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `price_changes_count` int(11) DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `listings`
--

INSERT INTO `listings` (`id`, `title`, `price`, `created_at`, `details`, `features`, `source`, `href`, `data_id`, `last_updated`, `price_changes_count`) VALUES
(1388, 'Marvel\'den Germi̇r\'de Takasa Açik  3+1 Dai̇re', '2.100.000', '2024-07-09 10:42:44', 'Daire | 3+1 | 8. Kat | 165 m2 | 9 Temmuz', 'Kayseri - Melikgazi - Germir Mh.', NULL, '/ilan/marvel-den-germir-de-takasa-acik-31-daire-15459529/', '15459529', '2024-07-09 10:42:44', 0),
(1389, 'Müftüoğlundan Eşyalariyla Bi̇rli̇kte 4+1 Emsali̇ Yok Firsat Fi̇yat', '4.200.000', '2024-07-09 10:56:24', 'Daire | 4.5+1 | 3. Kat | 200 m2 | 9 Temmuz', 'Mersin - Anamur - Bahçe Mh.', NULL, '/ilan/muftuoglundan-esyalariyla-birlikte-41-emsali-yok-firsat-fiyat-15459674/', '15459674', '2024-07-09 10:56:24', 0),
(1387, 'Irmaksu Dan Altinkum Da Deni̇ze 500M Otoparkli Si̇te İçi̇ 3+1 Dai̇re', '3.050.000', '2024-07-09 10:26:58', 'Daire | 3+1 | 2. Kat | 140 m2 | 9 Temmuz', 'Balıkesir - Edremit - Altınkum Mh.', NULL, '/ilan/irmaksu-dan-altinkum-da-denize-500m-otoparkli-site-ici-31-daire-15459412/', '15459412', '2024-07-09 10:26:58', 0),
(1386, 'Dalaman Hürri̇yet Mah. Eşyali 90 M2 2+1 Bahçeli̇ Satilik Dai̇re.', '2.695.000', '2024-07-09 10:03:07', 'Daire | 2+1 | 1. Kat | 90 m2 | 9 Temmuz', 'Muğla - Dalaman - Hürriyet Mh.', NULL, '/ilan/dalaman-hurriyet-mah-esyali-90-m2-21-bahceli-satilik-daire-15458931/', '15458931', '2024-07-09 10:03:07', 0),
(1384, 'Özen Emlak Dan Satilik 4Katli Mülk', '7.000.000', '2024-07-09 09:09:15', 'Bina | 3+1 | 138 m2 | 9 Temmuz', 'Düzce - Yığılca - Orhangazi Mh.', NULL, '/ilan/ozen-emlak-dan-satilik-4katli-mulk-15446992/', '15446992', '2024-07-09 09:09:15', 0),
(1385, 'Girne Karakum\'da 3+1 Duplex Kesintisiz Dağ Ve Deniz Manzaralı Pe', '265.000', '2024-07-09 09:09:15', 'Daire | 3+1 | Çatı Dubleks | 185 m2 | 7 Temmuz', 'KKTC - Girne - Karakum Mh.', NULL, '/ilan/girne-karakum-da-31-duplex-kesintisiz-dag-ve-deniz-manzarali-penthouse-15445986/', '15445986', '2024-07-09 09:09:15', 0),
(1383, 'Bağcılar Yıldıztepe Mah.2+1 Ferah Satılık Daire', '1.580.000', '2024-07-09 09:09:15', 'Daire | 2+1 | 3. Kat | 95 m2 | 8 Temmuz', 'İstanbul - Bağcılar - Yıldıztepe Mh.', NULL, '/ilan/bagcilar-yildiztepe-mah-21-ferah-satilik-daire-15448756/', '15448756', '2024-07-09 09:09:15', 0),
(1382, 'Emlak Presti̇j\'den Ara Kat Bagimsiz Salonlu 3+1 115M Dai̇re', '1.990.000', '2024-07-09 09:09:15', 'Daire | 3+1 | 2. Kat | 122 m2 | 8 Temmuz', 'Ankara - Sincan - Atatürk Mh.', NULL, '/ilan/emlak-prestij-den-ara-kat-bagimsiz-salonlu-31-115m-daire-15450575/', '15450575', '2024-07-09 09:09:15', 0),
(1381, 'Rw Mef\'den Deni̇z Mh. İkon Konaklarinda Satilik Tri̇pleks Vi̇lla', '33.000.000', '2024-07-09 09:09:15', 'Villa | 7+1 | 840 m2 | 9 Temmuz', 'Mersin - Yenişehir - Deniz Mh.', NULL, '/ilan/rw-mef-den-deniz-mh-ikon-konaklarinda-satilik-tripleks-villa-15453045/', '15453045', '2024-07-09 09:09:15', 0),
(1380, 'Fatih Mahallesinde 2+1 Satılık Daire', '1.750.000', '2024-07-09 09:09:15', 'Daire | 2.5+1 | 2. Kat | 100 m2 | 9 Temmuz', 'Kütahya - Kütahya Merkez - Fatih Mh.', NULL, '/ilan/fatih-mahallesinde-21-satilik-daire-15455751/', '15455751', '2024-07-09 09:09:15', 0),
(1379, 'Yüreği̇r Çamlibel De Satilik Zemi̇n Kat', '1.220.000', '2024-07-09 09:09:15', 'Daire | 1+1 | Yüksek giriş | 70 m2 | 9 Temmuz', 'Adana - Yüreğir - Çamlıbel Mh.', NULL, '/ilan/yuregir-camlibel-de-satilik-zemin-kat-15456928/', '15456928', '2024-07-09 09:09:15', 0),
(1377, 'Harika Konumda Merkeze Ve Denize 400Mt Mesafede Villa', '9.500.000', '2024-07-09 03:07:17', 'Villa | 3+1 | 140 m2 | 8 Temmuz', 'Aydın - Kuşadası - Güzelçamlı Mh.', NULL, '/ilan/harika-konumda-merkeze-ve-denize-400mt-mesafede-villa-15444970/', '15444970', '2024-07-09 11:03:17', 1),
(1378, 'Doğuş Gayri̇menkul Arsi̇n Yali Da Satilik Dai̇re', '2.950.000', '2024-07-09 09:09:15', 'Daire | 2+1 | 4. Kat | 140 m2 | 9 Temmuz', 'Trabzon - Arsin - Yalı Mh.', NULL, '/ilan/dogus-gayrimenkul-arsin-yali-da-satilik-daire-15458640/', '15458640', '2024-07-09 09:09:15', 0),
(1375, 'Pamukkale Manzarali Kaçirilmayacak Firsatli Ultra Lüx 7+1 Havuzl', '9.990.000', '2024-07-09 03:07:17', 'Villa | 7+1 | 270 m2 | 7 Temmuz', 'Denizli - Sarayköy - Beylerbeyi Mh.', NULL, '/ilan/pamukkale-manzarali-kacirilmayacak-firsatli-ultra-lux-71-havuzlu-villa-15445596/', '15445596', '2024-07-09 03:07:17', 0),
(1376, '➡️Cadde\'den Geni̇ş M2 Sahi̇p Ebeveyn Banyolu Şik Tasarim 3+1 Satil', '3.550.000', '2024-07-09 03:07:17', 'Daire | 3+1 | 1. Kat | 135 m2 | 7 Temmuz', 'Balıkesir - Edremit - Akçay Mh.', NULL, '/ilan/cadde-den-genis-m2-sahip-ebeveyn-banyolu-sik-tasarim-31-satilik-15445209/', '15445209', '2024-07-09 03:07:17', 0),
(1374, 'Kat Mülkiyet Tapulu İskanlı Bahçe Kullanımlı Satılık 2+1 Daire', '1.100.000', '2024-07-09 03:07:17', 'Daire | 2+1 | Bahçe katı | 75 m2 | 7 Temmuz', 'İstanbul - Bahçelievler - Siyavuşpaşa Mh.', NULL, '/ilan/kat-mulkiyet-tapulu-iskanli-bahce-kullanimli-satilik-21-daire-15445881/', '15445881', '2024-07-09 03:07:17', 0),
(1373, 'Aci̇l Satilik - Yeni̇bosna Satilik Dai̇rew 2+1 Arakat Kredi̇yeuygun D', '2.360.000', '2024-07-09 03:07:17', 'Daire | 2+1 | 3. Kat | 85 m2 | 8 Temmuz', 'İstanbul - Bahçelievler - Zafer Mh.', NULL, '/ilan/acil-satilik-yenibosna-satilik-dairew-21-arakat-krediyeuygun-daire-15445888/', '15445888', '2024-07-09 03:07:17', 0),
(1372, 'Aci̇l Satilik -Bahçelei̇vler Yeni̇bosna Kredi̇yeuygun  Lüxs Dai̇re', '2.360.000', '2024-07-09 03:07:17', 'Daire | 2+1 | 3. Kat | 85 m2 | 8 Temmuz', 'İstanbul - Bahçelievler - Yenibosna Merkez Mh.', NULL, '/ilan/acil-satilik-bahceleivler-yenibosna-krediyeuygun-luxs-daire-15445930/', '15445930', '2024-07-09 03:07:17', 0),
(1371, 'Kuşadasi Davutlarda Satilik 60 Metrekare Dükkan', '2.450.000', '2024-07-09 03:07:17', 'Daire | Stüdyo | Düz Giriş (Zemin) | 80 m2 | 8 Temmuz', 'Aydın - Kuşadası - Davutlar Mh.', NULL, '/ilan/kusadasi-davutlarda-satilik-60-metrekare-dukkan-15446014/', '15446014', '2024-07-09 03:07:17', 0),
(1370, 'Başkent Yapi\'dan Merkezi̇ Lokasyonda 2+1 Ebeveyn Banyolu Dai̇re', '1.960.000', '2024-07-09 03:07:17', 'Daire | 2+1 | 3. Kat | 120 m2 | 7 Temmuz', 'İstanbul - Avcılar - Mustafa Kemal Paşa Mh.', NULL, '/ilan/baskent-yapi-dan-merkezi-lokasyonda-21-ebeveyn-banyolu-daire-15446078/', '15446078', '2024-07-09 03:07:17', 0),
(1369, 'Orman Yani Firsat Satilik Sifir Vi̇lla Ti̇pi̇ 4+1 Dubleks Dai̇re 233', '24.000.000', '2024-07-09 03:07:17', 'Daire | 4+1 | Çatı Dubleks | 233 m2 | 7 Temmuz', 'İstanbul - Eyüpsultan - Mithatpaşa Mh.', NULL, '/ilan/orman-yani-firsat-satilik-sifir-villa-tipi-41-dubleks-daire-233-m-15447053/', '15447053', '2024-07-09 03:07:17', 0),
(1367, 'Gürelemlak Tan Balçovanin En Nezi̇h Yeri̇nde', '1.890.000', '2024-07-09 03:07:17', 'Daire | 2+1 | Yüksek giriş | 100 m2 | 8 Temmuz', 'İzmir - Balçova - Eğitim Mh.', NULL, '/ilan/gurelemlak-tan-balcovanin-en-nezih-yerinde-15449896/', '15449896', '2024-07-09 03:07:17', 0),
(1368, '3+1 Kod -1 De Satilik Aci̇l Dai̇re', '1.300.000', '2024-07-09 03:07:17', 'Daire | 3+1 | Kot 1 (-1). Kat | 165 m2 | 7 Temmuz', 'Şanlıurfa - Karaköprü - Narlıkuyu Mh.', NULL, '/ilan/31-kod-1-de-satilik-acil-daire-15447602/', '15447602', '2024-07-09 03:07:17', 0),
(1366, 'Bluestate\'ten Alaçati\'da Satilik Müstaki̇l 3+1', '34.000.000', '2024-07-09 03:07:17', 'Villa | 3+1 | 210 m2 | 8 Temmuz', 'İzmir - Çeşme - Alaçatı Mh.', NULL, '/ilan/bluestate-ten-alacati-da-satilik-mustakil-31-15450934/', '15450934', '2024-07-09 03:07:17', 0),
(1365, 'Centerdan Deni̇z Manzarali Deni̇ze 50 Mt Satilik 2+1 !!!', '2.950.000', '2024-07-09 03:07:17', 'Daire | 2+1 | 2. Kat | 110 m2 | 8 Temmuz', 'Mersin - Mezitli - Seymenli Mh.', NULL, '/ilan/centerdan-deniz-manzarali-denize-50-mt-satilik-21-15450995/', '15450995', '2024-07-09 03:07:17', 0),
(1364, 'Az Katli Bi̇nada Sahi̇bi̇nden Satilik', '4.500.000', '2024-07-09 03:07:17', 'Daire | 2+1 | 3. Kat | 100 m2 | 8 Temmuz', 'İstanbul - Sarıyer - Bahçeköy Merkez Mh.', NULL, '/ilan/az-katli-binada-sahibinden-satilik-15452002/', '15452002', '2024-07-09 03:07:17', 0),
(1363, 'Bursa Mustafakemalpaşa Da Satilik Sifir Ara Kat Dai̇re', '2.100.000', '2024-07-09 03:07:17', 'Daire | 2+1 | 2. Kat | 120 m2 | 8 Temmuz', 'Bursa - Mustafakemalpaşa - Fevzidede Mh.', NULL, '/ilan/bursa-mustafakemalpasa-da-satilik-sifir-ara-kat-daire-15452107/', '15452107', '2024-07-09 03:07:17', 0),
(1362, 'Başkent Yapi\'dan Cadde Üzeri̇ Sifir Bi̇nada Bu Haftaya Özel Fi̇yat', '1.950.000', '2024-07-09 03:07:17', 'Daire | 2+1 | 3. Kat | 112 m2 | 8 Temmuz', 'İstanbul - Esenyurt - Üçevler Mh.', NULL, '/ilan/baskent-yapi-dan-cadde-uzeri-sifir-binada-bu-haftaya-ozel-fiyat-15452147/', '15452147', '2024-07-09 03:07:17', 0),
(1361, 'Bursa Mustafakemalapşa Atatürk Mh Satilik Dai̇re', '2.500.000', '2024-07-09 03:07:17', 'Daire | 3+1 | Yüksek giriş | 140 m2 | 8 Temmuz', 'Bursa - Mustafakemalpaşa - Atatürk Mh.', NULL, '/ilan/bursa-mustafakemalapsa-ataturk-mh-satilik-daire-15452211/', '15452211', '2024-07-09 03:07:17', 0),
(1360, 'Menemen Esatpaşa Mah. İzban İstasyonuna Çok Yakin Satilik 3+1  D', '2.100.000', '2024-07-09 03:07:17', 'Daire | 3+1 | 4. Kat | 130 m2 | 8 Temmuz', 'İzmir - Menemen - Esatpaşa Mh.', NULL, '/ilan/menemen-esatpasa-mah-izban-istasyonuna-cok-yakin-satilik-31-daire-15452276/', '15452276', '2024-07-09 11:03:16', 2),
(1359, 'Stadyum Karşisi Macera Park Arkasi 3+1 Açik Mutfak Dai̇re', '2.070.000', '2024-07-09 03:07:17', 'Daire | 3+1 | 5. Kat | 145 m2 | 8 Temmuz', 'Adana - Sarıçam - Çarkıpare Mh.', NULL, '/ilan/stadyum-karsisi-macera-park-arkasi-31-acik-mutfak-daire-15452372/', '15452372', '2024-07-09 11:03:16', 2),
(1357, 'Mani̇sa Şehzadeler Halitli Köyü Köy Evi̇ Satilik !!!', '1.500.000', '2024-07-09 03:07:17', 'Köy Evi | 2+1 | 225 m2 | 8 Temmuz', 'Manisa - Şehzadeler - Halıtlı Mh.', NULL, '/ilan/manisa-sehzadeler-halitli-koyu-koy-evi-satilik-15453038/', '15453038', '2024-07-09 03:07:17', 0),
(1358, 'İnderesi̇ Toki̇de Satlik 3+1 Daire Full Yapılı', '1.750.000', '2024-07-09 03:07:17', 'Daire | 3+1 | 5. Kat | 135 m2 | 8 Temmuz', 'Malatya - Battalgazi - Kernek Mh.', NULL, '/ilan/inderesi-tokide-satlik-31-daire-full-yapili-15452687/', '15452687', '2024-07-09 03:07:17', 0),
(1356, 'Karasuda Deni̇ze 100 Mtre Mesafede 1+1', '1.150.000', '2024-07-09 03:07:17', 'Daire | 1+1 | Bahçe katı | 55 m2 | 8 Temmuz', 'Sakarya - Karasu - Yalı Mh.', NULL, '/ilan/karasuda-denize-100-mtre-mesafede-11-15453874/', '15453874', '2024-07-09 03:07:17', 0),
(1355, 'Karasu’da Firsat Havuzlu Vi̇lla', '2.900.000', '2024-07-09 03:07:17', 'Villa | 3+1 | 140 m2 | 8 Temmuz', 'Sakarya - Karasu - Yalı Mh.', NULL, '/ilan/karasu-da-firsat-havuzlu-villa-15454030/', '15454030', '2024-07-09 03:07:17', 0),
(1354, 'Kuşcağiz\'da Asansör İskan Yapili E.banyo Kapali Teras.!!!', '3.739.000', '2024-07-09 03:07:17', 'Daire | 4.5+1 | 4. Kat | 240 m2 | 8 Temmuz', 'Ankara - Keçiören - Atapark Mh.', NULL, '/ilan/kuscagiz-da-asansor-iskan-yapili-e-banyo-kapali-teras-15454639/', '15454639', '2024-07-09 11:03:16', 1),
(1353, 'Bursa Mustafakemalpaşa Yunusemre Mh Satilik Dai̇re!!', '2.950.000', '2024-07-09 03:07:17', 'Daire | 3+1 | 4. Kat | 130 m2 | 8 Temmuz', 'Bursa - Mustafakemalpaşa - Yunus Emre Mh.', NULL, '/ilan/bursa-mustafakemalpasa-yunusemre-mh-satilik-daire-15455075/', '15455075', '2024-07-09 11:03:16', 1),
(1352, 'Vazoya 5 Daki̇ka Yürüme Mesafesi̇nde Satilik 1+1 \'Firsat Dai̇re\'', '4.250.000', '2024-07-09 03:07:17', 'Daire | 1+1 | 2. Kat | 60 m2 | 8 Temmuz', 'Kütahya - Kütahya Merkez - Alipaşa Mh.', NULL, '/ilan/vazoya-5-dakika-yurume-mesafesinde-satilik-11-firsat-daire-15455563/', '15455563', '2024-07-09 11:03:16', 1),
(1351, '𝄞Tek Ve Yetki̇ Belgesi̇ Melodi̇\'den Merkez\'de Haftanin Firsati 3+1', '2.984.000', '2024-07-09 03:07:17', 'Daire | 3+1 | 2. Kat | 130 m2 | 8 Temmuz', 'Balıkesir - Edremit - Akçay Mh.', NULL, '/ilan/tek-ve-yetki-belgesi-melodi-den-merkez-de-haftanin-firsati-31-on-cephe-ayri-mutfak-ara-kat-daire-15455584/', '15455584', '2024-07-09 11:03:16', 2),
(1348, 'Körfexz Mahallesinde Deniz Manzaralı Satılık Geniş 1+1', '7.680.000', '2024-07-09 03:07:17', 'Daire | 1+1 | 5. Kat | 70 m2 | 9 Temmuz', 'İzmir - Bayraklı - Körfez Mh.', NULL, '/ilan/korfez-mahallesinde-deniz-manzarali-satilik-genis-11-15455862/', '15455862', '2024-07-09 11:08:05', 2),
(1349, 'Nergi̇z\'de Bostanli Alt Geçi̇t Yakini 3+1 Dubleks Satilik Dai̇re', '6.360.000', '2024-07-09 03:07:17', 'Daire | 3+1 | 5. Kat | 130 m2 | 8 Temmuz', 'İzmir - Karşıyaka - Nergiz Mh.', NULL, '/ilan/nergiz-de-bostanli-alt-gecit-yakini-31-dubleks-satilik-daire-15455723/', '15455723', '2024-07-09 11:03:16', 1),
(1350, 'Bodrumun Yanı Başında Güllük Mah. Satılık Yazlık', '8.350.000', '2024-07-09 03:07:17', 'Müstakil Ev | 1.5+1 | 220 m2 | 8 Temmuz', 'Muğla - Milas - Güllük Mh.', NULL, '/ilan/bodrumun-yani-basinda-gulluk-mah-satilik-yazlik-15455714/', '15455714', '2024-07-09 11:03:16', 1),
(1390, 'Muğla Fethiye Babataşı Mahallesinde 3+1 Giriş Kat Daire', '4.000.000', '2024-07-09 10:56:24', 'Daire | 3+1 | Yüksek giriş | 130 m2 | 9 Temmuz', 'Muğla - Fethiye - Babataşı Mh.', NULL, '/ilan/mugla-fethiye-babatasi-mahallesinde-31-giris-kat-daire-15459659/', '15459659', '2024-07-09 10:56:24', 0);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `old_prices`
--

CREATE TABLE `old_prices` (
  `id` int(11) NOT NULL,
  `data_id` varchar(255) NOT NULL,
  `prices` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`prices`)),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `old_prices`
--

INSERT INTO `old_prices` (`id`, `data_id`, `prices`, `updated_at`) VALUES
(96, '15444970', '[\"7.500.000\"]', '2024-07-09 11:03:17'),
(95, '15454639', '[\"2.739.000\"]', '2024-07-09 11:03:16'),
(87, '15455584', '[\"1.778.000\",\"1.778.000\"]', '2024-07-09 11:03:16'),
(88, '15452276', '[\"2.100.000\",\"2.100.000\"]', '2024-07-09 11:03:16'),
(89, '15452372', '[\"2.070.000\",\"2.070.000\"]', '2024-07-09 11:03:16'),
(90, '15455862', '[\"2.400.000\",\"6.680.000\"]', '2024-07-09 11:08:05'),
(91, '15455723', '[\"5.250.000\"]', '2024-07-09 11:03:16'),
(92, '15455714', '[\"7.250.000\"]', '2024-07-09 11:03:16'),
(93, '15455563', '[\"1.150.000\"]', '2024-07-09 11:03:16'),
(94, '15455075', '[\"1.850.000\"]', '2024-07-09 11:03:16');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `fetch_log`
--
ALTER TABLE `fetch_log`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `listings`
--
ALTER TABLE `listings`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `old_prices`
--
ALTER TABLE `old_prices`
  ADD PRIMARY KEY (`id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `fetch_log`
--
ALTER TABLE `fetch_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Tablo için AUTO_INCREMENT değeri `listings`
--
ALTER TABLE `listings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1391;

--
-- Tablo için AUTO_INCREMENT değeri `old_prices`
--
ALTER TABLE `old_prices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
