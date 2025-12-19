-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 19, 2025 at 08:48 PM
-- Server version: 8.3.0
-- PHP Version: 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hospital`
--

-- --------------------------------------------------------

--
-- Table structure for table `guest`
--

DROP TABLE IF EXISTS `guest`;
CREATE TABLE IF NOT EXISTS `guest` (
  `GuestID` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `FullName` varchar(100) NOT NULL,
  `Role` enum('Patient','Doctor','Nurse','Admin') NOT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LastLogin` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`GuestID`),
  UNIQUE KEY `Username` (`Username`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `guest`
--

INSERT INTO `guest` (`GuestID`, `Username`, `PasswordHash`, `Email`, `FullName`, `Role`, `CreatedAt`, `LastLogin`) VALUES
(8, 'kabarebe', '0000', 'kabarebe@gmail.com', 'kabarebe denis', 'Admin', '2025-11-20 07:17:23', '2025-12-19 06:38:55'),
(9, 'belyse', '8888', 'belyse@gmail.com', 'belyse umuruta', 'Admin', '2025-11-20 17:01:22', NULL),
(3, 'res', '3333', 'res.com', 'resdo', 'Patient', '2025-11-15 07:40:01', '2025-12-13 05:54:27'),
(4, 'muhire', '4444', 'muhire@gmail.com', 'muhireelie', 'Patient', '2025-11-15 07:42:37', '2025-12-19 06:55:01'),
(5, 'muganga', '2222', 'muganga@gmail.com', 'mugangaalex', 'Admin', '2025-11-19 12:55:17', '2025-12-08 08:12:49'),
(6, 'damour', '2222', 'damour456', 'damourjmv', 'Doctor', '2025-11-19 14:13:29', '2025-11-20 07:21:33'),
(7, 'ikirura', '1111', 'ikirura@gmail.com', 'ikiruralupo', 'Nurse', '2025-11-19 14:21:49', NULL),
(10, 'cedro', '5555', 'cedrokeza@gmail.com', 'ndagijimana cedro', 'Patient', '2025-12-08 08:10:39', '2025-12-08 08:12:16'),
(11, 'darcy', '1111', 'darcy.com', 'darcy ihirwe', 'Doctor', '2025-12-13 06:43:31', NULL),
(12, 'g', '1111', 'g@gmail.com', 'Gatete', 'Patient', '2025-12-17 09:57:15', NULL),
(13, 'rty', '1122', 'rty@gmail.com', 'rtyu', 'Patient', '2025-12-17 10:29:33', NULL),
(14, 'edmon', '9999', 'edmon.com', 'edmon kalisa', 'Nurse', '2025-12-19 06:40:48', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
CREATE TABLE IF NOT EXISTS `invoice` (
  `InvoiceID` int NOT NULL AUTO_INCREMENT,
  `GuestID` int NOT NULL,
  `Amount` decimal(10,2) NOT NULL,
  `Date` date NOT NULL,
  `Type` enum('Room','Service','Treatment') NOT NULL,
  `Reference` varchar(100) DEFAULT NULL,
  `Status` enum('Paid','Unpaid') DEFAULT 'Unpaid',
  PRIMARY KEY (`InvoiceID`),
  KEY `fk_invoice_service` (`GuestID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
CREATE TABLE IF NOT EXISTS `reservation` (
  `ReservationID` int NOT NULL AUTO_INCREMENT,
  `OrderNumber` varchar(50) NOT NULL,
  `GuestID` int NOT NULL,
  `Date` date NOT NULL,
  `Status` enum('Confirmed','Pending','Cancelled') DEFAULT 'Pending',
  `TotalAmount` decimal(10,2) NOT NULL,
  `PaymentMethod` enum('Cash','Card','Insurance') NOT NULL,
  `Notes` text,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ReservationID`),
  UNIQUE KEY `OrderNumber` (`OrderNumber`),
  KEY `GuestID` (`GuestID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reservation_room`
--

DROP TABLE IF EXISTS `reservation_room`;
CREATE TABLE IF NOT EXISTS `reservation_room` (
  `ReservationRoomID` int NOT NULL AUTO_INCREMENT,
  `ReservationID` int NOT NULL,
  `RoomID` int NOT NULL,
  PRIMARY KEY (`ReservationRoomID`),
  KEY `ReservationID` (`ReservationID`),
  KEY `RoomID` (`RoomID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
CREATE TABLE IF NOT EXISTS `room` (
  `RoomID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Description` text,
  `Category` enum('General','Private','ICU','Emergency') NOT NULL,
  `PriceOrValue` decimal(10,2) NOT NULL,
  `Status` enum('Available','Occupied','Maintenance') DEFAULT 'Available',
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `GuestID` int DEFAULT NULL,
  PRIMARY KEY (`RoomID`),
  KEY `fk_room_reservation` (`GuestID`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`RoomID`, `Name`, `Description`, `Category`, `PriceOrValue`, `Status`, `CreatedAt`, `GuestID`) VALUES
(1, '001', 'VIP members', 'Private', 500.00, 'Available', '2025-11-19 12:59:12', NULL),
(2, '002', 'Classic', 'Private', 700.00, 'Available', '0000-00-00 00:00:00', 0),
(3, '003', 'Family', 'General', 200.00, 'Available', '0000-00-00 00:00:00', 0),
(4, '004', 'couple', 'Emergency', 2000.00, 'Available', '0000-00-00 00:00:00', 0),
(5, '005', 'Single', 'ICU', 2500.00, 'Available', '0000-00-00 00:00:00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
CREATE TABLE IF NOT EXISTS `service` (
  `ServiceID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Description` text,
  `Category` enum('Consultation','Surgery','Lab Test','Therapy') NOT NULL,
  `PriceOrValue` decimal(10,2) NOT NULL,
  `Status` enum('Available','Unavailable') DEFAULT 'Available',
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `GuestID` int DEFAULT NULL,
  PRIMARY KEY (`ServiceID`),
  KEY `fk_service_room` (`GuestID`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`ServiceID`, `Name`, `Description`, `Category`, `PriceOrValue`, `Status`, `CreatedAt`, `GuestID`) VALUES
(1, 'surgery', 'table for eight', '', 1000.00, 'Available', '2025-11-19 12:59:52', NULL),
(2, 'relaxation', 'Massage', 'Lab Test', 250.00, 'Available', '0000-00-00 00:00:00', 0),
(3, 'body exercise', 'Gym', '', 900.00, 'Available', '0000-00-00 00:00:00', 0),
(4, 'Meeting', 'Conferance hall', 'Consultation', 50.00, 'Available', '0000-00-00 00:00:00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `service_invoice`
--

DROP TABLE IF EXISTS `service_invoice`;
CREATE TABLE IF NOT EXISTS `service_invoice` (
  `ServiceInvoiceID` int NOT NULL AUTO_INCREMENT,
  `ServiceID` int NOT NULL,
  `InvoiceID` int NOT NULL,
  PRIMARY KEY (`ServiceInvoiceID`),
  KEY `ServiceID` (`ServiceID`),
  KEY `InvoiceID` (`InvoiceID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
CREATE TABLE IF NOT EXISTS `staff` (
  `StaffID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Identifier` varchar(50) NOT NULL,
  `Status` enum('Active','Inactive') DEFAULT 'Active',
  `Location` varchar(100) DEFAULT NULL,
  `Contact` varchar(100) DEFAULT NULL,
  `AssignedSince` date DEFAULT NULL,
  `GuestID` int DEFAULT NULL,
  PRIMARY KEY (`StaffID`),
  UNIQUE KEY `Identifier` (`Identifier`),
  KEY `fk_staff_invoice` (`GuestID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
