-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 17, 2026 at 02:57 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pptracker`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `transaction_id` bigint(20) UNSIGNED DEFAULT NULL,
  `action` varchar(80) NOT NULL,
  `details` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `user_id`, `transaction_id`, `action`, `details`, `ip_address`, `created_at`) VALUES
(20, 19, NULL, 'Initial administrator created', NULL, '127.0.0.1', '2026-11-13 08:37:15'),
(21, 19, NULL, 'Signed out', NULL, '127.0.0.1', '2026-11-13 08:40:23'),
(22, 19, NULL, 'Signed in', NULL, '127.0.0.1', '2026-11-13 08:42:43'),
(23, 19, NULL, 'Created user account', 'end_user', '127.0.0.1', '2026-11-13 08:43:55'),
(24, 19, NULL, 'Created user account', 'bac_secretariat', '127.0.0.1', '2026-11-13 08:44:50'),
(25, 19, NULL, 'Created user account', 'procurement_officer', '127.0.0.1', '2026-11-13 08:44:51'),
(26, 19, NULL, 'Created user account', 'budget_officer', '127.0.0.1', '2026-11-13 08:44:51'),
(27, 19, NULL, 'Created user account', 'inspection_officer', '127.0.0.1', '2026-11-13 08:44:51'),
(28, 19, NULL, 'Created user account', 'accounting_officer', '127.0.0.1', '2026-11-13 08:44:52'),
(29, 19, NULL, 'Created user account', 'cashier_officer', '127.0.0.1', '2026-11-13 08:44:52'),
(30, 19, NULL, 'Created user account', 'management_viewer', '127.0.0.1', '2026-11-13 08:44:53'),
(31, 19, NULL, 'Updated user account', 'accounting_officer', '127.0.0.1', '2026-11-13 08:52:02'),
(32, 19, NULL, 'Updated user account', 'bac_secretariat', '127.0.0.1', '2026-11-13 08:52:03'),
(33, 19, NULL, 'Updated user account', 'budget_officer', '127.0.0.1', '2026-11-13 08:52:03'),
(34, 19, NULL, 'Updated user account', 'cashier_officer', '127.0.0.1', '2026-11-13 08:52:03'),
(35, 19, NULL, 'Updated user account', 'end_user', '127.0.0.1', '2026-11-13 08:52:03'),
(36, 19, NULL, 'Updated user account', 'inspection_officer', '127.0.0.1', '2026-11-13 08:52:04'),
(37, 19, NULL, 'Updated user account', 'management_viewer', '127.0.0.1', '2026-11-13 08:52:04'),
(38, 19, NULL, 'Updated user account', 'procurement_officer', '127.0.0.1', '2026-11-13 08:52:04'),
(39, 19, NULL, 'Updated user account', 'systemadmin', '127.0.0.1', '2026-11-13 08:52:04'),
(40, 19, NULL, 'Signed in', NULL, '127.0.0.1', '2026-11-13 09:14:29'),
(41, 19, 14, 'Imported transaction', '2026 row 90', '127.0.0.1', '2026-11-13 09:38:07'),
(42, 19, 15, 'Imported transaction', '2026 row 91', '127.0.0.1', '2026-11-13 09:38:07'),
(43, 19, 16, 'Imported transaction', '2026 row 92', '127.0.0.1', '2026-11-13 09:38:07'),
(44, 19, 17, 'Imported transaction', '2026 row 93', '127.0.0.1', '2026-11-13 09:38:07'),
(45, 19, 18, 'Imported transaction', '2026 row 94', '127.0.0.1', '2026-11-13 09:38:07'),
(46, 19, 19, 'Imported transaction', '2026 row 95', '127.0.0.1', '2026-11-13 09:38:07'),
(47, 19, 20, 'Imported transaction', '2026 row 96', '127.0.0.1', '2026-11-13 09:38:07'),
(48, 19, 21, 'Imported transaction', '2026 row 97', '127.0.0.1', '2026-11-13 09:38:07'),
(49, 19, 22, 'Imported transaction', '2026 row 98', '127.0.0.1', '2026-11-13 09:38:07'),
(50, 19, 23, 'Imported transaction', '2026 row 99', '127.0.0.1', '2026-11-13 09:38:07'),
(51, 19, 24, 'Imported transaction', '2026 row 100', '127.0.0.1', '2026-11-13 09:38:07'),
(52, 19, 25, 'Imported transaction', '2026 row 101', '127.0.0.1', '2026-11-13 09:38:07'),
(53, 19, 26, 'Imported transaction', '2026 row 102', '127.0.0.1', '2026-11-13 09:38:07'),
(54, 19, 27, 'Imported transaction', '2026 row 103', '127.0.0.1', '2026-11-13 09:38:07'),
(55, 19, 28, 'Imported transaction', '2026 row 104', '127.0.0.1', '2026-11-13 09:38:07'),
(56, 19, 29, 'Imported transaction', '2026 row 105', '127.0.0.1', '2026-11-13 09:38:07'),
(57, 19, 30, 'Imported transaction', '2026 row 106', '127.0.0.1', '2026-11-13 09:38:07'),
(58, 19, 31, 'Imported transaction', '2026 row 107', '127.0.0.1', '2026-11-13 09:38:07'),
(59, 19, 32, 'Imported transaction', '2026 row 108', '127.0.0.1', '2026-11-13 09:38:07'),
(60, 19, 33, 'Imported transaction', '2026 row 109', '127.0.0.1', '2026-11-13 09:38:07'),
(61, 19, 34, 'Imported transaction', '2026 row 110', '127.0.0.1', '2026-11-13 09:38:07'),
(62, 19, 35, 'Imported transaction', '2026 row 111', '127.0.0.1', '2026-11-13 09:38:07'),
(63, 19, 36, 'Imported transaction', '2026 row 112', '127.0.0.1', '2026-11-13 09:38:07'),
(64, 19, 37, 'Imported transaction', '2026 row 113', '127.0.0.1', '2026-11-13 09:38:07'),
(65, 19, 38, 'Imported transaction', '2026 row 114', '127.0.0.1', '2026-11-13 09:38:07'),
(66, 19, 39, 'Imported transaction', '2026 row 115', '127.0.0.1', '2026-11-13 09:38:07'),
(67, 19, 40, 'Imported transaction', '2026 row 116', '127.0.0.1', '2026-11-13 09:38:07'),
(68, 19, 41, 'Imported transaction', '2026 row 117', '127.0.0.1', '2026-11-13 09:38:07'),
(69, 19, 42, 'Imported transaction', '2026 row 118', '127.0.0.1', '2026-11-13 09:38:07'),
(70, 19, 43, 'Imported transaction', '2026 row 119', '127.0.0.1', '2026-11-13 09:38:07'),
(71, 19, 44, 'Imported transaction', '2026 row 120', '127.0.0.1', '2026-11-13 09:38:07'),
(72, 19, 45, 'Imported transaction', '2026 row 121', '127.0.0.1', '2026-11-13 09:38:07'),
(73, 19, 46, 'Imported transaction', '2026 row 122', '127.0.0.1', '2026-11-13 09:38:07'),
(74, 19, 47, 'Imported transaction', '2026 row 123', '127.0.0.1', '2026-11-13 09:38:07'),
(75, 19, 48, 'Imported transaction', '2026 row 124', '127.0.0.1', '2026-11-13 09:38:07'),
(76, 19, 49, 'Imported transaction', '2026 row 125', '127.0.0.1', '2026-11-13 09:38:07'),
(77, 19, 50, 'Imported transaction', '2026 row 126', '127.0.0.1', '2026-11-13 09:38:07'),
(78, 19, 51, 'Imported transaction', '2026 row 127', '127.0.0.1', '2026-11-13 09:38:07'),
(79, 19, 52, 'Imported transaction', '2026 row 128', '127.0.0.1', '2026-11-13 09:38:07'),
(80, 19, 53, 'Imported transaction', '2026 row 129', '127.0.0.1', '2026-11-13 09:38:07'),
(81, 19, 54, 'Imported transaction', '2026 row 130', '127.0.0.1', '2026-11-13 09:38:07'),
(82, 19, 55, 'Imported transaction', '2026 row 131', '127.0.0.1', '2026-11-13 09:38:07'),
(83, 19, 56, 'Imported transaction', '2026 row 132', '127.0.0.1', '2026-11-13 09:38:07'),
(84, 19, 57, 'Imported transaction', '2026 row 133', '127.0.0.1', '2026-11-13 09:38:07'),
(85, 19, 58, 'Imported transaction', '2026 row 134', '127.0.0.1', '2026-11-13 09:38:07'),
(86, 19, 59, 'Imported transaction', '2026 row 135', '127.0.0.1', '2026-11-13 09:38:07'),
(87, 19, 60, 'Imported transaction', '2026 row 136', '127.0.0.1', '2026-11-13 09:38:07'),
(88, 19, 61, 'Imported transaction', '2026 row 137', '127.0.0.1', '2026-11-13 09:38:07'),
(89, 19, 62, 'Imported transaction', '2026 row 138', '127.0.0.1', '2026-11-13 09:38:07'),
(90, 19, 63, 'Imported transaction', '2026 row 139', '127.0.0.1', '2026-11-13 09:38:07'),
(91, 19, 64, 'Imported transaction', '2026 row 140', '127.0.0.1', '2026-11-13 09:38:07'),
(92, 19, 65, 'Imported transaction', '2026 row 141', '127.0.0.1', '2026-11-13 09:38:07'),
(93, 19, 66, 'Imported transaction', '2026 row 142', '127.0.0.1', '2026-11-13 09:38:07'),
(94, 19, 67, 'Imported transaction', '2026 row 143', '127.0.0.1', '2026-11-13 09:38:07'),
(95, 19, 68, 'Imported transaction', '2026 row 144', '127.0.0.1', '2026-11-13 09:38:07'),
(96, 19, 69, 'Imported transaction', '2026 row 145', '127.0.0.1', '2026-11-13 09:38:07'),
(97, 19, 70, 'Imported transaction', '2026 row 146', '127.0.0.1', '2026-11-13 09:38:07'),
(98, 19, 71, 'Imported transaction', '2026 row 148', '127.0.0.1', '2026-11-13 09:38:07'),
(99, 19, 72, 'Imported transaction', '2026 row 149', '127.0.0.1', '2026-11-13 09:38:07'),
(100, 19, 73, 'Imported transaction', '2026 row 150', '127.0.0.1', '2026-11-13 09:38:07'),
(101, 19, 74, 'Imported transaction', '2026 row 152', '127.0.0.1', '2026-11-13 09:38:07'),
(102, 19, 75, 'Imported transaction', '2026 row 153', '127.0.0.1', '2026-11-13 09:38:07'),
(103, 19, 76, 'Imported transaction', '2026 row 154', '127.0.0.1', '2026-11-13 09:38:07'),
(104, 19, 77, 'Imported transaction', '2026 row 155', '127.0.0.1', '2026-11-13 09:38:07'),
(105, 19, 78, 'Imported transaction', '2026 row 156', '127.0.0.1', '2026-11-13 09:38:07'),
(106, 19, 79, 'Imported transaction', '2026 row 157', '127.0.0.1', '2026-11-13 09:38:07'),
(107, 19, 80, 'Imported transaction', '2026 row 158', '127.0.0.1', '2026-11-13 09:38:07'),
(108, 19, 81, 'Imported transaction', '2026 row 159', '127.0.0.1', '2026-11-13 09:38:07'),
(109, 19, 82, 'Imported transaction', '2026 row 160', '127.0.0.1', '2026-11-13 09:38:07'),
(110, 19, 83, 'Imported transaction', '2026 row 161', '127.0.0.1', '2026-11-13 09:38:07'),
(111, 19, 84, 'Imported transaction', '2026 row 162', '127.0.0.1', '2026-11-13 09:38:07'),
(112, 19, 85, 'Imported transaction', '2026 row 163', '127.0.0.1', '2026-11-13 09:38:07'),
(113, 19, 86, 'Imported transaction', '2026 row 164', '127.0.0.1', '2026-11-13 09:38:07'),
(114, 19, 87, 'Imported transaction', '2026 row 165', '127.0.0.1', '2026-11-13 09:38:07'),
(115, 19, 88, 'Imported transaction', '2026 row 166', '127.0.0.1', '2026-11-13 09:38:07'),
(116, 19, 89, 'Imported transaction', '2026 row 167', '127.0.0.1', '2026-11-13 09:38:07'),
(117, 19, 90, 'Imported transaction', '2026 row 168', '127.0.0.1', '2026-11-13 09:38:07'),
(118, 19, 91, 'Imported transaction', '2026 row 169', '127.0.0.1', '2026-11-13 09:38:07'),
(119, 19, 92, 'Imported transaction', '2026 row 170', '127.0.0.1', '2026-11-13 09:38:07'),
(120, 19, 93, 'Imported transaction', '2026 row 171', '127.0.0.1', '2026-11-13 09:38:07'),
(121, 19, 94, 'Imported transaction', '2026 row 172', '127.0.0.1', '2026-11-13 09:38:07'),
(122, 19, 95, 'Imported transaction', '2026 row 173', '127.0.0.1', '2026-11-13 09:38:07'),
(123, 19, 96, 'Imported transaction', '2026 row 174', '127.0.0.1', '2026-11-13 09:38:07'),
(124, 19, 97, 'Imported transaction', '2026 row 175', '127.0.0.1', '2026-11-13 09:38:07'),
(125, 19, 98, 'Imported transaction', '2026 row 176', '127.0.0.1', '2026-11-13 09:38:07'),
(126, 19, 99, 'Imported transaction', '2026 row 177', '127.0.0.1', '2026-11-13 09:38:07'),
(127, 19, 100, 'Imported transaction', '2026 row 178', '127.0.0.1', '2026-11-13 09:38:07'),
(128, 19, 101, 'Imported transaction', '2026 row 179', '127.0.0.1', '2026-11-13 09:38:07'),
(129, 19, 102, 'Imported transaction', '2026 row 344', '127.0.0.1', '2026-11-13 09:38:07'),
(130, 19, 103, 'Imported transaction', '2026 row 345', '127.0.0.1', '2026-11-13 09:38:07'),
(131, 19, 104, 'Imported transaction', '2026 row 346', '127.0.0.1', '2026-11-13 09:38:07'),
(132, 19, 105, 'Imported transaction', 'SPLIT 2026 row 6', '127.0.0.1', '2026-11-13 09:38:07'),
(133, 19, 106, 'Imported transaction', 'SPLIT 2026 row 7', '127.0.0.1', '2026-11-13 09:38:07'),
(134, 19, 107, 'Imported transaction', 'SPLIT 2026 row 8', '127.0.0.1', '2026-11-13 09:38:07'),
(135, 19, 108, 'Imported transaction', 'SPLIT 2026 row 9', '127.0.0.1', '2026-11-13 09:38:07'),
(136, 19, 109, 'Imported transaction', 'SPLIT 2026 row 10', '127.0.0.1', '2026-11-13 09:38:07'),
(137, 19, NULL, 'Signed out', NULL, '127.0.0.1', '2026-11-13 14:20:31'),
(138, 22, NULL, 'Signed in', NULL, '127.0.0.1', '2026-11-13 14:21:16'),
(139, 22, NULL, 'Signed out', NULL, '127.0.0.1', '2026-11-13 14:55:08'),
(140, 19, NULL, 'Signed in', NULL, '127.0.0.1', '2026-11-13 14:55:32'),
(141, 19, NULL, 'Signed out', NULL, '127.0.0.1', '2026-11-13 15:29:01'),
(142, 21, NULL, 'Signed in', NULL, '127.0.0.1', '2026-11-13 15:29:16'),
(143, 21, NULL, 'Signed out', NULL, '127.0.0.1', '2026-11-16 10:05:11'),
(144, 19, NULL, 'Signed in', NULL, '127.0.0.1', '2026-11-16 10:05:53'),
(145, 19, NULL, 'Signed out', NULL, '127.0.0.1', '2026-11-16 10:08:53'),
(146, 22, NULL, 'Signed in', NULL, '127.0.0.1', '2026-11-16 10:09:24'),
(147, 22, NULL, 'Signed out', NULL, '127.0.0.1', '2026-11-16 10:24:12'),
(148, 19, NULL, 'Signed in', NULL, '127.0.0.1', '2026-11-16 10:24:29'),
(149, 19, 36, 'Updated ORS Management', NULL, '127.0.0.1', '2026-11-16 10:25:10'),
(150, 19, 36, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 10:28:59'),
(151, 19, 36, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 10:29:01'),
(152, 19, 36, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 10:29:05'),
(153, 19, 36, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 10:30:29'),
(154, 19, 36, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 10:30:30'),
(155, 19, 36, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 10:30:31'),
(156, 19, 36, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 10:30:32'),
(157, 19, 36, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 10:30:32'),
(158, 19, 36, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 10:30:33'),
(159, 19, 36, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 10:30:33'),
(160, 19, 36, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 10:30:34'),
(161, 19, 36, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 10:30:34'),
(162, 19, 36, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 10:30:37'),
(163, 19, 36, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 10:30:53'),
(164, 19, 36, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 10:30:54'),
(165, 19, 36, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 10:30:54'),
(166, 19, 36, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 10:30:55'),
(167, 19, 36, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 10:30:55'),
(168, 19, 36, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 10:30:56'),
(169, 19, 36, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 10:30:56'),
(170, 19, 36, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 10:30:57'),
(171, 19, 36, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 10:32:01'),
(172, 19, 63, 'Updated Purchase Requests', NULL, '127.0.0.1', '2026-11-16 10:32:09'),
(173, 19, 63, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 10:33:28'),
(174, 19, 36, 'Updated Purchase Orders / Contracts', NULL, '127.0.0.1', '2026-11-16 10:33:45'),
(175, 19, NULL, 'Signed out', NULL, '127.0.0.1', '2026-11-16 13:17:09'),
(176, 19, NULL, 'Signed in', NULL, '127.0.0.1', '2026-11-16 13:17:36'),
(177, 24, NULL, 'Signed in', NULL, '127.0.0.1', '2026-11-16 13:18:19'),
(178, 24, NULL, 'Signed out', NULL, '127.0.0.1', '2026-11-16 13:20:44'),
(179, 22, NULL, 'Signed in', NULL, '127.0.0.1', '2026-11-16 13:21:01'),
(180, 22, NULL, 'Signed out', NULL, '127.0.0.1', '2026-11-16 13:21:28'),
(181, 19, NULL, 'Signed in', NULL, '127.0.0.1', '2026-11-16 13:21:44'),
(182, 19, NULL, 'Signed out', NULL, '127.0.0.1', '2026-11-16 13:23:21'),
(183, 23, NULL, 'Signed in', NULL, '127.0.0.1', '2026-11-16 13:23:51'),
(184, 23, NULL, 'Signed out', NULL, '127.0.0.1', '2026-11-16 13:24:24'),
(185, 25, NULL, 'Signed in', NULL, '127.0.0.1', '2026-11-16 13:24:52'),
(186, 25, 36, 'Updated IAR Management', NULL, '127.0.0.1', '2026-11-16 13:29:21'),
(187, 25, NULL, 'Signed out', NULL, '127.0.0.1', '2026-11-16 13:30:04'),
(188, 24, NULL, 'Signed in', NULL, '127.0.0.1', '2026-11-16 13:30:52'),
(189, 23, NULL, 'Signed in', NULL, '127.0.0.1', '2026-11-16 13:31:17'),
(190, 23, NULL, 'Signed out', NULL, '127.0.0.1', '2026-11-16 13:31:34'),
(191, 26, NULL, 'Signed in', NULL, '127.0.0.1', '2026-11-16 13:31:50'),
(192, 26, NULL, 'Signed out', NULL, '127.0.0.1', '2026-11-16 13:32:23'),
(193, 19, NULL, 'Signed in', NULL, '127.0.0.1', '2026-11-16 13:32:53'),
(194, 27, NULL, 'Signed in', NULL, '127.0.0.1', '2026-11-16 13:33:18'),
(195, 27, NULL, 'Signed out', NULL, '127.0.0.1', '2026-11-16 13:33:54'),
(196, 28, NULL, 'Signed in', NULL, '127.0.0.1', '2026-11-16 13:34:30'),
(197, 28, NULL, 'Signed out', NULL, '127.0.0.1', '2026-11-16 13:45:00'),
(198, 27, NULL, 'Signed in', NULL, '127.0.0.1', '2026-11-16 13:45:36'),
(199, 27, NULL, 'Signed out', NULL, '127.0.0.1', '2026-11-16 13:46:58'),
(200, 19, NULL, 'Signed in', NULL, '127.0.0.1', '2026-11-16 13:47:20'),
(201, 19, 36, 'Updated Purchase Requests', NULL, '127.0.0.1', '2026-11-16 14:23:19'),
(202, 19, 36, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 14:23:55'),
(203, 19, 36, 'Updated Purchase Orders / Contracts', NULL, '127.0.0.1', '2026-11-16 14:24:24'),
(204, 19, 36, 'Updated Purchase Orders / Contracts', NULL, '127.0.0.1', '2026-11-16 14:24:33'),
(205, 19, 36, 'Updated ORS Management', NULL, '127.0.0.1', '2026-11-16 14:24:53'),
(206, 19, 36, 'Updated JEV Management', NULL, '127.0.0.1', '2026-11-16 14:25:45'),
(207, 19, 36, 'Updated Cashier / Payments', NULL, '127.0.0.1', '2026-11-16 14:26:23'),
(208, 19, 124, 'Created transaction', 'PPT-2026-000124', '127.0.0.1', '2026-11-16 14:29:51'),
(209, 19, 124, 'Updated Purchase Requests', NULL, '127.0.0.1', '2026-11-16 14:30:15'),
(210, 19, 124, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 14:35:37'),
(211, 19, 124, 'Updated Purchase Orders / Contracts', NULL, '127.0.0.1', '2026-11-16 14:37:43'),
(212, 19, 124, 'Updated ORS Management', NULL, '127.0.0.1', '2026-11-16 14:38:40'),
(213, 19, 124, 'Updated IAR Management', NULL, '127.0.0.1', '2026-11-16 14:39:37'),
(214, 19, 124, 'Updated DV Management', NULL, '127.0.0.1', '2026-11-16 14:40:48'),
(215, 19, 124, 'Updated Cashier / Payments', NULL, '127.0.0.1', '2026-11-16 14:41:32'),
(216, 19, 124, 'Updated JEV Management', NULL, '127.0.0.1', '2026-11-16 14:41:59'),
(217, 19, 63, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 14:45:04'),
(218, 19, 36, 'Updated BAC Management', NULL, '127.0.0.1', '2026-11-16 14:45:26');

-- --------------------------------------------------------

--
-- Table structure for table `attachments`
--

CREATE TABLE `attachments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `transaction_id` bigint(20) UNSIGNED NOT NULL,
  `stage` varchar(40) NOT NULL,
  `original_name` varchar(255) NOT NULL,
  `stored_name` varchar(80) NOT NULL,
  `mime_type` varchar(120) NOT NULL,
  `file_size` bigint(20) UNSIGNED NOT NULL,
  `uploaded_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bac_records`
