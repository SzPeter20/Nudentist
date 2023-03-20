-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2023. Már 20. 13:31
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
(1, 'Kiss Tamás', 'kisstamas@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Kiss Tamás profi fogorvos', 'Gyermek fogorvos', 'Fogorvos egyetem', 1, 1, '+36205365214', 'IbrahimLajos', '2023-03-20 13:22:22', '0000-00-00 00:00:00', 'doktor'),
(2, 'Tamás Klára', 't.klara@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Tamás Klára másik fogorvos', 'fogkő', 'Fogorvos egyetem', 3, 1, '06323512612', 'LajosneKlara', '2023-03-06 12:54:03', '0000-00-00 00:00:00', 'doktor'),
(3, 'Ifjabb Kiss Pista Tamás ', 'IGFPN@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Tamás a legprofibb fogszabályzókkal foglalkozó orvos', 'Fogkőfényesítő', 'Fogorvos egyetem', 1, 3, '616546462484', 'Asztalossimon', '2023-03-06 12:54:03', '0000-00-00 00:00:00', 'doktor'),
(4, 'Kerék Tomázia Éva ', 'k.teve@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Világelső fogorvos', 'Minden is', 'Fogorvos egyetem', 2, 2, '+362045963211', 'kerektomazia', '2023-03-06 12:54:03', '0000-00-00 00:00:00', 'doktor'),
(5, 'Zámbó Ilona', 'zamboilona89@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Sziasztok ', 'Szájhigénia', 'Fogorvos egyetem', 1, 2, '0696969696', 'zamboilona', '2023-03-14 09:20:40', '2023-03-20 12:31:00', 'doktor'),
(6, 'Szomorú Ágnes', 'dr.szomoruagnes@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Sziasztok', 'Fogtechnikus', 'Fogorvos egyetem', 2, 3, '0620584212', 'szomoruagnes', '2023-03-20 13:11:54', '2023-03-13 14:09:00', 'doktor'),
(7, 'Simonfi Tamás', 'simifi@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Sziasztok', 'Általános fogorvos\r\n', 'Fogorvos egyetem', 4, 5, '0620458598', 'SimonfiTamas', '2023-03-14 09:32:17', '2023-03-13 14:19:00', 'doktor'),
(8, 'Szabó Petra', 'szpetra20@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Sziasztok', 'Fogorvos asszisztens', 'Fogorvos egyetem', 2, 2, '06923145812515', 'szabopetra', '2023-03-20 13:15:57', '2023-03-17 11:00:00', 'doktor'),
(9, 'Lakatos Viktoria', 'lak.vik@gmail.com', '-', 'Sziasztok', 'Takarító', '', NULL, NULL, '', 'lakatosviktoria', '2023-03-17 11:08:04', '2023-03-17 11:00:00', '-'),
(10, 'Csongrádi Daniella', 'csongiD@gmail.com', '-', 'Sziasztok', 'Pénzügyi tanácsadó ', 'Budapesti Gazdasági Egyetem', NULL, NULL, '+36206945221', 'csongradidaniela', '2023-03-17 11:14:04', '2023-03-17 12:00:00', '-'),
(11, 'Féreg Julianna', 'fefejul@gmail.com', '-', 'Egy féreg vagyok', 'Humán erőforrás', 'SOTER-LINE', NULL, NULL, '+25814581455', 'feregjulianna', '2023-03-17 11:16:44', '2023-03-17 14:00:00', '-'),
(12, 'Györök Ferina', 'gyferi@gmail.com', '-', 'Sziasztok', 'Titkárnő', 'Bajai Szakképzési Centrum Türr István Technikum', NULL, NULL, '+3620456251226', 'gyorokferina', '2023-03-17 11:18:53', '2023-03-17 14:00:00', '-'),
(13, 'Kemény Rozália', 'kemenyrozi@gmail.com', '-', '-', 'Biztonságiőr', '-', NULL, NULL, '', 'kemenyrozalia', '2023-03-17 11:32:38', '0000-00-00 00:00:00', '-'),
(14, 'Kéményseprő Pál', 'kemenyPal@gmail.com', '-', '-', 'Biztonságiőr', '-', NULL, NULL, '-', 'kemenysepropal', '2023-03-17 11:33:54', '2023-03-17 15:00:00', '-');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `orvosok`
--
ALTER TABLE `orvosok`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `idopontID` (`idopontID`,`kezelesekID`),
  ADD KEY `kezelesekID` (`kezelesekID`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `orvosok`
--
ALTER TABLE `orvosok`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
