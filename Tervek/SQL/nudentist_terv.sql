-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2023. Már 06. 12:55
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
(1, 1, '00:00:09', '2023-02-14', 1, '', '', '', ''),
(4, 0, '14:29:00', '2023-03-07', 3, 'admin@nudentist.com', 'admin@nudentist.com', '+5151354615515614', ''),
(5, 0, '11:55:00', '2023-03-16', 3, 'Zámbó Illés', 'admin@nudentist.com', '+36205988683', ''),
(6, 0, '14:29:00', '2023-03-24', 3, 'Lajos@gmail.com', 'Lajos@gmail.com', 'Lajos@gmail.com', ''),
(7, 2, '14:31:00', '2023-03-28', 3, 'iza@gmail.com', 'Lajos@gmail.com', 'iza@gmail.com', ''),
(8, 1, '13:50:00', '2023-03-23', 3, 'Lajos', 'Lajos@gmail.com', '0694251567428541', ''),
(9, 4, '23:04:00', '2036-07-29', 5, 'Szabó Péter', 'szpeter20@gmail.com', '+3620584561825', ''),
(10, 4, '12:54:00', '2023-03-15', 6, 'Zámbó Illés', 'zamboilles@gmail.com', '+36205988683', '');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kezelesek`
--

CREATE TABLE `kezelesek` (
  `ID` int(11) NOT NULL,
  `neve` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `ar` int(11) NOT NULL,
  `leiras` varchar(200) COLLATE utf8_hungarian_ci NOT NULL,
  `kategoria` varchar(50) COLLATE utf8_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `kezelesek`
--

INSERT INTO `kezelesek` (`ID`, `neve`, `ar`, `leiras`, `kategoria`) VALUES
(1, 'PRoba', 5000, 'proba', 'probakategoria'),
(2, 'Periapikális röntgen', 10000, 'Az ún. periapikális (foggyökércsúcs körüli) röntgenfelvétellel a fog koronájának legfelső pontjától egészen a gyökér legalsó pontjáig mindent láthatunk, a fogat megtámasztó csontállománnyal együtt.', 'rontgen'),
(3, 'Korona', 5000, 'desc', 'potlas'),
(4, 'Ideiglenes fogtömés', 3500, 'desc', 'potlas'),
(5, 'Nyitott kürett foganként', 45000, 'desc', 'parodontologia'),
(6, 'Csontpótlás', 49500, 'desc', 'szajsebeszet'),
(7, 'Láthatatlan fogszabályozás', 299900, 'desc', 'lathatatlanok');

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
  `reg` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `orvosok`
--

INSERT INTO `orvosok` (`ID`, `nev`, `email`, `password`, `bemutatkozas`, `szakterulet`, `tanulmanyok`, `idopontID`, `kezelesekID`, `telefonszam`, `kep`, `last`, `reg`) VALUES
(1, 'Kiss Tamás', 'kisstamas@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Kiss Tamás profi fogorvos', 'Gyermek fogorvos', 'Fogorvos egyetem', 1, 1, '+36205365214', NULL, '2023-03-06 12:54:03', '0000-00-00 00:00:00'),
(2, 'Tamás Klára', 't.klara@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Tamás Klára másik fogorvos', 'fogkő', 'Fogorvos egyetem', NULL, NULL, '06323512612', NULL, '2023-03-06 12:54:03', '0000-00-00 00:00:00'),
(3, 'Ifjabb Kiss Pista Tamás ', 'IGFPN@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Tamás a legprofibb fogszabályzókkal foglalkozó orvos', 'Fogkőfényesítő', 'Fogorvos egyetem', NULL, NULL, '616546462484', NULL, '2023-03-06 12:54:03', '0000-00-00 00:00:00'),
(4, 'Kerék Tomázia Éva ', 'k.teve@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', 'Világelső fogorvos', 'Minden is', 'Fogorvos egyetem', 2, 2, '+362045963211', NULL, '2023-03-06 12:54:03', '0000-00-00 00:00:00');

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
  `kep` varchar(200) COLLATE utf8_hungarian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`ID`, `nev`, `email`, `password`, `telefonszam`, `jogok`, `reg`, `last`, `kedvencekID`, `kep`) VALUES
(1, 'Próba Pista', 'probapista@nudentits.com', 'Turr513A', '+3620696969', 'user', '2023-02-02', '2023-02-03', 1, NULL),
(3, 'Lajos', 'Lajos@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', '0694251567428541', 'user', '2023-02-18', '2023-03-06', NULL, NULL),
(4, 'admin', 'admin@nudentist.com', '7af2d10b73ab7cd8f603937f7697cb5fe432c7ff', '+36205988683', 'admin', '2023-02-19', '2023-03-01', NULL, NULL),
(5, 'Szabó Péter', 'szpeter20@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', '+3620584561825', 'user', '2023-03-03', '2023-03-03', NULL, NULL),
(6, 'Zámbó Illés', 'zamboilles@gmail.com', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', '+36205988683', 'user', '2023-03-03', '2023-03-03', NULL, NULL),
(7, 'Foki Zoltán', 'turrfz@turr.hu', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', '+36125525235652', 'user', '2023-03-03', '2023-03-03', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `uzenetek`
--

CREATE TABLE `uzenetek` (
  `ID` int(11) NOT NULL,
  `orvosID` int(11) NOT NULL,
  `paciensID` int(11) NOT NULL,
  `tartalom` varchar(500) COLLATE utf8_hungarian_ci NOT NULL,
  `targy` varchar(100) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `datum` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `uzenetek`
--

INSERT INTO `uzenetek` (`ID`, `orvosID`, `paciensID`, `tartalom`, `targy`, `datum`) VALUES
(1, 0, 0, '', NULL, '0000-00-00'),
(2, 0, 0, '', NULL, '0000-00-00');

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
  ADD KEY `kuldoID` (`orvosID`,`paciensID`),
  ADD KEY `paciensID` (`paciensID`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `ertekelesek`
--
ALTER TABLE `ertekelesek`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `idopontok`
--
ALTER TABLE `idopontok`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT a táblához `kezelesek`
--
ALTER TABLE `kezelesek`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT a táblához `orvosok`
--
ALTER TABLE `orvosok`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT a táblához `uzenetek`
--
ALTER TABLE `uzenetek`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