--

CREATE TABLE `bac_records` (
  `transaction_id` bigint(20) UNSIGNED NOT NULL,
  `deliberation_date` date DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `resolution_number` varchar(100) DEFAULT NULL,
  `released_at` datetime DEFAULT NULL,
  `workflow_status` varchar(30) NOT NULL DEFAULT 'Not Started',
  `remarks` text DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bac_records`
--

INSERT INTO `bac_records` (`transaction_id`, `deliberation_date`, `status`, `resolution_number`, `released_at`, `workflow_status`, `remarks`, `updated_by`, `updated_at`) VALUES
(15, '2026-05-13', 'approved/signed', NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(16, '2026-09-23', 'approved/signed', '120', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(17, '2026-09-23', 'approved/signed', '117', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(18, '2026-09-09', 'approved/signed', '111', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(19, '2026-09-09', 'approved/signed', '114', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(20, '2026-09-01', 'approved/signed', '105', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(21, '2026-09-01', 'approved/signed', '108', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(22, '2026-09-01', 'approved/signed', '106', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(23, '2026-09-01', 'approved/signed', '107', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(24, '2026-09-01', 'approved/signed', '108', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(25, '2026-08-13', 'approved/signed', '101', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(26, '2026-08-13', 'approved/signed', '100', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(27, '2026-09-01', 'approved/signed', '104', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(28, '2026-08-13', 'approved/signed', '95', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(29, '2026-06-15', 'approved/signed', '86', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(30, '2026-07-29', 'approved/signed', '94', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(31, NULL, 'approved/signed', NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(32, NULL, 'approved/signed', NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(34, '2026-07-27', 'approved/signed', '94', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(35, '2026-07-07', 'approved/signed', '90', '2026-07-14 00:00:00', 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(36, '2026-07-07', 'approved/signed', '88', '2026-07-14 00:00:00', 'In Progress', NULL, 19, '2026-11-16 14:45:26'),
(37, '2026-07-07', 'approved/signed', '89', '2026-07-14 00:00:00', 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(38, '2026-06-15', 'approved/signed', '82', '2026-06-29 00:00:00', 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(39, '2026-06-15', 'approved/signed', '86', '2026-06-25 00:00:00', 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(40, '2026-06-15', 'approved/signed', '85', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(41, '2026-06-15', 'approved/signed', '83', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(42, '2026-06-15', 'approved/signed', '81', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(43, '2026-06-15', 'approved/signed', '84', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(44, '2026-05-25', 'approved/signed', '68', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(45, '2026-05-13', 'approved/signed', '64', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(46, '2026-03-30', 'approved/signed', '54', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(47, '2026-04-16', 'approved/signed', '62', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(48, '2026-04-16', 'approved/signed', '61', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(49, '2026-03-30', 'approved/signed', '60', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(50, '2026-03-30', 'approved/signed', '56', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(51, '2026-03-30', 'approved/signed', '55', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(52, '2026-03-04', 'approved/signed', '49', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(53, '2026-03-04', 'approved/signed', '50', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(54, '2026-03-04', 'approved/signed', '51', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(55, '2026-02-26', 'approved/signed', '45', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(56, '2026-02-26', 'approved/signed', '42', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(57, '2026-02-26', 'approved/signed', '46', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(58, '2026-02-26', 'approved/signed', '44', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(59, '2026-02-26', 'approved/signed', '43', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(60, '2026-02-26', 'approved/signed', '47', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(61, NULL, 'approved/signed', NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(62, NULL, 'approved/signed', NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(63, '2026-01-19', 'approved/signed', '107', '2026-11-16 14:44:00', 'Completed', NULL, 19, '2026-11-16 14:45:03'),
(64, '2026-01-19', 'approved/signed', NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(65, '2026-02-03', 'approved/signed', '23', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(66, '2026-02-03', 'approved/signed', '28', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(67, '2026-02-03', 'approved/signed', '21', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(68, '2026-02-03', 'approved/signed', '30', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(69, '2026-02-10', 'approved/signed', '34', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(70, '2026-02-18', 'approved/signed', '38', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(71, '2026-02-18', 'approved/signed', '39', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(72, '2026-02-18', 'approved/signed', '37', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(73, '2026-02-10', 'approved/signed', '33', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(74, '2026-02-03', 'approved/signed', '26', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(75, '2026-02-03', 'approved/signed', '30', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(76, '2026-02-03', 'approved/signed', '36', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(77, '2026-01-13', 'approved/signed', '3', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(78, '2026-02-03', 'approved/signed', '23', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(79, '2026-02-03', 'approved/signed', '27', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(80, '2026-02-03', 'approved/signed', '26', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(81, '2026-02-03', 'approved/signed', '29', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(82, '2026-02-03', 'approved/signed', '31', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(83, '2026-02-03', 'approved/signed', '22', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(84, '2026-02-03', 'approved/signed', '25', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(85, '2026-01-13', 'approved/signed', '15', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(86, '2026-01-13', 'approved/signed', '10', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(87, '2026-01-13', 'approved/signed', '14', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(88, '2026-01-13', 'approved/signed', '13', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(89, '2026-01-13', 'approved/signed', '11', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(90, '2026-01-13', 'approved/signed', '16', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(91, '2026-01-13', 'approved/signed', '12', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(92, '2026-01-13', 'approved/signed', '5', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(93, '2026-01-13', 'approved/signed', '8', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(94, '2026-01-13', 'approved/signed', '17', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(95, '2026-01-13', 'approved/signed', '6', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(96, '2026-01-13', 'approved/signed', '9', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(97, '2026-01-13', 'approved/signed', '18', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(98, '2026-01-13', 'approved/signed', '4', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(99, '2026-01-13', 'approved/signed', '3', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(100, '2026-01-13', 'approved/signed', '1', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(101, '2026-01-13', 'approved/signed', '2', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(105, '2026-06-15', 'signed', '80', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(106, '2026-06-15', 'signed', '79', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(107, '2026-06-02', 'signed', '75', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(108, '2026-06-15', 'signed', NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(124, '2026-11-16', 'approved/signed', '90', '2026-11-16 14:35:00', 'Completed', NULL, 19, '2026-11-16 14:35:37');

-- --------------------------------------------------------

--
-- Table structure for table `dv_records`
--

CREATE TABLE `dv_records` (
  `transaction_id` bigint(20) UNSIGNED NOT NULL,
  `dv_date` date DEFAULT NULL,
  `dv_number` varchar(100) DEFAULT NULL,
  `gross_amount` decimal(16,2) DEFAULT NULL,
  `tax` decimal(16,2) DEFAULT NULL,
  `net_amount` decimal(16,2) DEFAULT NULL,
  `received_at` datetime DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `forwarded_returned_date` date DEFAULT NULL,
  `workflow_status` varchar(30) NOT NULL DEFAULT 'Not Started',
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `dv_records`
--

INSERT INTO `dv_records` (`transaction_id`, `dv_date`, `dv_number`, `gross_amount`, `tax`, `net_amount`, `received_at`, `remarks`, `forwarded_returned_date`, `workflow_status`, `updated_by`, `updated_at`) VALUES
(35, NULL, NULL, NULL, NULL, NULL, '2026-04-13 21:39:00', 'Incomplete Attachments', '2026-04-13', 'Not Started', NULL, '2026-11-13 09:38:07'),
(37, '2026-08-10', '01-2026-08-481', 32220.00, 2013.75, 30206.25, '2026-07-28 15:28:00', 'Forwarded to Accountant for Payment', '2026-07-29', 'Not Started', NULL, '2026-11-13 09:38:07'),
(38, NULL, NULL, NULL, NULL, NULL, '2026-07-23 10:52:00', 'Forwarded to Accountant for Payment', '2026-07-23', 'Not Started', NULL, '2026-11-13 09:38:07'),
(39, NULL, NULL, NULL, NULL, NULL, '2026-07-21 04:09:00', 'end user for compliance', '2026-07-28', 'Not Started', NULL, '2026-11-13 09:38:07'),
(40, '2026-08-12', '01-2026-08-487', 180000.00, 11250.00, 168750.00, '2026-08-03 00:00:00', 'Forwarded to Accountant for checking/disbursement', '2026-08-11', 'Not Started', NULL, '2026-11-13 09:38:07'),
(41, '2026-08-12', '01-2026-08-490', 112700.00, 7043.75, 105656.25, '2026-08-03 00:00:00', 'Forwarded to Accountant for checking/disbursement', '2026-08-11', 'Not Started', NULL, '2026-11-13 09:38:07'),
(42, '2026-07-23', NULL, 27450.00, 1372.60, 26077.40, '2026-07-23 10:52:00', 'Forwarded to Accountant for checking/disbursement', '2026-07-23', 'Not Started', NULL, '2026-11-13 09:38:07'),
(124, '2026-11-16', '2-22', 123000.00, 3000.00, 120000.00, '2026-11-16 14:40:00', NULL, '2026-11-16', 'Completed', 19, '2026-11-16 14:40:48');

-- --------------------------------------------------------

--
-- Table structure for table `iar_records`
--

CREATE TABLE `iar_records` (
  `transaction_id` bigint(20) UNSIGNED NOT NULL,
  `iar_number` varchar(100) DEFAULT NULL,
  `inspection_date` date DEFAULT NULL,
  `inspection_result` text DEFAULT NULL,
  `acceptance_date` date DEFAULT NULL,
  `inspector_signed_date` date DEFAULT NULL,
  `workflow_status` varchar(30) NOT NULL DEFAULT 'Not Started',
  `remarks` text DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `iar_records`
--

INSERT INTO `iar_records` (`transaction_id`, `iar_number`, `inspection_date`, `inspection_result`, `acceptance_date`, `inspector_signed_date`, `workflow_status`, `remarks`, `updated_by`, `updated_at`) VALUES
(36, NULL, NULL, NULL, NULL, NULL, 'Not Started', NULL, 25, '2026-11-16 13:29:21'),
(124, '2', '2026-11-16', 'ACCEPTED', '2026-11-16', '2026-11-16', 'Completed', NULL, 19, '2026-11-16 14:39:37');

-- --------------------------------------------------------

--
-- Table structure for table `jev_records`
--

CREATE TABLE `jev_records` (
  `transaction_id` bigint(20) UNSIGNED NOT NULL,
  `jev_date` date DEFAULT NULL,
  `jev_number` varchar(100) DEFAULT NULL,
  `workflow_status` varchar(30) NOT NULL DEFAULT 'Not Started',
  `remarks` text DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jev_records`
--

INSERT INTO `jev_records` (`transaction_id`, `jev_date`, `jev_number`, `workflow_status`, `remarks`, `updated_by`, `updated_at`) VALUES
(36, '2026-11-16', '78778', 'Completed', NULL, 19, '2026-11-16 14:25:45'),
(124, '2026-11-16', '55664', 'Completed', NULL, 19, '2026-11-16 14:41:59');

-- --------------------------------------------------------

--
-- Table structure for table `login_attempts`
--

CREATE TABLE `login_attempts` (
  `attempt_key` char(64) NOT NULL,
  `count` int(10) UNSIGNED NOT NULL,
  `last_attempt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ors_records`
--

CREATE TABLE `ors_records` (
  `transaction_id` bigint(20) UNSIGNED NOT NULL,
  `ors_date` date DEFAULT NULL,
  `received_time` time DEFAULT NULL,
  `ors_number` varchar(100) DEFAULT NULL,
  `uacs_code` varchar(150) DEFAULT NULL,
  `mfo_pap` varchar(200) DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `released_date` date DEFAULT NULL,
  `released_time` time DEFAULT NULL,
  `workflow_status` varchar(30) NOT NULL DEFAULT 'Not Started',
  `remarks` text DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ors_records`
--

INSERT INTO `ors_records` (`transaction_id`, `ors_date`, `received_time`, `ors_number`, `uacs_code`, `mfo_pap`, `amount`, `released_date`, `released_time`, `workflow_status`, `remarks`, `updated_by`, `updated_at`) VALUES
(35, '2026-07-14', '08:59:00', '07-368', '50299030', 'AARC, ALI, ALA, SMEDSS, SIB, EDES, CRFPS', 35550.00, '2026-07-14', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(36, '2026-07-14', '08:59:00', '07-370', '50299030', 'AARC, ALI, ALA, SMEDSS, SIB, EDES, CRFPS', 93382.50, '2026-07-14', '14:25:00', 'Completed', NULL, 19, '2026-11-16 14:24:53'),
(37, '2026-07-14', '08:59:00', '07-369', '50299030', 'ALI, ALA', 32220.00, '2026-07-14', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(38, '2026-06-30', '09:30:00', '06-352', '50203010', 'GAS:GMS', 7000.00, '2026-06-30', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(39, '2026-06-29', '03:30:00', '06-351', '50299030', 'AARC', 29406.00, '2026-06-29', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(40, '2026-06-24', '02:17:00', '06-346', '50299030', 'AARC, ALI, ALA, SMEDSS, SIB, EDES, CRFPS', 180000.00, '2026-06-24', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(41, '2026-06-24', '02:17:00', '06-347', '50299030', 'AARC, ALI, ALA, SMEDSS, SIB, EDES, CRFPS', 112700.00, '2026-06-24', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(42, '2026-06-24', '02:17:00', '06-348', '50213050', 'GAS:GMS', 27450.00, '2026-06-24', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(43, '2026-06-23', '01:37:00', '06-338', '50203010', 'AARC, ALI, ALA, SMEDSS, SIB, EDES, CRFPS', 168498.00, '2026-06-23', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(44, '2026-06-10', '02:50:00', '06-312', '50299030', 'SMEDSS, EDES', 19250.00, '2026-06-10', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(45, NULL, NULL, '06-286A', NULL, NULL, NULL, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(46, '2026-05-19', '05:12:00', '05-278', '50203210', 'PALA', 4704.00, '2026-05-19', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(47, '2026-05-13', '10:25:00', '05-267', '50202010', 'SMEDSS', 8750.00, '2026-05-13', NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(124, '2026-11-16', '14:38:00', '07-370', '50299030', 'AARC, ALI, ALA, SMEDSS, SIB, EDES, CRFPS', 120000.00, '2026-11-16', '14:38:00', 'Completed', NULL, 19, '2026-11-16 14:38:40');

-- --------------------------------------------------------

--
-- Table structure for table `payment_records`
--

CREATE TABLE `payment_records` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `transaction_id` bigint(20) UNSIGNED NOT NULL,
  `payment_date` date DEFAULT NULL,
  `reference_number` varchar(120) DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `workflow_status` varchar(30) NOT NULL DEFAULT 'In Progress',
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_records`
--

INSERT INTO `payment_records` (`id`, `transaction_id`, `payment_date`, `reference_number`, `amount`, `remarks`, `workflow_status`, `created_by`, `created_at`) VALUES
(11, 35, NULL, NULL, 35550.00, NULL, 'In Progress', 19, '2026-11-13 09:38:07'),
(12, 36, NULL, NULL, 93382.50, NULL, 'In Progress', 19, '2026-11-13 09:38:07'),
(13, 39, NULL, NULL, 29406.00, NULL, 'In Progress', 19, '2026-11-13 09:38:07'),
(14, 43, NULL, NULL, 168498.00, NULL, 'In Progress', 19, '2026-11-13 09:38:07'),
(15, 44, NULL, NULL, 19250.00, NULL, 'In Progress', 19, '2026-11-13 09:38:07'),
(16, 46, NULL, NULL, 4704.00, NULL, 'In Progress', 19, '2026-11-13 09:38:07'),
(17, 47, NULL, NULL, 8750.00, NULL, 'In Progress', 19, '2026-11-13 09:38:07'),
(32, 36, '2026-11-16', NULL, 93382.27, NULL, 'Completed', 19, '2026-11-16 14:26:23'),
(34, 124, '2026-11-16', '02-0909-3333', 123000.00, NULL, 'Completed', 19, '2026-11-16 14:41:32');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_orders`
--

CREATE TABLE `purchase_orders` (
  `transaction_id` bigint(20) UNSIGNED NOT NULL,
  `po_number` varchar(100) DEFAULT NULL,
  `po_date` date DEFAULT NULL,
  `supplier` varchar(200) DEFAULT NULL,
  `accountant_received_date` date DEFAULT NULL,
  `coa_received_date` date DEFAULT NULL,
  `procurement_mode` varchar(150) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `quantity` decimal(16,3) DEFAULT NULL,
  `unit` varchar(80) DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `released_time` time DEFAULT NULL,
  `released_date` date DEFAULT NULL,
  `workflow_status` varchar(30) NOT NULL DEFAULT 'Not Started',
  `remarks` text DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_orders`
--

INSERT INTO `purchase_orders` (`transaction_id`, `po_number`, `po_date`, `supplier`, `accountant_received_date`, `coa_received_date`, `procurement_mode`, `description`, `quantity`, `unit`, `amount`, `released_time`, `released_date`, `workflow_status`, `remarks`, `updated_by`, `updated_at`) VALUES
(14, 'PO 2026-10-82', '2026-10-05', 'PROCUREMENT SERVICE', NULL, NULL, 'A TO A', 'office supplies 4th Quarter', NULL, 'pc', 43483.88, '09:50:00', '2026-10-06', 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(15, 'PO 2026-05-53', '2026-05-21', 'COSTSAVERS SUPERMARKET INC.', NULL, '2026-06-08', 'DA', 'Airconditioning unit LSD', NULL, 'UNIT', 39500.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(16, 'CN 2026-09-24', '2026-09-28', 'TUV NORD PHILIPPINES', NULL, NULL, 'DA', 'ISO certifying body for the conduct of ISO 2nd Survellance Audit', NULL, NULL, 83520.00, '09:30:00', '2026-10-01', 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(17, 'PO 2026-09-80', '2026-09-24', 'CY7 CELLPHONE AND ACCESSORIES', NULL, '2026-09-29', 'DA', 'ICT Equipment (tablet & cellphone) for PAHP use of PBD', NULL, 'PAX', 49999.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(18, 'PO 2026-09-81', '2026-09-30', 'CARINDERIAA CARINDERIA', NULL, NULL, NULL, 'Meals and snacks- ISO audit findings and review of procedures of LSD', NULL, 'PAX', 16500.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(19, 'PO 2026-10-83', '2026-10-05', 'SAN JOSE (CABA) MPC', NULL, NULL, NULL, 'Meals and snacks- IT enabled assessment system(IT-EASY) for ARBO', NULL, 'PAX', 140400.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(20, 'PO 2026-09-75', '2026-09-02', 'CARINDERIAA CARINDERIA', NULL, NULL, 'DA', 'Meals and snacks Participation of the 126th Anniversary of Ph Civil Service', NULL, 'PAX', 5250.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(21, 'PO 2026-09-77', '2026-09-08', 'CARINDERIAA CARINDERIA', NULL, NULL, 'DA', 'meals and snacks PARCCOM Regular Meeting', NULL, 'PAX', 9000.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(22, 'PO 2026-09-79', '2026-09-08', 'AJL\'S CATERING SERVICES', NULL, '2026-09-09', 'DA', 'Meals and snacks Capability Enhancement for IT-Easy Implementers through Online Training', NULL, 'PAX', 16800.00, '09:36:00', '2026-09-10', 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(23, 'PO 2026-09-76', '2026-09-08', 'CARINDERIAA CARINDERIA', NULL, NULL, 'DA', 'Meals and snacks Quarterly Performance Monitoring and assessment Legal Services Division', NULL, 'PAX', 16500.00, NULL, '2026-09-08', 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(24, 'PO 2026-09-77', '2026-09-08', 'CARINDERIAA CARINDERIA', NULL, NULL, 'DA', 'meals and snacks Coordination meeting PARCCOM', NULL, NULL, NULL, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(25, 'PO 2026-08-69', '2026-08-17', 'ST. JUDE ENTERPRISES', NULL, '2026-08-25', 'DA', 'Electric Sewing machine(GAD Livelihood skills traning)', NULL, 'UNITS', 107200.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(26, 'PO 2026-08-68', '2026-08-17', 'ALLAN DRY GOODS', NULL, '2026-08-25', 'DA', 'Sewing materials (GAD Livelihood skills traning)', NULL, 'PCS', 28354.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(27, 'PO 2026-09-74', '2026-09-02', 'AC NAVARRO CONSTRUCTION SERVICES AND MATERIALS', NULL, '2026-09-09', 'SVP', 'Supplies and materials for the Project Implementation and provision of business development services to ARB Organizations under VLFED', NULL, 'PCS', 494420.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(28, 'CN 2026-08-18', '2026-08-18', 'BELLA VISTA RESORT', NULL, '2026-08-19', 'DA', 'Workshop on the Updating of Agrarian reform Community Development Plans', NULL, 'PAX', 55800.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(29, 'PO 2026-06-62', '2026-06-23', 'PC4ME ONE STOP COMPUTER CORP.', NULL, '2026-07-20', 'svp', 'ICT EQUIPMENT DARAB use', NULL, NULL, NULL, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(30, 'PO 2026-07-66', '2026-07-29', 'SAN JOSE (CABA) MPC', NULL, NULL, 'DA', 'ARBO Validation @ Cabarsican ARC', NULL, 'PAX', 7500.00, NULL, '2026-08-19', 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(31, NULL, NULL, 'RSRK REALTY', NULL, NULL, NULL, 'OFFICE RENTAL AUGUST', NULL, NULL, NULL, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(32, NULL, NULL, 'CONVERGE', NULL, NULL, NULL, 'INTERNET BILL LTS DIVISION AUGUST', NULL, NULL, 3208.33, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(33, NULL, NULL, 'CENTENNIAL PETRON', NULL, NULL, NULL, 'POL PRODUCTS XJM & SHY JUNE 2026', NULL, NULL, 16476.68, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(34, '2026-07-66', '2026-07-29', 'san Jose (Caba) MPC', NULL, NULL, 'DA', 'MEALS AND SNACKS ARBO VALIDATION AT CABARSICAN ARC', NULL, 'Pax', 7500.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(35, 'PO 2026-07-65', '2026-07-13', 'AJL\'S CATERING SERVICES', '2026-07-15', NULL, 'SVP', 'meals and snacks record\'s inventory and 5s implementation', 150.000, 'pax', 35550.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(36, 'PO 2026-07-64', '2026-07-13', 'AJL\'S CATERING SERVICES', '2026-07-15', NULL, 'SVP', 'ISO 9001:2015 QMS Internal Audit', 217.000, 'pax', 93382.50, '14:24:00', NULL, 'Completed', NULL, 19, '2026-11-16 14:24:24'),
(37, 'CN 2026-07-15', '2026-07-08', 'YNAD\'S PLACE HOTEL & RESORT', '2026-06-29', '2026-07-16', 'SVP', 'UPDATING AND LEVELLING-OFF ON AGRARIAN LAWS WITH RECALIBRATION OF TARGETS', NULL, 'pax', 32220.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(38, 'PO 2026-06-61', '2026-06-23', 'METROVISION', '2026-06-29', '2026-07-08', 'SVP', 'PLAQUE ON CARP ANNIVERSARY', 7.000, 'pax', 7000.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(39, 'CN 2026-06-13', '2026-07-08', 'KELLY 818 CORP./ BLUE MARLIN RESORT', '2026-06-29', '2026-07-16', 'SVP', 'DARAB 1st Semester Assessment and Levelling off activity', 18.000, 'pax', 29406.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(40, 'PO 2026-06-12', '2026-06-22', 'EM ROYALLE', '2026-06-24', '2026-06-30', 'SVP', 'Meals and snacks-Celebration of the CARP Anniversary 2026-Culminating activity', 150.000, 'pax', 180000.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(41, 'CN 2026-06-11', '2026-06-22', 'EM ROYALLE', '2026-06-24', '2026-06-30', 'SVP', 'Joint DAR-SPLIT 2nd Quarter assessment and 1st Semester Review abd planning session and employees day', 90.000, 'PAX', 207000.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(42, 'CN 2026-06-14', '2026-06-22', 'RGPB AIRCON & REFRIGERATION REPAIR SERVICES', '2026-06-24', NULL, 'SVP', 'Periodic Aircondition Cleaning maintenance', NULL, 'LOT', 27450.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(43, 'PO 2026-06-58', '2026-06-23', 'ST. JUDE ENTERPRISES', '2026-06-23', NULL, 'SVP', 'OFFICE SUPPLIES 101 2nd & 3rd Quarter', NULL, 'PIECES', 168498.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(44, 'PO 2026-06-56', '2026-06-11', 'MAYKAN MANGAN CATERING SERVICES', NULL, NULL, 'SVP', 'Consultative meeting with ARB Representatives Relative to Cooperative Conversion Requirements', NULL, 'PAX', 19250.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(45, 'PO 2026-05-54', '2026-05-26', 'San Jose (Caba) MPC', NULL, NULL, 'SVP', 'MEALS & SNACKS MUNICIPAL ORIENTATION / Engage and formalize local partners 9buy-in-session MOA signing)', NULL, 'PAX', 10200.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(46, 'PO 2026-05-50', '2026-05-19', 'LU METRO HOUSEWARE', NULL, NULL, 'SVP', 'Wall fan LSD', 2.000, 'UNITS', 5000.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(47, 'PO 2026-05-49', '2026-05-13', 'carinderiaa carinderia', NULL, NULL, 'SVP', 'Orientation on installation and adoption of scorecards', NULL, NULL, NULL, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(48, 'PO 2026-04-47', '2026-04-27', 'MAYKAN MANGAN CATERING SERVICES', NULL, NULL, 'SVP', 'Meals & snacks FME Turn-over', NULL, 'PAX', 44962.50, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(49, 'PO 2026-04-45', '2026-04-15', 'MAYKAN MANGAN CATERING SERVICES', NULL, NULL, 'SVP', 'meals and snacks- DAR-DTI-DOST Synchronization Planning workshop April  20-21, 2026', NULL, 'PAX', 19200.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(50, 'PO 2026-04-43', '2026-04-14', 'SAn Jose (Caba) MPC', NULL, NULL, 'SVP', 'Legal Services Division Cascading of Agrarian Laws', NULL, 'pax', 81950.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(51, 'CN 2026-04-09', '2026-04-08', 'EM ROYALLE HOTEL & RESORT', NULL, NULL, 'SVP', 'Joint DAR-La Union and SPLIT Project 2026 First Quarter Review and Planning Session (RPS), SPMS and Support to Operations Updates', NULL, 'pax', 118250.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(52, 'PO 2026-03-42', '2026-03-19', 'CArinderiaa Carinderia', NULL, NULL, 'SVP', 'PBD MONTHLY SECTORAL MEETING', NULL, 'PAX', 75600.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(53, 'PO 2026-03-41', '2026-03-05', 'NATIONAL BAZAAR', NULL, NULL, 'SVP', 'WATER DISPENSER', 2.000, 'UNIT', 11990.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(54, 'PO 2026-03-40', '2026-03-05', 'PC4ME', NULL, NULL, 'SVP', 'BIOMETRICS (EDTR)', 1.000, 'UNIT', 4445.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(55, 'PO 2026-03-36', '2026-03-03', 'CArinderiaa Carinderia', NULL, NULL, 'SVP', 'Meals and snacks for visit for home for elderly', NULL, 'pax', 4875.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(56, 'PO 2026-03-35', '2026-03-03', 'CArinderiaa Carinderia', NULL, NULL, 'SVP', 'REGIONAL WMC Participation', NULL, 'pax', 10750.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(57, 'PO 2026-03-37', '2026-03-03', 'micheales botique', NULL, NULL, 'SVP', 'T-SHIRT WOMEN\'S MONTH', NULL, 'pcs', 30750.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(58, 'PO 2026-03-38', '2026-03-03', 'Carinderiaa Carinderia', NULL, NULL, 'SVP', 'FLU VACCINE snacks', NULL, 'SHOTS', 14875.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(59, 'PO 2026-03-34', '2026-03-03', 'Carinderiaa Carinderia', NULL, NULL, 'SVP', 'LAUNCHING AND CULMINATING ACTIVITY', NULL, 'PAX', 70368.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(60, 'CN 2026-02-06', '2026-03-04', 'EM ROYALLE HOTEL & RESORT', NULL, NULL, 'SVP', 'WOMEN\'S FORUM', NULL, 'PAX', 100100.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(61, 'PO 2026-02-25', '2026-02-13', 'SAn Jose (Caba) MPC', NULL, NULL, 'SVP', 'Meals and Snacks - Product development Training', NULL, 'PAX', 22800.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(62, 'PO 2026-02-30', '2026-02-03', 'SAN JOSE CABA', NULL, NULL, 'SVP', 'Provision of Business Development Services BDS under VLFED - new', NULL, 'pax', 79380.00, NULL, '2026-02-12', 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(63, 'PO 2026-02-32', '2026-02-23', 'NORTHERN ASIA', NULL, NULL, 'PB', 'FMEs under BLOCK FARM UNDER SRFPS', NULL, 'units', 5989550.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(64, 'PO 2026-02-31', '2026-02-23', 'NORTHERN ASIA', NULL, NULL, 'PB', 'FMEs under SLSP UNDER CRFPS', NULL, 'UNITS', 2338400.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(65, 'PO 2026-02-21', '2026-02-10', 'Carinderiaa Carinderia', NULL, NULL, 'SVP', 'Meals and Snacks DARAB Personnel meeting of DARPO La Union', NULL, 'PAX', 26460.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(66, 'PO 2026-04-48', '2026-04-27', 'San Jose CABA', NULL, NULL, 'SVP', 'Meals and Snacks -PCIC Updates and underwrites Training', NULL, 'PAX', 11400.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(67, 'PO 2026-03-39', '2026-03-05', 'San Jose CABA', NULL, NULL, 'SVP', 'Meals and Snacks -PBD Lawyering March-August 2026', NULL, 'PAX', 22800.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(68, 'PO 2026-02-21', '2026-02-13', 'San Jose CABA', NULL, NULL, 'SVP', 'Meals and Snacks - BARC Strengthening feb-sept 2026', NULL, 'PAX', 55100.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(69, 'PO 2026-02-30', '2026-02-23', 'SAN JOSE (CABA) MPC', NULL, NULL, 'SVP', 'meals and snacks Business Development Services(BDS) under VLFED', NULL, 'PAX', 79800.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(70, 'PO 2026-02-28', '2026-02-20', 'CARINDERIAA CARINDERIA', NULL, NULL, 'SVP', 'Meals and snacks STOD Quarterly Sectoral meeting CY 2026', NULL, 'PAX', 56160.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(71, 'PO 2026-02-27', '2026-02-20', 'CARINDERIAA CARINDERIA', NULL, NULL, 'SVP', 'LSD QUARTERLY MEETING', NULL, 'PAX', 23800.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(72, 'PO 2026-02-29', '2026-02-20', 'LUMED', NULL, NULL, 'SVP', 'FLU VACCINE snacks', NULL, 'SHOT', 84000.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(73, 'PO 2026-02-23', '2026-02-12', 'ST JUDE ENTERPRISES', NULL, NULL, 'SVP', 'PBD TRAINING SUPPLIES', NULL, 'PAX', 133500.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(74, 'CN 2026-02-02', '2026-02-06', 'CARINDERIAA CARINDERIA', NULL, NULL, 'SVP', 'meals and snacks for the conduct of performance evaluation reformance rewarding and development (PMT)', NULL, 'PAX', 16800.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(75, 'PO 2026-02-24', '2026-02-13', 'SAN JOSE (CABA) MPC', NULL, NULL, 'SVP', 'meals and snacks- BARC Strengthening', NULL, 'PAX', 55100.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(76, 'CN 2026-02-05', '2026-02-16', 'EL CIELITO INN', NULL, NULL, 'SVP', 'meals, snacks, and accommodation for the conduct back to back Orientation on online registration and renewal of SEC and CDA registered ARBO\'s on March 5&6, 2026', NULL, 'PAX', 93250.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(77, 'PO 2026-02-09', '2026-02-03', 'SAN JOSE (CABA) MPC', NULL, NULL, 'SVP', 'Meals and Snacks for trainings and related for Farm Business School (FBS)', NULL, 'PAX', 74100.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(78, 'PO 2026-02-21', '2026-02-10', 'CARINDERIAA CARINDERIA', NULL, NULL, 'SVP', 'DARAB PERSONNEL MEETING', NULL, 'PAX', 26460.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(79, 'PO 2026-02-17', '2026-02-09', 'CARINDERIAA CARINDERIA', NULL, NULL, 'SVP', 'meals and snacks-PARCCOM regular meeting', NULL, 'PAX', 4680.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(80, 'CN 2026-02-02', '2026-02-06', 'CARINDERIAA CARINDERIA', NULL, NULL, 'SVP', 'Meals and snacks-Performance rewarding and development planning by the performance management (PMT)', NULL, 'PAX', 16400.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(81, 'CN 2026-02-02', '2026-02-06', 'CARINDERIAA CARINDERIA', NULL, NULL, 'SVP', 'meals and snacks- National Online Orientation on the Preparation of the FY 2027 agency indicative plan and budget proposal', NULL, 'PAX', 23400.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(82, 'PO 2026-02-18', '2026-02-09', 'ST. JUDE ENTERPRISES', NULL, NULL, 'SVP', 'OFFICE SUPPLIES (1ST QUARTER) regular', NULL, 'PCS', 179135.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(83, 'PO 2026-02-19', '2026-02-09', 'CARINDERIAA CARINDERIA', NULL, NULL, 'SVP', 'meals and snacks- EXPANDED MANCOM MEETING', NULL, 'PAX', 79200.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(84, 'PO 2026-02-20', '2026-02-09', 'CARINDERIAA CARINDERIA', NULL, NULL, 'SVP', 'meals and snacks- OPARPO MEETING', NULL, 'PAX', 47520.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(85, 'PO 2026-02-04', '2026-02-03', 'ST. JUDE ENTERPRISES', NULL, NULL, 'SVP', 'plastic container for major crop based block farm', NULL, 'PCS', 99760.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(86, 'PO 2026-02-05', '2026-02-03', 'VEL SIERA INTEGRATED FARM', NULL, NULL, 'SVP', 'Materials for SLSP (Bokashi & seeds)', NULL, 'PCS', 238600.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(87, 'PO 2026-02-03', '2026-02-04', 'ELYU SUPPLY ENTERPRISES', NULL, NULL, 'SVP', 'Supplies for Major Crop Based block farm', NULL, 'PCS', 23844.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(88, 'PO 2026-02-07', '2026-02-03', 'VEL SIERA INTEGRATED FARM', NULL, NULL, 'SVP', 'Organic Fertilizer & concoctions SLSP', NULL, 'PCS', 87929.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(89, 'PO 2026-02-02', '2026-02-03', 'VEL SIERA INTEGRATED FARM', NULL, NULL, 'SVP', 'Farm inputs SLSP', NULL, 'PCS', 10240.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(90, 'PO 2026-02-08', '2026-02-03', 'VEL SIERA INTEGRATED FARM', NULL, NULL, 'SVP', 'Materials major block based block farm ( gin, beer, sugar cane etc)', NULL, 'PCS', 62800.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(91, 'PO 2026-02-06', '2026-02-03', 'VEL SIERA INTEGRATED FARM', NULL, NULL, 'SVP', 'materials(Seeds & seedling) SLSP', NULL, 'PCS', 69176.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(92, 'PO 2026-02-12', '2026-02-03', 'SAN JOSE (CABA) MPC', NULL, NULL, 'SVP', 'meals and snacks- Partnership Against Hunger and Poverty', NULL, 'PAX', 51300.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(93, 'PO 2026-02-14', '2026-02-03', 'SAN JOSE (CABA) MPC', NULL, NULL, 'SVP', 'meals and snacks- Building/strengthening the credit worthiness of ARBs & ARBOs accessing credit/microfinance (APCP-now ALERT ARBO)', NULL, 'PAX', 51300.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(94, 'PO 2026-02-15', '2026-02-03', 'SAN JOSE (CABA) MPC', NULL, NULL, 'SVP', 'meals and snacks- Development of ARBO as Microfinance Provider', NULL, 'PAX', 25150.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(95, 'PO 2026-02-10', '2026-02-03', 'SAN JOSE (CABA) MPC', NULL, NULL, 'SVP', 'meals and snacks- Social Infrastructure Building', NULL, 'PAX', 531050.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(96, 'PO 2026-02-16', '2026-02-03', 'SAN JOSE (CABA) MPC', NULL, NULL, 'SVP', 'meals and snacks- Major Crop Based Block Farm Productivity Enhancement Implementation', NULL, 'PAX', 395200.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(97, 'PO 2026-02-11', '2026-02-03', 'SAN JOSE (CABA) MPC', NULL, NULL, 'SVP', 'meals and snacks- Sustainable Monitoring and Evaluation (SME)', NULL, 'PAX', 15500.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(98, 'PO 2026-02-13', '2026-02-03', 'SAN JOSE (CABA) MPC', NULL, NULL, 'SVP', 'meals and snacks- Sustainable Livelihood Support Program', NULL, 'PAX', 183920.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(99, 'PO 2026-02-09', '2026-02-03', 'SAN JOSE (CABA) MPC', NULL, NULL, 'SVP', 'meals and snacks- Farm Business School', NULL, 'PAX', 74100.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(100, 'PO 2026-01-01', '2026-01-15', 'SAN JOSE (CABA) MPC', NULL, '2026-01-20', 'SVP', 'Meals and snacks for the Sustainable Development in Silangan Agrarian Reform Community, San Antonio, Aringay, La Union', NULL, 'PAX', 70000.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(101, 'CN 2026-01-01', '2026-01-15', 'MAYKAN MANGAN CATERING SERVICES', NULL, '2026-01-23', 'SVP', 'Meals and snacks- pre-assessment meeting', NULL, 'PAX', 11900.00, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(105, NULL, NULL, 'MAYKAN MANGAN CATERING SERVICES', '2026-06-25', NULL, 'SVP', 'Meals and snacks Continuous Monthly Performance Monitoring and Assessment of SPLIT Project Targets CY 2026', NULL, NULL, NULL, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(106, NULL, NULL, 'MAYKAN MANGAN CATERING SERVICES', '2026-06-26', '2026-06-24', 'SVP', 'ADMINISTRATIVE & OPERATIONAL ALIGNMNET MEETING FOR LTS REORGANIZATION AND PRIJECT SPLIT', NULL, NULL, NULL, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(107, NULL, NULL, 'RANCHEZ EXPRESS TRAVEL & TOUR', '2026-06-03', '2026-06-04', 'SVP', 'Vehicle rental-Pulong-pulong with ICCs/IPs for SPLIT Project Safeguards Implementation of Project SPLIT', NULL, NULL, NULL, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(108, NULL, NULL, 'ST. JUDE ENTERPRISES', '2026-06-25', '2026-06-29', 'SVP', 'SPLIT OFFICE SUPPLIES 101 2nd & 3rd Quarter', NULL, NULL, NULL, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(109, NULL, NULL, 'ELYU SUPPLY ENTERPRISES', NULL, NULL, 'SVP', 'OFFICE FURNITURE (EXECUTIVE SWIVEL CHAIR)', NULL, NULL, NULL, NULL, NULL, 'Not Started', NULL, NULL, '2026-11-13 09:38:07'),
(124, 'PO 2026-07-644', '2026-11-16', 'Ernesto Computerware', '2026-11-16', '2026-11-16', 'SVP', NULL, 6.000, 'units', 120000.00, '14:37:00', '2026-11-16', 'Completed', NULL, 19, '2026-11-16 14:37:43');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_requests`
--

CREATE TABLE `purchase_requests` (
  `transaction_id` bigint(20) UNSIGNED NOT NULL,
  `sequence_number` varchar(50) DEFAULT NULL,
  `pr_date` date DEFAULT NULL,
  `pr_number` varchar(100) DEFAULT NULL,
  `received_at` datetime DEFAULT NULL,
  `particulars` text DEFAULT NULL,
  `quantity` decimal(16,3) DEFAULT NULL,
  `unit` varchar(80) DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `requested_by` varchar(150) DEFAULT NULL,
  `workflow_status` varchar(30) NOT NULL DEFAULT 'In Progress',
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_requests`
--

INSERT INTO `purchase_requests` (`transaction_id`, `sequence_number`, `pr_date`, `pr_number`, `received_at`, `particulars`, `quantity`, `unit`, `amount`, `requested_by`, `workflow_status`, `updated_by`, `updated_at`) VALUES
(14, '', '2026-10-02', '2026-10-102', '2026-10-02 00:00:00', 'office supplies 4th Quarter', NULL, '', 43483.88, 'VALDEMIR VALDEZ', 'Not Started', 19, '2026-11-13 09:38:07'),
(15, '', '2026-05-07', '2026-05-61', '2026-05-07 00:00:00', 'Airconditioning unit LSD', NULL, 'UNIT', 40000.00, 'LOLITA', 'Not Started', 19, '2026-11-13 09:38:07'),
(16, '', '2026-09-07', '2026-09-95', '2026-09-07 00:00:00', 'ISO certifying body for the conduct of ISO 2nd Survellance Audit', NULL, '', 100000.00, 'LORIE', 'Not Started', 19, '2026-11-13 09:38:07'),
(17, '', '2026-09-23', '2026-09-98', '2026-09-23 00:00:00', 'ICT Equipment (tablet & cellphone) for PAHP use of PBD', NULL, 'PAX', 49999.00, 'ADELAIDA ABANSI', 'Not Started', 19, '2026-11-13 09:38:07'),
(18, '', '2026-09-09', '2026-09-97', '2026-09-09 00:00:00', 'Meals and snacks- ISO audit findings and review of procedures of LSD', NULL, 'PAX', 16500.00, 'LOLITA', 'Not Started', 19, '2026-11-13 09:38:07'),
(19, '', '2026-09-09', '2026-09-94', '2026-09-09 00:00:00', 'Meals and snacks- IT enabled assessment system(IT-EASY) for ARBO', NULL, 'PAX', 140400.00, 'Arlene', 'Not Started', 19, '2026-11-13 09:38:07'),
(20, '', '2026-09-01', '2026-08-91', '2026-09-01 00:00:00', 'Meals and snacks Participation of the 126th Anniversary of Ph Civil Service', 15.000, 'PAX', 8750.00, 'NEMIA TATUNAY', 'Not Started', 19, '2026-11-13 09:38:07'),
(21, '', '2026-09-01', '2026-08-88', '2026-09-01 00:00:00', 'meals and snacks PARCCOM Regular Meeting', NULL, 'PAX', 12000.00, 'JOVY ANN DALAY-ON', 'Not Started', 19, '2026-11-13 09:38:07'),
(22, '', '2026-09-01', '2026-08-90', '2026-09-01 00:00:00', 'Meals and snacks Capability Enhancement for IT-Easy Implementers through Online Training', NULL, 'PAX', 16800.00, 'CYRIL REGUCERA', 'Not Started', 19, '2026-11-13 09:38:07'),
(23, '', '2026-09-08', '2026-08-91', '2026-09-08 00:00:00', 'Meals and snacks Quarterly Performance Monitoring and assessment Legal Services Division', NULL, 'PAX', 16500.00, 'LOLITA', 'Not Started', 19, '2026-11-13 09:38:07'),
(24, '', '2026-09-01', '2026-08-89', '2026-09-01 00:00:00', 'meals and snacks Coordination meeting PARCCOM', NULL, 'PAX', 36000.00, 'jovy', 'Not Started', 19, '2026-11-13 09:38:07'),
(25, '', '2026-08-13', '2026-03-54', '2026-08-13 00:00:00', 'Electric Sewing machine(GAD Livelihood skills traning)', 2.000, 'UNITS', 108000.00, 'Arlene', 'Not Started', 19, '2026-11-13 09:38:07'),
(26, '', '2026-08-13', '2026-03-54', NULL, 'Sewing materials (GAD Livelihood skills traning)', NULL, 'PCS', 28370.00, 'Arlene', 'Not Started', 19, '2026-11-13 09:38:07'),
(27, '', '2026-09-01', '2026-08-91A', '2026-09-01 00:00:00', 'Supplies and materials for the Project Implementation and provision of business development services to ARB Organizations under VLFED', NULL, 'PCS', 500000.00, 'CARLITA LINDLEY', 'Not Started', 19, '2026-11-13 09:38:07'),
(28, '', '2026-07-27', '2026-07-83', '2026-07-27 00:00:00', 'Workshop on the Updating of Agrarian reform Community Development Plans', NULL, 'pax', 66600.00, 'MARLYN CARIASO', 'Not Started', 19, '2026-11-13 09:38:07'),
(29, '', '2026-06-15', '2026-06-69', '2026-06-15 00:00:00', 'ICT EQUIPMENT DARAB use', NULL, 'Unit', 78000.00, 'JOSEPHINE BERNAS', 'Not Started', 19, '2026-11-13 09:38:07'),
(30, '', '2026-07-29', '2026-07-82', '2026-07-29 00:00:00', 'ARBO Validation @ Cabarsican ARC', NULL, 'Pax', 7500.00, 'EDNA CATBAGAN', 'Not Started', 19, '2026-11-13 09:38:07'),
(31, '', NULL, '', NULL, 'OFFICE RENTAL AUGUST', NULL, '', NULL, '', 'Not Started', 19, '2026-11-13 09:38:07'),
(32, '', NULL, '', NULL, 'INTERNET BILL LTS DIVISION AUGUST', NULL, '', NULL, '', 'Not Started', 19, '2026-11-13 09:38:07'),
(33, '', NULL, '', NULL, 'POL PRODUCTS XJM & SHY JUNE 2026', NULL, '', NULL, 'LORIE L. Capistrano', 'Not Started', 19, '2026-11-13 09:38:07'),
(34, '', '2026-07-22', '2026-07-82', '2026-07-22 00:00:00', 'MEALS AND SNACKS ARBO VALIDATION AT CABARSICAN ARC', NULL, 'Pax', 7500.00, 'EDNA CATBAGAN', 'Not Started', 19, '2026-11-13 09:38:07'),
(35, '', '2026-06-22', '2026-06-78', '2026-06-22 00:00:00', 'meals and snacks record\'s inventory and 5s implementation', 150.000, 'Pax', 45000.00, 'Gemma M. Verceles', 'Not Started', 19, '2026-11-13 09:38:07'),
(36, '1', '2026-06-29', '2026-06-80', '2026-06-29 00:00:00', 'ISO 9001:2015 QMS Internal Audit', 217.000, 'Pax', 127850.00, 'Engr. Imelda I. Cunanan', 'Completed', 19, '2026-11-16 14:23:19'),
(37, '', '2026-06-29', '2026-06-79', '2026-06-29 00:00:00', 'UPDATING AND LEVELLING-OFF ON AGRARIAN LAWS WITH RECALIBRATION OF TARGETS', NULL, 'pax', 32400.00, 'Lolita Generao', 'Not Started', 19, '2026-11-13 09:38:07'),
(38, '', '2026-06-08', '2026-06-75', '2026-06-08 00:00:00', 'PLAQUE ON CARP ANNIVERSARY', 7.000, 'PIECES', 8400.00, 'Lorie L. Capistrano', 'Not Started', 19, '2026-11-13 09:38:07'),
(39, '', '2026-06-09', '2026-06-77', '2026-06-09 00:00:00', 'DARAB 1st Semester Assessment and Levelling off activity', 18.000, 'pax', 30600.00, 'Josephine Bernas', 'Not Started', 19, '2026-11-13 09:38:07'),
(40, '', '2026-06-08', '2026-06-73', '2026-06-08 00:00:00', 'Meals and snacks-Celebration of the CARP Anniversary 2026-Culminating activity', 150.000, 'pax', 180000.00, 'Ma. Magdalena D. Salting', 'Not Started', 19, '2026-11-13 09:38:07'),
(41, '', '2026-06-04', '2026-06-70', '2026-06-04 00:00:00', 'Joint DAR-SPLIT 2nd Quarter assessment and 1st Semester Review abd planning session and employees day', 90.000, 'pax', 207000.00, 'Ma. Magdalena D. Salting', 'Not Started', 19, '2026-11-13 09:38:07'),
(42, '', '2026-06-08', '2026-06-74', '2026-06-08 00:00:00', 'Periodic Aircondition Cleaning maintenance', NULL, 'LOT', 27450.00, 'VALDEMIR VALDEZ', 'Not Started', 19, '2026-11-13 09:38:07'),
(43, '', '2026-06-09', '2026-06-76', '2026-06-09 00:00:00', 'OFFICE SUPPLIES 101 2nd & 3rd Quarter', NULL, 'PIECES', 175072.00, 'VALDEMIR VALDEZ', 'Not Started', 19, '2026-11-13 09:38:07'),
(44, '', '2026-05-21', '2026-05-67', '2026-05-21 00:00:00', 'Consultative meeting with ARB Representatives Relative to Cooperative Conversion Requirements', NULL, 'pax', 21000.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(45, '', '2026-05-07', '2026-05-62', '2026-05-07 00:00:00', 'MEALS & SNACKS MUNICIPAL ORIENTATION / Engage and formalize local partners 9buy-in-session MOA signing)', NULL, 'pax', 10500.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(46, '', '2026-03-16', '2026-03-50', '2026-03-16 00:00:00', 'Wall fan LSD', 2.000, 'UNITS', 5000.00, 'LSD', 'Not Started', 19, '2026-11-13 09:38:07'),
(47, '', '2026-04-13', '2026-04-56', '2026-04-13 00:00:00', 'Meals and snacks on Orientation on installation and adoption of scorecards', NULL, 'PAX', 8750.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(48, '', NULL, '', NULL, 'Meals & snacks FME Turn-over', NULL, 'PAX', 45080.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(49, '', '2026-03-26', '2026-03-55', '2026-03-26 00:00:00', 'meals and snacks- DAR-DTI-DOST Synchronization Planning workshop April  20-21, 2026', NULL, 'pax', 19200.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(50, '', '2026-03-12', '2026-03-48', NULL, 'Legal Services Division Cascading of Agrarian Laws', NULL, 'pax', 82500.00, 'Lolita Generao', 'Not Started', 19, '2026-11-13 09:38:07'),
(51, '', '2026-03-19', '2026-03-51', NULL, 'Joint DAR-La Union and SPLIT Project 2026 First Quarter Review and Planning Session (RPS), SPMS and Support to Operations Updates', NULL, 'pax', 200100.00, 'Ma. Magsdalena Salting', 'Not Started', 19, '2026-11-13 09:38:07'),
(52, '', '2026-02-26', '2026-05-44A', '2026-02-26 00:00:00', 'PBD MONTHLY SECTORAL MEETING', NULL, 'PAX', 77000.00, 'MARLYN CARIASO', 'Not Started', 19, '2026-11-13 09:38:07'),
(53, '', '2026-02-26', '2026-02-44', '2026-02-26 00:00:00', 'WATER DISPENSER', 2.000, 'UNIT', 20000.00, 'Engr. Imelda I. Cunanan', 'Not Started', 19, '2026-11-13 09:38:07'),
(54, '', '2026-02-26', '2026-02-43', '2026-02-26 00:00:00', 'BIOMETRICS (EDTR)', 1.000, 'UNIT', 5000.00, 'Engr. Imelda I. Cunanan', 'Not Started', 19, '2026-11-13 09:38:07'),
(55, '', '2026-02-19', '2026-02-37', '2026-02-19 00:00:00', 'Meals and snacks for visit for home for elderly', NULL, 'PAX', 5000.00, 'Editha Ramolete', 'Not Started', 19, '2026-11-13 09:38:07'),
(56, '', '2026-02-19', '2026-02-38', '2026-02-19 00:00:00', 'REGIONAL WMC Participation', NULL, 'pax', 11250.00, 'Editha Ramolete', 'Not Started', 19, '2026-11-13 09:38:07'),
(57, '', '2026-02-19', '2026-02-39', '2026-02-19 00:00:00', 'T-SHIRT WOMEN\'S MONTH', NULL, 'pcs', 30750.00, 'Editha Ramolete', 'Not Started', 19, '2026-11-13 09:38:07'),
(58, '', '2026-02-19', '2026-02-42', '2026-02-19 00:00:00', 'FLU VACCINE snacks', NULL, 'SHOTS', 17000.00, 'Editha Ramolete', 'Not Started', 19, '2026-11-13 09:38:07'),
(59, '', '2026-02-19', '2026-02-41', '2026-02-19 00:00:00', 'LAUNCHING AND CULMINATING ACTIVITY', NULL, 'PCS', 72000.00, 'Editha Ramolete', 'Not Started', 19, '2026-11-13 09:38:07'),
(60, '', '2026-02-19', '2026-02-40', '2026-02-19 00:00:00', 'WOMEN\'S FORUM', NULL, 'PAX', 109200.00, 'Editha Ramolete', 'Not Started', 19, '2026-11-13 09:38:07'),
(61, '', '2026-01-12', '46041', '2026-01-12 00:00:00', 'Meals and Snacks - Product development Training', NULL, 'PAX', 25100.00, 'EVANGELINE ABACO', 'Not Started', 19, '2026-11-13 09:38:07'),
(62, '', '2026-02-06', '2026-02-32', '2026-02-06 00:00:00', 'Provision of Business Development Services BDS under VLFED - new', NULL, 'PAX', 79800.00, 'Carlita Lindley', 'Not Started', 19, '2026-11-13 09:38:07'),
(63, NULL, '2025-12-02', '46032', '2026-01-28 00:00:00', 'FMEs under BLOCK FARM UNDER CRFPS', NULL, 'units', 6000000.00, 'PBD', 'Not Started', 19, '2026-11-16 10:32:09'),
(64, '', NULL, '', NULL, 'FMEs under SLSP UNDER CRFPS', NULL, 'pax', 2400000.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(65, '', '2026-01-28', '46049', '2026-01-28 00:00:00', 'Meals and Snacks DARAB Personnel meeting of DARPO La Union', NULL, 'pax', 27000.00, 'JOSIE BERNAS', 'Not Started', 19, '2026-11-13 09:38:07'),
(66, '', '2026-01-23', '46047', '2026-01-23 00:00:00', 'PCIC Updates and underwrites Training', NULL, 'pax', 11400.00, 'JAN LESTER SIOBAL', 'Not Started', 19, '2026-11-13 09:38:07'),
(67, '', '2026-01-07', '46039', '2026-01-07 00:00:00', 'PBD Lawyering March-August 2026', NULL, 'pax', 22800.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(68, '', '2026-01-12', '46042', '2026-01-12 00:00:00', 'BARC Strengthening feb-sept 2026', NULL, 'pax', 55100.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(69, '', '2026-02-06', '2026-02-32', '2026-02-06 00:00:00', 'meals and snacks Business Development Services(BDS) under VLFED', NULL, 'pax', 79800.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(70, '', '2026-02-10', '2026-02-35', '2026-02-10 00:00:00', 'Meals and snacks STOD Quarterly Sectoral meeting CY 2026', NULL, 'pax', 57600.00, 'STOD', 'Not Started', 19, '2026-11-13 09:38:07'),
(71, '', '2026-02-13', '2026-02-36', '2026-02-13 00:00:00', 'LSD QUARTERLY MEETING', NULL, 'PAX', 25500.00, 'LOLITA GENERAO', 'Not Started', 19, '2026-11-13 09:38:07'),
(72, '', '2026-02-10', '2026-02-34', '2026-02-10 00:00:00', 'FLU VACCINE snacks', NULL, 'SHOTS', 84000.00, 'EDITHA RAMOLETE', 'Not Started', 19, '2026-11-13 09:38:07'),
(73, '', '2026-01-29', '46051', '2026-01-29 00:00:00', 'PBD TRAINING SUPPLIES', NULL, 'PCS', 133500.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(74, '', '2026-01-28', '46048', '2026-01-28 00:00:00', 'meals and snacks for the conduct of performance evaluation reformance rewarding and development (PMT)', NULL, 'PAX', 16800.00, 'NEMIA THEODORA TATUNAY', 'Not Started', 19, '2026-11-13 09:38:07'),
(75, '', '2026-01-12', '46042', '2026-01-12 00:00:00', 'meals and snacks- BARC Strengthening', NULL, 'PAX', 55100.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(76, '', '2027-02-04', '2026-02-31A', '2027-02-04 00:00:00', 'meals, snacks, and accommodation for the conduct back to back Orientation on online registration and renewal of SEC and CDA registered ARBO\'s on March 5&6, 2026', NULL, 'PAX', 107500.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(77, '', '2026-12-02', '46026', '2026-12-02 00:00:00', 'Meals and Snacks for trainings and related for Farm Business School (FBS)', NULL, 'PAX', 74100.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(78, '', '2026-01-28', '46049', '2026-01-28 00:00:00', 'DARAB PERSONNEL MEETING', NULL, 'PAX', 27000.00, 'JOSIE BERNAS', 'Not Started', 19, '2026-11-13 09:38:07'),
(79, '', '2026-01-22', '46046', '2026-01-22 00:00:00', 'meals and snacks-PARCCOM regular meeting', NULL, 'PAX', 4800.00, 'JOVY ANNE DALAY-ON', 'Not Started', 19, '2026-11-13 09:38:07'),
(80, '', '2026-01-28', '46048', '2026-01-28 00:00:00', 'Meals and snacks-Performance rewarding and development planning by the performance management (PMT)', NULL, 'PAX', 16800.00, 'NEMIA THEODORA TATUNAY', 'Not Started', 19, '2026-11-13 09:38:07'),
(81, '', '2026-01-20', '46045', '2026-01-20 00:00:00', 'meals and snacks- National Online Orientation on the Preparation of the FY 2027 agency indicative plan and budget proposal', NULL, 'PAX', 24000.00, 'STOD', 'Not Started', 19, '2026-11-13 09:38:07'),
(82, '', '2026-01-28', '46050', '2026-01-28 00:00:00', 'OFFICE SUPPLIES (1ST QUARTER) regular', NULL, 'PCS', 180497.00, 'VALDEMIR VALDEZ', 'Not Started', 19, '2026-11-13 09:38:07'),
(83, '', '2026-01-19', '46044', '2026-01-19 00:00:00', 'meals and snacks- EXPANDED MANCOM MEETING', NULL, 'PAX', 81000.00, 'MONICA ASHLEY CABADING', 'Not Started', 19, '2026-11-13 09:38:07'),
(84, '', '2026-01-19', '46043', '2026-01-19 00:00:00', 'meals and snacks- OPARPO MEETING', NULL, 'PAX', 48600.00, 'MONICA ASHLEY CABADING', 'Not Started', 19, '2026-11-13 09:38:07'),
(85, '', '2026-12-02', '46031', '2026-12-02 00:00:00', 'plastic container for major crop based block farm', NULL, 'PCS', 395200.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(86, '', '2026-12-02', '46029', '2026-12-02 00:00:00', 'Materials for SLSP (Bokashi & seeds)', NULL, 'PCS', 238600.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(87, '', '2026-12-02', '46031', '2026-12-02 00:00:00', 'Supplies for Major Crop Based block farm', NULL, 'PCS', 24880.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(88, '', '2026-12-02', '46029', '2026-12-02 00:00:00', 'Organic Fertilizer & concoctions SLSP', NULL, 'PCS', 88211.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(89, '', '2026-12-02', '46029', '2026-12-02 00:00:00', 'Farm inputs SLSP', NULL, 'PCS', 10272.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(90, '', '2026-12-02', '46031', '2026-12-02 00:00:00', 'Materials major block based block farm ( gin, beer, sugar cane etc)', NULL, 'PCS', 63040.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(91, '', '2026-12-02', '46029', '2026-12-02 00:00:00', 'materials(Seeds & seedling) SLSP', NULL, 'PCS', 69336.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(92, '', '2026-12-02', '46024', '2026-12-02 00:00:00', 'meals and snacks- Partnership Against Hunger and Poverty', NULL, 'PAX', 51300.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(93, '', '2026-12-03', '46033', '2026-12-03 00:00:00', 'meals and snacks- Building/strengthening the credit worthiness of ARBs & ARBOs accessing credit/microfinance (APCP-now ALERT ARBO)', NULL, 'PAX', 53100.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(94, '', '2026-01-07', '46041', '2026-01-07 00:00:00', 'meals and snacks- Development of ARBO as Microfinance Provider', NULL, 'PAX', 25150.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(95, '', '2026-12-02', '46028', '2026-12-02 00:00:00', 'meals and snacks- Social Infrastructure Building', NULL, 'PAX', 531050.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(96, '', '2026-12-02', '46031', '2026-12-02 00:00:00', 'meals and snacks- Major Crop Based Block Farm Productivity Enhancement Implementation', NULL, 'PAX', 395200.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(97, '', '2026-12-02', '46025', '2026-12-02 00:00:00', 'meals and snacks- Sustainable Monitoring and Evaluation (SME)', NULL, 'PAX', 15500.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(98, '', '2026-12-02', '46029', '2026-12-02 00:00:00', 'meals and snacks- Sustainable Livelihood Support Program', NULL, 'PAX', 183920.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(99, '', '2026-12-02', '46026', '2026-12-02 00:00:00', 'meals and snacks- Farm Business School', NULL, 'PAX', 74100.00, 'PBD', 'Not Started', 19, '2026-11-13 09:38:07'),
(100, '', '2026-01-06', '46037', '2026-01-06 00:00:00', 'Meals and snacks for the Sustainable Development in Silangan Agrarian Reform Community, San Antonio, Aringay, La Union', NULL, 'PAX', 70000.00, 'MICHAEL C.', 'Not Started', 19, '2026-11-13 09:38:07'),
(101, '', '2026-01-06', '46036', '2026-01-06 00:00:00', 'Meals and snacks- pre-assessment meeting', NULL, 'PAX', 12000.00, 'NEMIA', 'Not Started', 19, '2026-11-13 09:38:07'),
(102, '', NULL, '', NULL, 'NOTE:', NULL, '', NULL, '', 'Not Started', 19, '2026-11-13 09:38:07'),
(103, '', NULL, '', NULL, 'FEEL FREE TO EDIT THE COLUMNS OF YOUR RESPECTIVE SECTIONS TO BETTER REFLECT THE LIFE CYCLE OF THE VOUCHER HEHEHE', NULL, '', NULL, '', 'Not Started', 19, '2026-11-13 09:38:07'),
(104, '', NULL, '', NULL, '-Jessa-', NULL, '', NULL, '', 'Not Started', 19, '2026-11-13 09:38:07'),
(105, '6', '2026-06-04', 'SPLIT 2026-06-29', '2026-06-04 00:00:00', 'Meals and snacks Continuous Monthly Performance Monitoring and Assessment of SPLIT Project Targets CY 2026', 138.000, 'Pax', NULL, 'Rhona Mallare', 'Not Started', 19, '2026-11-13 09:38:07'),
(106, '7', '2026-06-04', 'SPLIT 2026-06-28', '2026-06-04 00:00:00', 'ADMINISTRATIVE & OPERATIONAL ALIGNMNET MEETING FOR LTS REORGANIZATION AND PRIJECT SPLIT', 46.000, 'Pax', NULL, 'Rhona Mallare', 'Not Started', 19, '2026-11-13 09:38:07'),
(107, '8', '2026-05-21', 'SPLIT 2026-05-26', '2026-05-21 00:00:00', 'Vehicle rental-Pulong-pulong with ICCs/IPs for SPLIT Project Safeguards Implementation of Project SPLIT', 13.000, 'unit', NULL, 'Monica Cabading', 'Not Started', 19, '2026-11-13 09:38:07'),
(108, '9', '2026-06-09', 'SPLIT 2026-06-30', '2026-06-09 00:00:00', 'SPLIT OFFICE SUPPLIES 101 2nd & 3rd Quarter', NULL, 'pax', NULL, 'Gerline Rivera', 'Not Started', 19, '2026-11-13 09:38:07'),
(109, '10', NULL, '', NULL, 'OFFICE FURNITURE (EXECUTIVE SWIVEL CHAIR)', NULL, 'PCS', NULL, '', 'Not Started', 19, '2026-11-13 09:38:07'),
(124, '2', '2026-11-16', '46035', '2026-11-16 14:28:00', 'Computers for New Employees', 6.000, 'units', 120000.00, 'Jake Rave Dulay', 'Completed', 19, '2026-11-16 14:30:15');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `transaction_code` varchar(40) NOT NULL,
  `worksheet` varchar(30) NOT NULL,
  `current_stage` varchar(40) NOT NULL DEFAULT 'purchase_requests',
  `status` varchar(30) NOT NULL DEFAULT 'In Progress',
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `transaction_code`, `worksheet`, `current_stage`, `status`, `created_by`, `created_at`, `updated_at`) VALUES
(14, 'PPT-2026-000014', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(15, 'PPT-2026-000015', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(16, 'PPT-2026-000016', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(17, 'PPT-2026-000017', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(18, 'PPT-2026-000018', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(19, 'PPT-2026-000019', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(20, 'PPT-2026-000020', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(21, 'PPT-2026-000021', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(22, 'PPT-2026-000022', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(23, 'PPT-2026-000023', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(24, 'PPT-2026-000024', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(25, 'PPT-2026-000025', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(26, 'PPT-2026-000026', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(27, 'PPT-2026-000027', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(28, 'PPT-2026-000028', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(29, 'PPT-2026-000029', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(30, 'PPT-2026-000030', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(31, 'PPT-2026-000031', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(32, 'PPT-2026-000032', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(33, 'PPT-2026-000033', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(34, 'PPT-2026-000034', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(35, 'PPT-2026-000035', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(36, 'PPT-2026-000036', '2026', 'bac', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-16 14:45:26'),
(37, 'PPT-2026-000037', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(38, 'PPT-2026-000038', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(39, 'PPT-2026-000039', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(40, 'PPT-2026-000040', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(41, 'PPT-2026-000041', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(42, 'PPT-2026-000042', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(43, 'PPT-2026-000043', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(44, 'PPT-2026-000044', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(45, 'PPT-2026-000045', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(46, 'PPT-2026-000046', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(47, 'PPT-2026-000047', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(48, 'PPT-2026-000048', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(49, 'PPT-2026-000049', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(50, 'PPT-2026-000050', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(51, 'PPT-2026-000051', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(52, 'PPT-2026-000052', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(53, 'PPT-2026-000053', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(54, 'PPT-2026-000054', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(55, 'PPT-2026-000055', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(56, 'PPT-2026-000056', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(57, 'PPT-2026-000057', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(58, 'PPT-2026-000058', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(59, 'PPT-2026-000059', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(60, 'PPT-2026-000060', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(61, 'PPT-2026-000061', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(62, 'PPT-2026-000062', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(63, 'PPT-2026-000063', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-16 14:45:04'),
(64, 'PPT-2026-000064', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(65, 'PPT-2026-000065', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(66, 'PPT-2026-000066', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(67, 'PPT-2026-000067', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(68, 'PPT-2026-000068', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(69, 'PPT-2026-000069', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(70, 'PPT-2026-000070', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(71, 'PPT-2026-000071', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(72, 'PPT-2026-000072', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(73, 'PPT-2026-000073', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(74, 'PPT-2026-000074', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(75, 'PPT-2026-000075', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(76, 'PPT-2026-000076', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(77, 'PPT-2026-000077', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(78, 'PPT-2026-000078', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(79, 'PPT-2026-000079', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(80, 'PPT-2026-000080', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(81, 'PPT-2026-000081', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(82, 'PPT-2026-000082', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(83, 'PPT-2026-000083', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(84, 'PPT-2026-000084', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(85, 'PPT-2026-000085', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(86, 'PPT-2026-000086', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(87, 'PPT-2026-000087', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(88, 'PPT-2026-000088', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(89, 'PPT-2026-000089', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(90, 'PPT-2026-000090', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(91, 'PPT-2026-000091', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(92, 'PPT-2026-000092', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(93, 'PPT-2026-000093', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(94, 'PPT-2026-000094', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(95, 'PPT-2026-000095', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(96, 'PPT-2026-000096', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(97, 'PPT-2026-000097', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(98, 'PPT-2026-000098', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(99, 'PPT-2026-000099', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(100, 'PPT-2026-000100', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(101, 'PPT-2026-000101', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(102, 'PPT-2026-000102', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(103, 'PPT-2026-000103', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(104, 'PPT-2026-000104', '2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(105, 'PPT-2026-000105', 'SPLIT 2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(106, 'PPT-2026-000106', 'SPLIT 2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(107, 'PPT-2026-000107', 'SPLIT 2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(108, 'PPT-2026-000108', 'SPLIT 2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(109, 'PPT-2026-000109', 'SPLIT 2026', 'purchase_requests', 'In Progress', 19, '2026-11-13 09:38:07', '2026-11-13 09:38:07'),
(124, 'PPT-2026-000124', '2026', 'jev', 'Completed', 19, '2026-11-16 14:29:51', '2026-11-16 14:41:59');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `username` varchar(60) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` varchar(60) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `last_login` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `password_hash`, `role`, `active`, `created_at`, `last_login`) VALUES
(19, 'System Administrator', 'systemadmin', '$2y$10$myXipiIC.tCkW0EqHt4pleNinfbgi8j/4CRyNXQwaW68niBrHg9.i', 'Administrator', 1, '2026-11-13 08:37:15', '2026-11-16 13:47:20'),
(21, 'End-User / Requesting Office', 'end_user', '$2y$10$DawDoIu0sDX4yRt3EpfYxeitwOa0LxVJ0Cd14LZLG2OLyhICYGfAG', 'Encoder / Records Staff', 1, '2026-11-13 08:43:55', '2026-11-13 15:29:16'),
(22, 'BAC Secretariat', 'bac_secretariat', '$2y$10$vXBeMwTvX/OLeihF04ZW5edtKJu7z3DvQj3BsELvruput2nyPdXJu', 'BAC Personnel', 1, '2026-11-13 08:44:50', '2026-11-16 13:21:01'),
(23, 'Procurement Officer', 'procurement_officer', '$2y$10$gaF8jZp639jQBG6pH99ZoORiAR0CSteUvEgOYluFjUGNzO7j.xhlu', 'Procurement Personnel', 1, '2026-11-13 08:44:51', '2026-11-16 13:31:17'),
(24, 'Budget Officer', 'budget_officer', '$2y$10$JCQGldZV2OlxLv60tFzRNOA04343h./c5sxfWWP7rCzz8/DMRUet.', 'Budget Personnel', 1, '2026-11-13 08:44:51', '2026-11-16 13:30:52'),
(25, 'Inspection Personnel', 'inspection_officer', '$2y$10$ViaycqvERE4diV/vrQNFke3rAxFUIOYnomJ9EmEaj4bDnu.RYg9F6', 'Inspection Personnel', 1, '2026-11-13 08:44:51', '2026-11-16 13:24:52'),
(26, 'Accounting Officer', 'accounting_officer', '$2y$10$0P1OENHJF40gWGKrVgQNS.jB2Hh7LeL.roOMNrQGPrLmMhY2DPkKW', 'Accounting Personnel', 1, '2026-11-13 08:44:52', '2026-11-16 13:31:50'),
(27, 'Cashier / Treasury Officer', 'cashier_officer', '$2y$10$/HK0g/EKxRHsCV4A8sGZI.lCu.sD42ORPx7COkkduKUjNcRpwlUW.', 'Cashier', 1, '2026-11-13 08:44:52', '2026-11-16 13:45:36'),
(28, 'Management / Authorized Viewer', 'management_viewer', '$2y$10$RS1wAUMy3EnvsVlGfUfRpO9N9fi0gXhUkvcdsdu1dd2UQq6dMKoh.', 'Viewer / Management', 1, '2026-11-13 08:44:53', '2026-11-16 13:34:30');

-- --------------------------------------------------------

--
-- Table structure for table `user_stage_access`
--

CREATE TABLE `user_stage_access` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `stage` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_stage_access`
--

INSERT INTO `user_stage_access` (`user_id`, `stage`) VALUES
(19, 'bac'),
(19, 'cashier'),
(19, 'dv'),
(19, 'iar'),
(19, 'jev'),
(19, 'ors'),
(19, 'purchase_orders'),
(19, 'purchase_requests'),
(21, 'purchase_requests'),
(22, 'bac'),
(23, 'purchase_orders'),
(24, 'ors'),
(25, 'iar'),
(26, 'dv'),
(26, 'jev'),
(27, 'cashier');

-- --------------------------------------------------------

--
-- Table structure for table `workbook_groups`
--

CREATE TABLE `workbook_groups` (
  `name` varchar(30) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `workbook_groups`
--

INSERT INTO `workbook_groups` (`name`, `is_default`, `created_by`, `created_at`) VALUES
('2026', 1, NULL, '2026-11-16 13:54:43'),
('SPLIT 2026', 1, NULL, '2026-11-16 13:54:43');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `idx_activity_created` (`created_at`),
  ADD KEY `idx_activity_transaction` (`transaction_id`);

--
-- Indexes for table `attachments`
--
ALTER TABLE `attachments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `stored_name` (`stored_name`),
  ADD KEY `uploaded_by` (`uploaded_by`),
  ADD KEY `idx_attachment_transaction` (`transaction_id`);

--
-- Indexes for table `bac_records`
--
ALTER TABLE `bac_records`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Indexes for table `dv_records`
--
ALTER TABLE `dv_records`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Indexes for table `iar_records`
--
ALTER TABLE `iar_records`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Indexes for table `jev_records`
--
ALTER TABLE `jev_records`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Indexes for table `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD PRIMARY KEY (`attempt_key`);

--
-- Indexes for table `ors_records`
--
ALTER TABLE `ors_records`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Indexes for table `payment_records`
--
ALTER TABLE `payment_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_payment_transaction` (`transaction_id`);

--
-- Indexes for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `idx_po_supplier` (`supplier`);

--
-- Indexes for table `purchase_requests`
--
ALTER TABLE `purchase_requests`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transaction_code` (`transaction_code`),
  ADD KEY `fk_transaction_creator` (`created_by`),
  ADD KEY `idx_transaction_worksheet` (`worksheet`),
  ADD KEY `idx_transaction_stage` (`current_stage`),
  ADD KEY `idx_transaction_updated` (`updated_at`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `user_stage_access`
--
ALTER TABLE `user_stage_access`
  ADD PRIMARY KEY (`user_id`,`stage`);

--
-- Indexes for table `workbook_groups`
--
ALTER TABLE `workbook_groups`
  ADD PRIMARY KEY (`name`),
  ADD KEY `created_by` (`created_by`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=219;

--
-- AUTO_INCREMENT for table `attachments`
--
ALTER TABLE `attachments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_records`
--
ALTER TABLE `payment_records`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `activity_logs_ibfk_2` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `attachments`
--
ALTER TABLE `attachments`
  ADD CONSTRAINT `attachments_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `attachments_ibfk_2` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `bac_records`
--
ALTER TABLE `bac_records`
  ADD CONSTRAINT `bac_records_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bac_records_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `dv_records`
--
ALTER TABLE `dv_records`
  ADD CONSTRAINT `dv_records_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `dv_records_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `iar_records`
--
ALTER TABLE `iar_records`
  ADD CONSTRAINT `iar_records_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `iar_records_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `jev_records`
--
ALTER TABLE `jev_records`
  ADD CONSTRAINT `jev_records_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `jev_records_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `ors_records`
--
ALTER TABLE `ors_records`
  ADD CONSTRAINT `ors_records_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ors_records_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `payment_records`
--
ALTER TABLE `payment_records`
  ADD CONSTRAINT `payment_records_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `payment_records_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD CONSTRAINT `purchase_orders_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_orders_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `purchase_requests`
--
ALTER TABLE `purchase_requests`
  ADD CONSTRAINT `purchase_requests_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_requests_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `fk_transaction_creator` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `user_stage_access`
--
ALTER TABLE `user_stage_access`
  ADD CONSTRAINT `user_stage_access_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `workbook_groups`
--
ALTER TABLE `workbook_groups`
  ADD CONSTRAINT `workbook_groups_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
