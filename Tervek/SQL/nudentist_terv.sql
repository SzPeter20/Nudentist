-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2023. Ápr 03. 13:54
-- Kiszolgáló verziója: 10.4.6-MariaDB
-- PHP verzió: 7.3.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
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
(1, 6, 5, 'cunci az Ákos', 5);

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
(26, 1, '12:00:00', '2023-03-30', 6, 'Zámbó Illés', 'zamboilles@gmail.com', '+36205988683', 'Elfogadásra vár'),
(27, 4, '13:07:00', '2023-03-29', 6, 'Zámbó Illés', 'zamboilles@gmail.com', '+36205988683', 'Elfogadva'),
(28, 4, '12:59:00', '2023-04-19', 6, 'Zámbó Illés', 'zamboilles@gmail.com', '+36205988683', 'Elfogadásra vár'),
(29, 4, '12:01:00', '2023-04-01', 6, 'Zámbó Illés', 'zamboilles@gmail.com', '+36205988683', 'Elfogadásra vár'),
(30, 4, '08:01:00', '2023-04-01', 6, 'Zámbó Illés', 'zamboilles@gmail.com', '+36205988683', 'Elfogadásra vár');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kezelesek`
--

CREATE TABLE `kezelesek` (
  `ID` int(11) NOT NULL,
  `neve` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `ar` int(11) NOT NULL,
  `leiras` varchar(200) COLLATE utf8_hungarian_ci NOT NULL,
  `kategoria` varchar(50) COLLATE utf8_hungarian_ci NOT NULL,
  `kep` varchar(100) COLLATE utf8_hungarian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `kezelesek`
--

INSERT INTO `kezelesek` (`ID`, `neve`, `ar`, `leiras`, `kategoria`, `kep`) VALUES
(1, 'PRoba', 5000, 'proba', 'probakategoria', 'semmi'),
(2, 'Periapikális röntgen', 10000, 'Az ún. periapikális (foggyökércsúcs körüli) röntgenfelvétellel a fog koronájának legfelső pontjától egészen a gyökér legalsó pontjáig mindent láthatunk, a fogat megtámasztó csontállománnyal együtt.', 'rontgen', 'peri.jpg'),
(3, 'Korona', 5000, 'desc', 'potlas', 'Korona.jpg'),
(4, 'Ideiglenes fogtömés', 3500, 'desc', 'potlas', 'fogtomes-utan.jpg'),
(5, 'Nyitott kürett foganként', 45000, 'desc', 'parodontologia', 'tasakKezeles.png'),
(6, 'Csontpótlás', 49500, 'desc', 'szajsebeszet', 'csontpot.png'),
(7, 'Láthatatlan fogszabályozás', 299900, 'desc', 'lathatatlanok', 'lathatatlan.jpg');

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
(1, 'Kiss Tamás', 'kisstamas@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Kiss Tamás profi fogorvos', 'Gyermek fogorvos', 'Fogorvos egyetem', 1, 1, '+36205365214', 'IbrahimLajos', '2023-03-29 10:13:18', '0000-00-00 00:00:00', 'doktor'),
(2, 'Tamás Klára', 't.klara@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Tamás Klára másik fogorvos', 'fogkő', 'Fogorvos egyetem', 3, 1, '06323512612', 'LajosneKlara', '2023-03-06 12:54:03', '0000-00-00 00:00:00', 'doktor'),
(3, 'Ifjabb Kiss Pista Tamás ', 'IGFPN@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Tamás a legprofibb fogszabályzókkal foglalkozó orvos', 'Fogkőfényesítő', 'Fogorvos egyetem', 1, 3, '616546462484', 'Asztalossimon', '2023-03-06 12:54:03', '0000-00-00 00:00:00', 'doktor'),
(4, 'Kerék Tomázia Éva ', 'k.teve@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Világelső fogorvos', 'Minden is', 'Fogorvos egyetem', 2, 2, '+362045963211', 'kerektomazia', '2023-04-03 13:07:39', '0000-00-00 00:00:00', 'doktor'),
(5, 'Zámbó Ilona', 'zamboilona89@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Sziasztok ', 'Szájhigénia', 'Fogorvos egyetem', 1, 2, '0696969696', 'zamboilona', '2023-03-14 09:20:40', '2023-03-20 12:31:00', 'doktor'),
(6, 'Szomorú Ágnes', 'dr.szomoruagnes@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Sziasztok', 'Fogtechnikus', 'Fogorvos egyetem', 2, 3, '0620584212', 'szomoruagnes', '2023-03-14 09:27:22', '2023-03-13 14:09:00', 'doktor'),
(7, 'Simonfi Tamás', 'simifi@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Sziasztok', 'Általános fogorvos\r\n', 'Fogorvos egyetem', 4, 5, '0620458598', 'SimonfiTamas', '2023-03-14 09:32:17', '2023-03-13 14:19:00', 'doktor'),
(8, 'Szabó Petra', 'szpetra20@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Sziasztok', 'Fogorvos asszisztens', 'Fogorvos egyetem', 2, 2, '06923145812515', 'szabopetra', '2023-03-28 09:02:18', '2023-03-17 11:00:00', 'doktor'),
(9, 'Lakatos Viktoria', 'lak.vik@gmail.com', '-', 'Sziasztok', 'Takarító', '', NULL, NULL, '', 'lakatosviktoria', '2023-03-17 11:08:04', '2023-03-17 11:00:00', '-'),
(10, 'Csongrádi Daniella', 'csongiD@gmail.com', '-', 'Sziasztok', 'Pénzügyi tanácsadó ', 'Budapesti Gazdasági Egyetem', NULL, NULL, '+36206945221', 'csongradidaniela', '2023-03-17 11:14:04', '2023-03-17 12:00:00', '-'),
(11, 'Féreg Julianna', 'fefejul@gmail.com', '-', 'Egy féreg vagyok', 'Humán erőforrás', 'SOTER-LINE', NULL, NULL, '+25814581455', 'feregjulianna', '2023-03-17 11:16:44', '2023-03-17 14:00:00', '-'),
(12, 'Györök Ferina', 'gyferi@gmail.com', '-', 'Sziasztok', 'Titkárnő', 'Bajai Szakképzési Centrum Türr István Technikum', NULL, NULL, '+3620456251226', 'gyorokferina', '2023-03-17 11:18:53', '2023-03-17 14:00:00', '-'),
(13, 'Kemény Rozália', 'kemenyrozi@gmail.com', '-', '-', 'Biztonságiőr', '-', NULL, NULL, '', 'kemenyrozalia', '2023-03-17 11:32:38', '0000-00-00 00:00:00', '-'),
(14, 'Kéményseprő Pál', 'kemenyPal@gmail.com', '-', '-', 'Biztonságiőr', '-', NULL, NULL, '-', 'kemenysepropal', '2023-03-17 11:33:54', '2023-03-17 15:00:00', '-');

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
  `kedvencekID` int(11) DEFAULT NULL,
  `kep` varchar(200) COLLATE utf8_hungarian_ci DEFAULT 'admin'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`ID`, `nev`, `email`, `password`, `telefonszam`, `jogok`, `reg`, `last`, `kedvencekID`, `kep`) VALUES
(1, 'Próba Pista', 'probapista@nudentits.com', 'Turr513A', '+3620696969', 'user', '2023-02-02', '2023-02-03', 1, 'admin'),
(3, 'Lajos', 'Lajos@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', '0694251567428541', 'user', '2023-02-18', '2023-04-03', NULL, 'ramona'),
(4, 'admin', 'admin@nudentist.com', '7af2d10b73ab7cd8f603937f7697cb5fe432c7ff', '+36205988683', 'admin', '2023-02-19', '2023-03-27', NULL, 'admin'),
(5, 'Szabó Péter', 'szpeter20@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', '+3620584561825', 'user', '2023-03-03', '2023-03-21', 6, 'szabopetra'),
(6, 'Zámbó Illés', 'zamboilles@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', '+36205988683', 'user', '2023-03-03', '2023-04-03', 8, 'Zambo3'),
(7, 'Foki Zoltán', 'turrfz@turr.hu', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', '+36125525235652', 'user', '2023-03-03', '2023-03-27', NULL, 'fokizoltan'),
(11, 'fiszfoszxd70', 'fiszfosz.0000@00000000.0000000000', '3810f3c42b21d2bc4f26609152909346c5a04923', '+3ddddddd6xddd', 'user', '2023-03-20', '0000-00-00', NULL, 'admin'),
(12, 'Vigh Ákos', 'vighakos@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', '+3620696969', 'user', '2023-03-21', '2023-03-21', NULL, 'admin'),
(13, 'Baranyi Dániel', 'baranyidaniel@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', '+3620696969', 'user', '2023-03-21', '2023-03-21', NULL, 'admin');

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
(6, 1, 'doktor', 6, 'user', 'sdafs', 'scdasda', '2023-03-22', 'olvasott'),
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
  ADD PRIMARY KEY (`ID`),
  ADD KEY `kedvencekID` (`kedvencekID`);

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
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `idopontok`
--
ALTER TABLE `idopontok`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT a táblához `kezelesek`
--
ALTER TABLE `kezelesek`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT a táblához `orvosok`
--
ALTER TABLE `orvosok`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

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
