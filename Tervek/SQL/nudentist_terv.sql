-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2023. Máj 14. 11:39
-- Kiszolgáló verziója: 10.4.18-MariaDB
-- PHP verzió: 8.0.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `nudentist_terv`
--
CREATE DATABASE IF NOT EXISTS `nudentist_terv` DEFAULT CHARACTER SET utf8 COLLATE utf8_hungarian_ci;
USE `nudentist_terv`;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `ertekelesek`
--

CREATE TABLE `ertekelesek` (
  `ID` int(11) NOT NULL,
  `orvosID` int(11) NOT NULL,
  `paciensID` int(11) NOT NULL,
  `szoveges` varchar(200) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `csillagok` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `ertekelesek`
--

INSERT INTO `ertekelesek` (`ID`, `orvosID`, `paciensID`, `szoveges`, `csillagok`) VALUES
(2, 3, 6, '', 4),
(3, 4, 6, '', 5),
(4, 1, 6, 'Nagyon jól végezte a kezelést!', 5),
(5, 5, 5, '', 4);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `idopontok`
--

CREATE TABLE `idopontok` (
  `ID` int(11) NOT NULL,
  `orvosID` int(11) NOT NULL,
  `idopont` time NOT NULL,
  `datum` date NOT NULL,
  `paciensID` int(11) NOT NULL,
  `nev` varchar(500) COLLATE utf8_hungarian_ci NOT NULL,
  `email` varchar(500) COLLATE utf8_hungarian_ci NOT NULL,
  `telefonszam` varchar(500) COLLATE utf8_hungarian_ci NOT NULL,
  `status` varchar(200) COLLATE utf8_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `idopontok`
--

INSERT INTO `idopontok` (`ID`, `orvosID`, `idopont`, `datum`, `paciensID`, `nev`, `email`, `telefonszam`, `status`) VALUES
(5, 1, '11:55:00', '2023-03-16', 3, 'Zámbó Illés', 'admin@nudentist.com', '+36205988683', 'Elfogadva'),
(8, 1, '13:50:00', '2023-03-23', 3, 'Lajos', 'Lajos@gmail.com', '0694251567428541', 'Elfogadva'),
(9, 4, '23:04:00', '2036-07-29', 5, 'Szabó Péter', 'szpeter20@gmail.com', '+3620584561825', 'Elutasítva'),
(10, 4, '12:54:00', '2023-03-15', 6, 'Zámbó Illés', 'zamboilles@gmail.com', '+36205988683', 'Elfogadva'),
(11, 2, '14:00:00', '2023-03-21', 6, 'Zámbó Illés', 'zamboilles@gmail.com', '+36205988683', 'Elutasítva'),
(12, 4, '15:25:00', '2023-03-26', 6, 'Zámbó Illés', 'zamboilles@gmail.com', '+36205988683', 'Elutasítva'),
(13, 1, '15:38:00', '2023-03-21', 7, 'Foki Zoltán', 'turrfz@turr.hu', '+36125525235652', 'Elutasítva'),
(14, 2, '13:00:00', '2023-03-16', 7, 'Foki Zoltán', 'turrfz@turr.hu', '+36125525235652', 'Elfogadva'),
(15, 2, '11:01:00', '2023-03-08', 6, 'Zámbó Illés', 'zamboilles@gmail.com', '+36205988683', 'Elfogadva'),
(16, 1, '08:01:00', '2023-03-22', 6, 'Zámbó Illés', 'zamboilles@gmail.com', '+36205988683', 'Elutasítva'),
(17, 2, '13:20:00', '2023-03-17', 3, 'Lajos', 'Lajos@gmail.com', '0694251567428541', 'Elfogadva'),
(18, 2, '13:01:00', '2023-03-18', 7, 'Foki Zoltán', 'turrfz@turr.hu', '+36125525235652', 'Elfogadva'),
(19, 1, '12:30:00', '2023-03-30', 7, 'Foki Zoltán', 'turrfz@turr.hu', '+36125525235652', 'Elfogadva'),
(20, 1, '14:44:00', '2023-03-22', 7, 'Foki Zoltán', 'turrfz@turr.hu', '+36125525235652', 'Elutasítva'),
(21, 4, '14:45:00', '2023-03-22', 6, 'Zámbó Illés', 'zamboilles@gmail.com', '+36205988683', 'Elfogadva'),
(22, 3, '15:45:00', '2023-03-23', 3, 'Lajos', 'Lajos@gmail.com', '0694251567428541', 'Elutasítva'),
(23, 4, '15:54:00', '2023-03-15', 7, 'Foki Zoltán', 'turrfz@turr.hu', '+36125525235652', 'Elfogadva'),
(24, 4, '10:00:00', '2023-03-25', 7, 'Foki Zoltán', 'turrfz@turr.hu', '+36125525235652', 'Elfogadásra vár'),
(25, 1, '10:05:00', '2023-03-10', 7, 'Foki Zoltán', 'turrfz@turr.hu', '+36125525235652', 'Elfogadva'),
(26, 1, '12:00:00', '2023-03-30', 6, 'Zámbó Illés', 'zamboilles@gmail.com', '+36205988683', 'Elfogadva'),
(27, 4, '13:07:00', '2023-03-29', 6, 'Zámbó Illés', 'zamboilles@gmail.com', '+36205988683', 'Elfogadva'),
(28, 4, '12:59:00', '2023-04-19', 6, 'Zámbó Illés', 'zamboilles@gmail.com', '+36205988683', 'Elfogadásra vár'),
(29, 4, '12:01:00', '2023-04-01', 6, 'Zámbó Illés', 'zamboilles@gmail.com', '+36205988683', 'Elfogadásra vár'),
(30, 4, '08:01:00', '2023-04-01', 6, 'Zámbó Illés', 'zamboilles@gmail.com', '+36205988683', 'Elfogadásra vár'),
(31, 1, '11:28:00', '2023-03-29', 6, 'Zámbó Illés', 'zamboilles@gmail.com', '0691132401', 'Elfogadva');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kedvencek`
--

CREATE TABLE `kedvencek` (
  `ID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `orvosID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `kedvencek`
--

INSERT INTO `kedvencek` (`ID`, `userID`, `orvosID`) VALUES
(1, 5, 3),
(2, 5, 5);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kezelesek`
--

CREATE TABLE `kezelesek` (
  `ID` int(11) NOT NULL,
  `neve` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `ar` int(11) NOT NULL,
  `leiras` varchar(1000) COLLATE utf8_hungarian_ci NOT NULL,
  `kategoria` varchar(50) COLLATE utf8_hungarian_ci NOT NULL,
  `kep` varchar(100) COLLATE utf8_hungarian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `kezelesek`
--

INSERT INTO `kezelesek` (`ID`, `neve`, `ar`, `leiras`, `kategoria`, `kep`) VALUES
(1, 'Próba', 5000, 'próba', 'Próbakategória', 'dental-drill.jpg'),
(2, 'Periapikális röntgen', 10000, 'Az ún. periapikális (foggyökércsúcs körüli) röntgenfelvétellel a fog koronájának legfelső pontjától egészen a gyökér legalsó pontjáig mindent láthatunk, a fogat megtámasztó csontállománnyal együtt.', 'Röntgen', 'peri.jpg'),
(3, 'Korona', 5000, 'A korona egyetlen fog helyreállítására szolgál. Amennyiben a helyreállítandó fog koronai része oly mértékben destruálódott, hogy azt töméssel vagy betéttel nem lehet helyreállítani, javasolt a korona készítése. Ha egy fog már elvesztésre került, implantátumre készülő korona lehet a megoldás.', 'Pótlás', 'Korona.jpg'),
(4, 'Ideiglenes fogtömés', 3500, 'Az ideiglenes tömés – ahogy a nevében is benne van – csak egy rövid ideig tartó, áthidaló ellátás. Amíg el nem készül a végleges fogtömés, a fogorvos ezzel az ideiglenes megoldással látja el a fogat.', 'Pótlás', 'fogtomes-utan.jpg'),
(5, 'Nyitott kürett foganként', 45000, 'Lényege ennek a kezelésnek is az, hogy helyreállítsuk a fog rögzítő apparátus megfelelő kapcsolatát. A beavatkozást lehet foganként, valamint kvadránsokként (7-8 fog) végezni, a fogágybetegség mértékétől függően.\r\n', 'Parodontológia', 'tasakKezeles.png'),
(6, 'Csontpótlás', 49500, 'Fogorvosi tekintetben csontpótlásról több esetben beszélhetünk, kezdve az implantációs beavatkozásokat megelőző, a csont térfogatát növelő ún. augmentációs beavatkozásoktól a regeneratív, új csont képződésével járó parodontális műtétekig.\r\nA különböző szituációk és célok más-más eljárást, technikát és csontpótló anyagot is kívánnak. Az alábbiakban ezeket vesszük sorra', 'Szájsebészet', 'csontpot.png'),
(7, 'Láthatatlan fogszabályozás', 495000, 'Az új innovációnak köszönhetően a precíziós 3D tervezés és gyártás segítségével maximális pontossággal a fogakra illeszthető, láthatatlan sínt kap, ami kényelmes, viselése nem jár fájdalommal, nem befolyásolja az étrendet és a komfortérzetet. A kezelés hossza lényegesen rövidebb, mint más, hagyományos eljárással zajló kezelések időtartama!', 'Láthatatlanok', 'lathatatlan.jpg'),
(8, 'Gingivectomia/ínyplasztika (foganként)', 15000, 'Az íny sebészeti eltávolítását gingivectomiának (ínyszövetnek) nevezik. Amikor az íny eltávolodott a fogaktól, mély zsebeket produkálva, gingivectomiára van szükség. A plakkot és a fogkőt a zsebek miatt nehéz eltávolítani. A gingivectomiát általában azelőtt végzik, hogy az ínybetegség károsította volna a fogakat tartó csontot.Az ínyplasztika egy másik kifejezés a parodontális műtétre. Az ínyplasztika abban különbözik a gingivectomiától, hogy az előbbi csak az íny részleges kivágását tartalmazza (plasztika). Ez utóbbi kiküszöböli a gumi teljes területét. ', 'Parodontológia', 'gingivec.jpg');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `orvosok`
--

CREATE TABLE `orvosok` (
  `ID` int(11) NOT NULL,
  `nev` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `password` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `bemutatkozas` varchar(400) COLLATE utf8_hungarian_ci NOT NULL,
  `szakterulet` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `tanulmanyok` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `idopontID` int(11) DEFAULT NULL,
  `kezelesekID` int(11) DEFAULT NULL,
  `telefonszam` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `kep` varchar(200) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `last` datetime NOT NULL DEFAULT current_timestamp(),
  `reg` datetime NOT NULL,
  `jogok` varchar(110) COLLATE utf8_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `orvosok`
--

INSERT INTO `orvosok` (`ID`, `nev`, `email`, `password`, `bemutatkozas`, `szakterulet`, `tanulmanyok`, `idopontID`, `kezelesekID`, `telefonszam`, `kep`, `last`, `reg`, `jogok`) VALUES
(1, 'Takács József', 'takacsJ@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'A célom, hogy a páciensek elégetten távozzanak a rendelőből', 'Fogtechnikus', 'Szegedi Tudományegyetem - Fogorvostudományi Kar', 1, 1, '+36208588421', 'idosebbtalacs', '2023-05-07 12:06:57', '2023-05-07 11:56:48', 'doktor'),
(2, 'Ifjabb Takács József', 'ifjtakacs@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'A rendelő tulajdonsa és egyben a főorvos is.', 'Fogtechnikus,főorvos', 'Szegedi Tudományegyetem - Fogorvostudományi Kar', 2, 2, '+3620588963', 'ifjtakacs', '2023-05-07 12:19:41', '2023-05-07 12:17:07', 'doktor'),
(3, 'Ifjabb Kiss Pista Tamás ', 'IGFPN@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Tamás a legprofibb fogszabályzókkal foglalkozó orvos', 'Dentálhigiénikus', 'Fogászati és Szájsebészeti Oktató Intézet, Semmelweis Egyetem', 1, 3, '616546462484', 'Asztalossimon', '2023-03-06 12:54:03', '0000-00-00 00:00:00', 'doktor'),
(4, 'Kerék Tomázia Éva ', 'k.teve@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Világelső fogorvos', 'Fogszakorvos', 'Semmelweis Egyetem Fogorvostudományi Kar', 2, 4, '+362045963211', 'kerektomazia', '2023-05-07 12:06:41', '0000-00-00 00:00:00', 'doktor'),
(5, 'Zámbó Ilona', 'zamboilona89@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Sziasztok ', ' Parodontológus', 'Szegedi Tudományegyetem - Fogorvostudományi Kar', 1, 5, '0696969696', 'zamboilona', '2023-03-14 09:20:40', '2023-03-20 12:31:00', 'doktor'),
(6, 'Szomorú Ágnes', 'dr.szomoruagnes@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Sziasztok', 'Szájsebész', 'Semmelweis Egyetem Fogorvostudományi Kar', 2, 6, '0620584212', 'szomoruagnes', '2023-03-14 09:27:22', '2023-03-13 14:09:00', 'doktor'),
(7, 'Simonfi Tamás', 'simifi@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Sziasztok', 'Általános fogorvos\r\n', 'Szegedi Tudományegyetem - Fogorvostudományi Kar', 4, 7, '0620458598', 'SimonfiTamas', '2023-03-14 09:32:17', '2023-03-13 14:19:00', 'doktor'),
(8, 'Szabó Petra', 'szpetra20@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Sziasztok', 'Fogorvos asszisztens', 'Semmelweis Egyetem Fogorvostudományi Kar', 2, 3, '06923145812515', 'szabopetra', '2023-03-28 09:02:18', '2023-03-17 11:00:00', 'doktor'),
(9, 'Kiss Tamás', 'kisstamas@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Kiss Tamás profi fogorvos', 'Gyermek- és ifjúsági fogász', 'Semmelweis Egyetem Fogorvostudományi Kar', NULL, NULL, '+36205365214', 'IbrahimLajos', '2023-04-17 13:22:15', '0000-00-00 00:00:00', 'doktor'),
(10, 'Tamás Klára', 't.klara@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Tamás Klára másik fogorvos', 'Szájsebész', 'Szegedi Tudományegyetem - Fogorvostudományi Kar', 3, 2, '06323512612', 'LajosneKlara', '2023-03-06 12:54:03', '0000-00-00 00:00:00', 'doktor'),
(11, 'Lakatos Viktoria', 'lak.vik@gmail.com', '-', 'Sziasztok', 'Takarító', '', NULL, NULL, '', 'lakatosviktoria', '2023-03-17 11:08:04', '2023-03-17 11:00:00', '-'),
(12, 'Csongrádi Daniella', 'csongiD@gmail.com', '-', 'Sziasztok', 'Pénzügyi tanácsadó ', 'Budapesti Gazdasági Egyetem', NULL, NULL, '+36206945221', 'csongradidaniela', '2023-03-17 11:14:04', '2023-03-17 12:00:00', '-'),
(14, 'Györök Ferina', 'gyferi@gmail.com', '-', 'Sziasztok', 'Titkárnő', 'Bajai Szakképzési Centrum Türr István Technikum', NULL, NULL, '+3620456251226', 'gyorokferina', '2023-03-17 11:18:53', '2023-03-17 14:00:00', '-'),
(15, 'Kemény Rozália', 'kemenyrozi@gmail.com', '-', '-', 'Biztonságiőr', '-', NULL, NULL, '', 'kemenyrozalia', '2023-03-17 11:32:38', '0000-00-00 00:00:00', '-'),
(16, 'Kéményseprő Pál', 'kemenyPal@gmail.com', '-', '-', 'Biztonságiőr', '-', NULL, NULL, '-', 'kemenysepropal', '2023-03-17 11:33:54', '2023-03-17 15:00:00', '-');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE `users` (
  `ID` int(11) NOT NULL,
  `nev` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `password` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `telefonszam` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `jogok` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `reg` date NOT NULL DEFAULT current_timestamp(),
  `last` date NOT NULL,
  `kep` varchar(200) COLLATE utf8_hungarian_ci DEFAULT 'admin'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`ID`, `nev`, `email`, `password`, `telefonszam`, `jogok`, `reg`, `last`, `kep`) VALUES
(1, 'Próba Pista', 'probapista@nudentits.com', 'Turr513A', '+3620696969', 'user', '2023-02-02', '2023-02-03', 'idosebbtalacs'),
(4, 'admin', 'admin@nudentist.com', '7af2d10b73ab7cd8f603937f7697cb5fe432c7ff', '+36205988683', 'admin', '2023-02-19', '2023-03-27', 'admin'),
(5, 'Szabó Péter', 'szpeter20@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', '+3620584561825', 'user', '2023-03-03', '2023-05-14', 'szabopetra'),
(6, 'Zámbó Illés', 'zamboilles@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', '+36205988683', 'user', '2023-03-03', '2023-05-07', 'Zambo3'),
(12, 'Vigh Ákos', 'vighakos@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', '+3620696969', 'user', '2023-03-21', '2023-03-21', 'admin'),
(13, 'Baranyi Dániel', 'baranyidaniel@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', '+3620696969', 'user', '2023-03-21', '2023-03-21', 'admin');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `uzenetek`
--

CREATE TABLE `uzenetek` (
  `ID` int(11) NOT NULL,
  `senderID` int(11) NOT NULL,
  `senderType` varchar(20) COLLATE utf8_hungarian_ci NOT NULL,
  `recipientID` int(11) NOT NULL,
  `recipientType` varchar(20) COLLATE utf8_hungarian_ci NOT NULL,
  `title` varchar(50) COLLATE utf8_hungarian_ci NOT NULL,
  `tartalom` varchar(500) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `datum` date NOT NULL,
  `olvasottsag` varchar(20) COLLATE utf8_hungarian_ci NOT NULL DEFAULT 'olvasatlan'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `uzenetek`
--

INSERT INTO `uzenetek` (`ID`, `senderID`, `senderType`, `recipientID`, `recipientType`, `title`, `tartalom`, `datum`, `olvasottsag`) VALUES
(1, 0, '', 0, '', '', NULL, '0000-00-00', 'olvasatlan'),
(2, 0, '', 0, '', '', NULL, '0000-00-00', 'olvasatlan'),
(3, 0, '', 0, '', '', NULL, '0000-00-00', 'olvasatlan'),
(4, 5, 'user', 2, 'doktor', '245gtrh', 'ethtrhtr', '2023-03-20', 'olvasatlan'),
(7, 6, 'user', 6, 'doktor', 'sdafs', 'mmhb , bvhmb  m', '2023-03-29', 'olvasatlan');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `ertekelesek`
--
ALTER TABLE `ertekelesek`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `orvosID` (`orvosID`,`paciensID`),
  ADD KEY `paciensID` (`paciensID`);

--
-- A tábla indexei `idopontok`
--
ALTER TABLE `idopontok`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `orvosID` (`orvosID`),
  ADD KEY `paciensID` (`paciensID`);

--
-- A tábla indexei `kedvencek`
--
ALTER TABLE `kedvencek`
  ADD PRIMARY KEY (`ID`);

--
-- A tábla indexei `kezelesek`
--
ALTER TABLE `kezelesek`
  ADD PRIMARY KEY (`ID`);

--
-- A tábla indexei `orvosok`
--
ALTER TABLE `orvosok`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `idopontID` (`idopontID`,`kezelesekID`),
  ADD KEY `kezelesekID` (`kezelesekID`);

--
-- A tábla indexei `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`);

--
-- A tábla indexei `uzenetek`
--
ALTER TABLE `uzenetek`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `kuldoID` (`senderID`,`recipientID`),
  ADD KEY `paciensID` (`recipientID`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `ertekelesek`
--
ALTER TABLE `ertekelesek`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT a táblához `idopontok`
--
ALTER TABLE `idopontok`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT a táblához `kedvencek`
--
ALTER TABLE `kedvencek`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `kezelesek`
--
ALTER TABLE `kezelesek`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT a táblához `orvosok`
--
ALTER TABLE `orvosok`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=112;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT a táblához `uzenetek`
--
ALTER TABLE `uzenetek`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
