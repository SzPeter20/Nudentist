-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Gép: localhost
-- Létrehozás ideje: 2022. Nov 30. 12:49
-- Kiszolgáló verziója: 10.4.22-MariaDB
-- PHP verzió: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `2123szft_pizzeria`
--
CREATE DATABASE IF NOT EXISTS `2123szft_pizzeria` DEFAULT CHARACTER SET utf8 COLLATE utf8_hungarian_ci;
USE `2123szft_pizzeria`;

-- --------------------------------------------------------

--
-- A nézet helyettes szerkezete `cartDetails`
-- (Lásd alább az aktuális nézetet)
--
CREATE TABLE `cartDetails` (
`ID` int(11)
,`userID` int(11)
,`pizzaID` int(11)
,`name` varchar(100)
,`amount` int(11)
,`price` double
,`summary` double
);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `carts`
--

CREATE TABLE `carts` (
  `ID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `pizzaID` int(11) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `orderItems`
--

CREATE TABLE `orderItems` (
  `ID` int(11) NOT NULL,
  `orderID` int(11) NOT NULL,
  `pizzaID` int(11) NOT NULL,
  `pizzaName` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `amount` int(11) NOT NULL,
  `price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `orderItems`
--

INSERT INTO `orderItems` (`ID`, `orderID`, `pizzaID`, `pizzaName`, `amount`, `price`) VALUES
(1, 1, 3, 'Hawaii', 1, 1800),
(2, 1, 2, 'Magyaros', 2, 2890),
(3, 1, 11, 'Bolognai', 1, 3000),
(4, 2, 5, 'Szalámis', 3, 2150),
(5, 2, 6, 'SonGoKu', 3, 2670),
(6, 2, 4, 'Duna', 1, 2400),
(7, 2, 1, 'Négysajtos', 3, 2520),
(8, 2, 2, 'Magyaros', 2, 2890),
(9, 2, 3, 'Hawaii', 1, 1800),
(10, 3, 6, 'SonGoKu', 10, 2670),
(11, 3, 11, 'Bolognai', 5, 3000);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `orders`
--

CREATE TABLE `orders` (
  `ID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `userName` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `userAddress` varchar(200) COLLATE utf8_hungarian_ci NOT NULL,
  `userPhone` varchar(50) COLLATE utf8_hungarian_ci NOT NULL,
  `orderDate` datetime NOT NULL DEFAULT current_timestamp(),
  `summary` double NOT NULL,
  `comment` text COLLATE utf8_hungarian_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `orders`
--

INSERT INTO `orders` (`ID`, `userID`, `userName`, `userAddress`, `userPhone`, `orderDate`, `summary`, `comment`, `status`) VALUES
(1, 5, 'Teszt Elek', '6500 Baja, Bácska tér 1.', '06-30-555-66-77', '2022-11-29 12:57:57', 10580, NULL, 1),
(2, 6, 'Próba Béla', '6500 Baja, Kossuth L. u. 100.', '06-20-333-66-89', '2022-11-29 12:58:46', 32000, NULL, 1),
(3, 7, 'Álmos Géza', '6500 Baja, Petőfi S. u. 48.', '06-70-3345-678', '2022-11-29 12:59:20', 41700, NULL, 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `pizzas`
--

CREATE TABLE `pizzas` (
  `ID` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `price` double NOT NULL,
  `kcal` double DEFAULT NULL,
  `description` text COLLATE utf8_hungarian_ci DEFAULT NULL,
  `filename` varchar(100) COLLATE utf8_hungarian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `pizzas`
--

INSERT INTO `pizzas` (`ID`, `name`, `price`, `kcal`, `description`, `filename`) VALUES
(1, 'Négysajtos', 2520, 1500, 'tészta, szósz, tejföl, mozzarella, trapista, gouda, fetasajt', NULL),
(2, 'Magyaros', 2890, 1800, 'tészta, szósz, tejföl, hagyma, kolbász, sonka, sajt, tojás', NULL),
(3, 'Hawaii', 1800, 1300, 'tészta, szósz, szalonna, ananász, sajt', ''),
(4, 'Duna', 2400, 1000, 'tészta, paradicsomszósz, sonka, hagyma, tojás, sajt', ''),
(5, 'Szalámis', 2150, 1500, 'tészta, szósz, szalámi, sajt', ''),
(6, 'SonGoKu', 2670, 1900, 'tészta, szósz, sonka, gomba, kukorica, sajt', ''),
(11, 'Bolognai', 3000, 2300, 'tészta, bolognai szósz, sajt, tejföl', ''),
(12, 'Tenger gyümölcse', 2890, 1600, 'tészta, szósz, kagyló, rák, polip, kaviár', '');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE `users` (
  `ID` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `email` varchar(200) COLLATE utf8_hungarian_ci NOT NULL,
  `passwd` varchar(40) COLLATE utf8_hungarian_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `address` varchar(200) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `rights` varchar(20) COLLATE utf8_hungarian_ci NOT NULL,
  `reg` datetime NOT NULL DEFAULT current_timestamp(),
  `last` datetime DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`ID`, `name`, `email`, `passwd`, `phone`, `address`, `rights`, `reg`, `last`, `status`) VALUES
(3, 'Adminisztrátor', 'admin@pizza.hu', '86f7e437faa5a7fce15d1ddcb9eaeaea377667b8', '06-70-111-22-33', '6500 Baja, Bácska tér 1.', 'admin', '2022-11-17 11:13:28', '2022-11-29 13:00:02', 1),
(5, 'Teszt Elek', 'teszt1@pizza.hu', '5ea345ab330cf29f81d8de9bf5466f508fe351e1', '06-30-555-66-77', '6500 Baja, Bácska tér 1.', 'user', '2022-11-21 10:14:28', '2022-11-29 12:17:28', 1),
(6, 'Próba Béla', 'teszt2@pizza.hu', '5ea345ab330cf29f81d8de9bf5466f508fe351e1', '06-20-333-66-89', '6500 Baja, Kossuth L. u. 100.', 'user', '2022-11-21 10:18:23', '2022-11-29 12:58:41', 1),
(7, 'Álmos Géza', 'teszt3@pizza.hu', '5ea345ab330cf29f81d8de9bf5466f508fe351e1', '06-70-3345-678', '6500 Baja, Petőfi S. u. 48.', 'user', '2022-11-21 11:20:40', '2022-11-29 12:59:17', 1);

-- --------------------------------------------------------

--
-- Nézet szerkezete `cartDetails`
--
DROP TABLE IF EXISTS `cartDetails`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `cartDetails`  AS   (select `carts`.`ID` AS `ID`,`carts`.`userID` AS `userID`,`carts`.`pizzaID` AS `pizzaID`,`pizzas`.`name` AS `name`,`carts`.`amount` AS `amount`,`pizzas`.`price` AS `price`,`pizzas`.`price` * `carts`.`amount` AS `summary` from (`carts` join `pizzas` on(`carts`.`pizzaID` = `pizzas`.`ID`)))  ;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`ID`);

--
-- A tábla indexei `orderItems`
--
ALTER TABLE `orderItems`
  ADD PRIMARY KEY (`ID`);

--
-- A tábla indexei `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`ID`);

--
-- A tábla indexei `pizzas`
--
ALTER TABLE `pizzas`
  ADD PRIMARY KEY (`ID`);

--
-- A tábla indexei `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `carts`
--
ALTER TABLE `carts`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT a táblához `orderItems`
--
ALTER TABLE `orderItems`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT a táblához `orders`
--
ALTER TABLE `orders`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `pizzas`
--
ALTER TABLE `pizzas`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
