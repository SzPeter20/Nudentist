-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2023. Feb 24. 11:03
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
  `idopont` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `datum` date NOT NULL,
  `paciensID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `idopontok`
--

INSERT INTO `idopontok` (`ID`, `orvosID`, `idopont`, `datum`, `paciensID`) VALUES
(1, 1, '9-12', '2023-02-14', 1);

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
(3, 'Korona', 5000, 'Maga a pápa kiállt ki királlyá vagy beteg leszel', 'potlas'),
(4, 'Ideiglenes fogtömés', 3500, 'Nem végleges fogtömés', 'potlas'),
(5, 'Nyitott kürett foganként', 45000, 'Nem tom ez mi', 'parodontologia'),
(6, 'Csontpótlás', 49500, 'Nincs csont van csont', 'szajsebeszet'),
(7, 'Láthatatlan fogszabályozás', 299900, 'Észrevéhetetlen, nem meglátható fogakat elhelyező aparáció', 'lathatatlanok');

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
  `kep` varchar(200) COLLATE utf8_hungarian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `orvosok`
--

INSERT INTO `orvosok` (`ID`, `nev`, `email`, `password`, `bemutatkozas`, `szakterulet`, `tanulmanyok`, `idopontID`, `kezelesekID`, `telefonszam`, `kep`) VALUES
(1, 'Próba Orvos', 'probaorvos@gmail.com', 'Turr513A', 'fkjdewfhdoa', 'szakterproba', 'egyetemproba', 1, 1, '+36205365214', NULL),
(2, 'Hank Meat', 'Heat@gmail.com', 'asd123', 'sdfgh', 'fva', 'awef', NULL, NULL, '+3456789', NULL),
(3, 'Vlajimir Wielkikutas', 'VIk@Wukk.com', 'asd123', 'asd123', 'asd', '123', NULL, NULL, '', NULL),
(4, 'Vámp Yrokfékegyokrsznak', 'cit@roma.ilhu', 'qwe456', 'qwe456', 'ewq654', 'ewq654', NULL, NULL, '', NULL);

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
(2, 'ADMIN', 'admin@nudentist.com', 'AdminJelszo123', '+36201478965', 'admin', '2023-02-07', '2023-02-07', NULL, NULL),
(3, 'a', 'a@a.a', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', '1', 'user', '2023-02-20', '2023-02-21', NULL, NULL),
(4, 'Zsuga', 'hg@dfgh.rth', '170bec8a686f790c7eb8dfa2fae3cc04d24394d2', '+8971436', 'user', '2023-02-21', '0000-00-00', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `uzenetek`
--

CREATE TABLE `uzenetek` (
  `ID` int(11) NOT NULL,
  `orvosID` int(11) NOT NULL,
  `paciensID` int(11) NOT NULL,
  `tartalom` varchar(500) COLLATE utf8_hungarian_ci NOT NULL,
  `datum` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

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
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `uzenetek`
--
ALTER TABLE `uzenetek`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
