-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 20, 2025 at 01:05 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dfp`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(100) NOT NULL,
  `name` varchar(20) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `password`) VALUES
(1, 'admin', '6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(100) NOT NULL,
  `user_id` int(100) NOT NULL,
  `pid` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` int(10) NOT NULL,
  `quantity` int(10) NOT NULL,
  `image` varchar(100) NOT NULL,
  `subtotal` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `user_id`, `pid`, `name`, `price`, `quantity`, `image`, `subtotal`) VALUES
(26, 6, 2, 'tysm', 912, 1, 'home-img-1.png', 0.00),
(46, 8, 4, 'Casing', 100, 2, 'casing.png', 200.00),
(47, 8, 6, 'Ryzen 5 3600', 200, 5, 'cpu.jpg', 1000.00);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `category_id` int(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `title` varchar(15) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `name`, `title`, `description`) VALUES
(6, 'Mens Ware', NULL, 'Second floor '),
(7, 'Kids cloths', NULL, 'Target year range');

-- --------------------------------------------------------

--
-- Table structure for table `chat_messages`
--

CREATE TABLE `chat_messages` (
  `message_id` int(10) NOT NULL,
  `session_id` int(10) DEFAULT NULL,
  `sender_type` enum('customer','csr') NOT NULL,
  `sender_id` int(10) NOT NULL,
  `message` text NOT NULL,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chat_sessions`
--

CREATE TABLE `chat_sessions` (
  `session_id` int(10) NOT NULL,
  `customer_id` int(10) DEFAULT NULL,
  `csr_id` int(10) DEFAULT NULL,
  `status` enum('waiting','active','ended') DEFAULT 'waiting',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_message_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(10) NOT NULL,
  `first_name` varchar(18) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `email` varchar(40) NOT NULL,
  `phone` int(10) DEFAULT NULL,
  `password` varchar(20) NOT NULL,
  `address` varchar(100) DEFAULT NULL,
  `cart_id` int(10) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `first_name`, `last_name`, `email`, `phone`, `password`, `address`, `cart_id`, `created_at`) VALUES
(1, 'Madhuka', 'Aththanayaka', 'madhukaaththanayaka@gmail.com', 758973807, '$2y$10$dA394r75jn.My', '43\r\nBibila Road, Hulandawa', NULL, '2025-02-24 04:32:30');

-- --------------------------------------------------------

--
-- Table structure for table `customer_sales_representatives`
--

CREATE TABLE `customer_sales_representatives` (
  `csr_id` int(10) NOT NULL,
  `name` varchar(30) NOT NULL,
  `expertise` varchar(50) NOT NULL,
  `is_available` tinyint(1) DEFAULT 1,
  `admin_id` int(10) DEFAULT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer_sales_representatives`
--

INSERT INTO `customer_sales_representatives` (`csr_id`, `name`, `expertise`, `is_available`, `admin_id`, `password`) VALUES
(2, 'Chalaka', '20', 1, NULL, '97f732a0e9e33cd5a3bb2697e4d134882ec48b7d'),
(3, 'mark3', '12', 1, NULL, '011c945f30ce2cbafc452f39840f025693339c42');

-- --------------------------------------------------------

--
-- Table structure for table `customer_support_tickets`
--

CREATE TABLE `customer_support_tickets` (
  `ticket_id` int(11) NOT NULL,
  `csr_id` int(11) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `priority` enum('low','medium','high','urgent') DEFAULT 'medium',
  `status` enum('open','in_progress','resolved','closed') DEFAULT 'open',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer_support_tickets`
--

INSERT INTO `customer_support_tickets` (`ticket_id`, `csr_id`, `subject`, `description`, `priority`, `status`, `created_at`, `updated_at`, `user_id`) VALUES
(6, NULL, 'sdas', 'sdasd', 'medium', '', '2025-02-28 04:24:11', '2025-02-28 04:24:11', 8);

-- --------------------------------------------------------

--
-- Table structure for table `delivery_agents`
--

CREATE TABLE `delivery_agents` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `password` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `delivery_agents`
--

INSERT INTO `delivery_agents` (`id`, `name`, `phone`, `password`) VALUES
(4, 'Madhuka', '0711234567', '6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2'),
(5, 'Steve', '0112234567', '6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2'),
(6, 'Mark1', '0111111111', '6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2');

-- --------------------------------------------------------

--
-- Table structure for table `delivery_assignments`
--

CREATE TABLE `delivery_assignments` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `delivery_agent_id` int(11) NOT NULL,
  `status` enum('pending','picked_up','delivered','cancelled') DEFAULT 'pending',
  `picked_up_at` timestamp NULL DEFAULT NULL,
  `delivered_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `delivery_assignments`
--

INSERT INTO `delivery_assignments` (`id`, `order_id`, `delivery_agent_id`, `status`, `picked_up_at`, `delivered_at`) VALUES
(4, 7, 4, 'delivered', '2025-03-04 14:03:13', '2025-03-04 14:03:14'),
(5, 8, 4, 'delivered', '2025-03-04 14:03:15', '2025-03-04 14:03:16'),
(6, 11, 4, 'delivered', '2025-03-04 14:03:17', '2025-03-04 14:03:18'),
(7, 10, 4, 'delivered', '2025-03-04 14:26:33', '2025-03-08 17:45:19');

-- --------------------------------------------------------

--
-- Table structure for table `financial_auditors`
--

CREATE TABLE `financial_auditors` (
  `auditor_id` int(10) NOT NULL,
  `certification` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `admin_id` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `financial_auditors`
--

INSERT INTO `financial_auditors` (`auditor_id`, `certification`, `name`, `password`, `phone`, `admin_id`) VALUES
(1, 'MBBS', 'Madhuka', '6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', '0711234567', 1),
(2, 'GENIOUS BILLIONERE', 'TonyStark', 'f192acf461b8f8002ea08efcbf2f0d48fc44dfae', '0112345678', 1),
(3, 'stark', 'mark2', '6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', '0122222222', 1);

-- --------------------------------------------------------

--
-- Table structure for table `financial_audit_logs`
--

CREATE TABLE `financial_audit_logs` (
  `log_id` int(10) NOT NULL,
  `auditor_id` int(10) NOT NULL,
  `log_type` enum('transaction','compliance','risk_assessment','report_generation') NOT NULL,
  `description` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `severity` enum('low','medium','high') DEFAULT 'low'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `financial_reports`
--

CREATE TABLE `financial_reports` (
  `report_id` int(10) NOT NULL,
  `auditor_id` int(10) NOT NULL,
  `report_type` enum('monthly','quarterly','annual','special') NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `total_revenue` decimal(15,2) NOT NULL,
  `total_expenses` decimal(15,2) NOT NULL,
  `net_profit` decimal(15,2) NOT NULL,
  `summary` text NOT NULL,
  `status` enum('draft','reviewed','finalized') DEFAULT 'draft',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `inventory_id` int(10) NOT NULL,
  `product_id` int(10) NOT NULL,
  `supplier_id` int(10) NOT NULL,
  `quantity` int(100) NOT NULL DEFAULT 0,
  `storage_location` varchar(50) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_log`
--

CREATE TABLE `inventory_log` (
  `log_id` int(10) NOT NULL,
  `supplier_id` int(10) NOT NULL,
  `product_id` int(10) NOT NULL,
  `previous_quantity` int(10) NOT NULL,
  `new_quantity` int(10) NOT NULL,
  `change_type` enum('add','remove') NOT NULL,
  `reason` text NOT NULL,
  `notes` text DEFAULT NULL,
  `logged_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `manager_settings`
--

CREATE TABLE `manager_settings` (
  `settings_id` int(11) NOT NULL,
  `manager_id` int(11) NOT NULL,
  `low_stock_alerts` tinyint(1) NOT NULL DEFAULT 1,
  `new_order_alerts` tinyint(1) NOT NULL DEFAULT 1,
  `review_alerts` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `manager_settings`
--

INSERT INTO `manager_settings` (`settings_id`, `manager_id`, `low_stock_alerts`, `new_order_alerts`, `review_alerts`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1, '2025-03-04 05:36:47', '2025-03-04 05:36:47'),
(2, 3, 1, 1, 1, '2025-06-14 06:25:48', '2025-06-14 06:25:48');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(100) NOT NULL,
  `user_id` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `number` varchar(12) NOT NULL,
  `message` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `user_id`, `name`, `email`, `number`, `message`) VALUES
(1, 2, 'sdasfs', 'fasfas@gmail.com', '12312', 'fasfas'),
(2, 0, 'tysm', '232@gmail.com', '2312321', 'Hello how are you'),
(3, 3, 'Thevindu', 'itsthw9@gmail.com', '0705228470', 'Hello there');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(100) NOT NULL,
  `user_id` int(100) NOT NULL,
  `name` varchar(20) NOT NULL,
  `number` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `method` varchar(50) NOT NULL,
  `address` varchar(500) NOT NULL,
  `total_products` varchar(1000) NOT NULL,
  `total_price` int(100) NOT NULL,
  `placed_on` date NOT NULL DEFAULT current_timestamp(),
  `payment_status` varchar(20) NOT NULL DEFAULT 'pending',
  `order_status` enum('pending','picked_up','delivered','cancelled') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `name`, `number`, `email`, `method`, `address`, `total_products`, `total_price`, `placed_on`, `payment_status`, `order_status`, `created_at`, `updated_at`) VALUES
(2, 2, 'casdasd', '12312', 'safasfas@gmail.com', 'paytm', 'flat no. sfasfas, fasfas, fasfas, fasfas, fsafas - 21312', 'tysm (900 x 1) - ', 900, '2025-02-02', 'completed', 'delivered', '2025-02-22 08:28:23', '2025-03-04 14:02:37'),
(7, 6, 'dsd', '123123', 'asdas@gmail.com', 'cash on delivery', 'flat no. 2312, dsa, adas, sdadas, sdsad - 123123', 'tysm (900 x 1)', 900, '2025-02-07', 'completed', 'delivered', '2025-02-22 08:28:23', '2025-03-04 14:03:14'),
(8, 6, 'casdas', '213123', 'das@gmail.com', 'cash on delivery', 'flat no. 321, 323, 232, 323, 123 - 23213', 'tysm (900 x 1), mail (123 x 1)', 1023, '2025-02-07', 'completed', 'delivered', '2025-02-22 08:28:23', '2025-03-04 14:03:16'),
(9, 8, 'Malwana Madhuka Mals', '0758973807', 'madhukaaththanayaka@gmail.com', 'cash on delivery', 'flat no. 43, Bibila Road, Hulandawa, Monaragala, Uva, Sri Lanka - 91000', 'Headset (420 x 1), tysm (912 x 1), Casing (100 x 1)', 1432, '2025-02-24', 'pending', '', '2025-02-24 04:51:40', '2025-03-04 03:53:29'),
(10, 8, 'Malwana Madhuka Mals', '0758973807', 'madhukaaththanayaka@gmail.com', 'cash on delivery', 'flat no. 43, Bibila Road, Hulandawa, Monaragala, Uva, Sri Lanka - 91000', 'tysm (912 x 1), Headset (420 x 1), Ryzen 5 3600 (200 x 4)', 2132, '2025-03-04', 'completed', 'delivered', '2025-03-04 13:54:18', '2025-03-08 17:45:19'),
(11, 8, 'Malwana Madhuka Mals', '0758973807', 'madhukaaththanayaka@gmail.com', 'cash on delivery', 'flat no. 43, Bibila Road, Hulandawa, Monaragala, Uva, Sri Lanka - 91000', 'tysm (912 x 1), Headset (420 x 90)', 38712, '2025-03-04', 'completed', 'delivered', '2025-03-04 13:54:46', '2025-03-04 14:03:18'),
(12, 8, 'Malwana Madhuka Mals', '0758973807', 'madhukaaththanayaka@gmail.com', 'cash on delivery', 'flat no. 43, Bibila Road, Hulandawa, Monaragala, Uva, Sri Lanka - 91000', 'Casing (100 x 1), Ryzen 5 3600 (200 x 1), Headset (420 x 25)', 10800, '2025-03-04', 'pending', '', '2025-03-04 13:58:04', '2025-03-04 13:58:11'),
(13, 8, 'Malwana Madhuka Mals', '0758973807', 'madhukaaththanayaka@gmail.com', 'cash on delivery', 'flat no. 43, Bibila Road, Hulandawa, Monaragala, Uva, Sri Lanka - 91000', 'tysm (912 x 1), Casing (100 x 1), Ryzen 5 3600 (200 x 1)', 1212, '2025-03-04', 'completed', '', '2025-03-04 13:59:50', '2025-03-08 05:32:48'),
(14, 8, 'Malwana Madhuka Mals', '0758973807', 'madhukaaththanayaka@gmail.com', 'cash on delivery', 'flat no. 43, Bibila Road, Hulandawa, Monaragala, Uva, Sri Lanka - 91000', 'tysm (912 x 1), Casing (100 x 1), Headset (420 x 1)', 1432, '2025-03-04', 'pending', 'pending', '2025-03-04 14:35:10', '2025-03-04 14:35:10'),
(15, 8, 'Malwana Madhuka Mals', '0758973807', 'madhukaaththanayaka@gmail.com', 'cash on delivery', 'flat no. 43, Bibila Road, Hulandawa, Monaragala, Uva, Sri Lanka - 91000', 'Headset (420 x 1), tysm (912 x 1)', 1332, '2025-03-04', 'pending', '', '2025-03-04 16:23:15', '2025-03-09 04:42:35');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_item_id` int(10) NOT NULL,
  `order_id` int(10) NOT NULL,
  `product_id` int(10) NOT NULL,
  `quantity` int(10) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(100) NOT NULL,
  `category_id` int(10) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `details` varchar(500) NOT NULL,
  `price` int(10) NOT NULL,
  `image_01` varchar(100) NOT NULL,
  `image_02` varchar(100) NOT NULL,
  `image_03` varchar(100) NOT NULL,
  `status` enum('active','discontinued') DEFAULT 'active',
  `discontinued_reason` text DEFAULT NULL,
  `discontinued_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `name`, `details`, `price`, `image_01`, `image_02`, `image_03`, `status`, `discontinued_reason`, `discontinued_at`) VALUES
(8, NULL, 'TShirt', 'Mens ', 16, 'Leonardo_Phoenix_10_A_dark_stormy_night_with_heavy_rain_and_th_0.jpg', 'Leonardo_Phoenix_10_A_dramatic_closeup_portrait_of_a_majestic_1.jpg', 'Leonardo_Phoenix_10_A_dramatic_warmtoned_cinematic_photograph_2.jpg', 'active', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_manager`
--

CREATE TABLE `product_manager` (
  `manager_id` int(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `expertise` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `admin_id` int(10) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_manager`
--

INSERT INTO `product_manager` (`manager_id`, `name`, `expertise`, `password`, `admin_id`, `created_at`, `updated_at`) VALUES
(1, 'Madhuka', 'Danna ', '6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', NULL, '2025-02-23 03:54:33', '2025-02-23 03:54:33'),
(2, 'Bruce Banner', 'HULK', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', NULL, '2025-06-14 02:53:37', '2025-06-14 02:53:37'),
(3, 'JARVIS', '35', '6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', NULL, '2025-06-14 03:37:36', '2025-06-14 03:37:36');

-- --------------------------------------------------------

--
-- Table structure for table `restock_requests`
--

CREATE TABLE `restock_requests` (
  `request_id` int(10) NOT NULL,
  `supplier_id` int(10) NOT NULL,
  `product_id` int(10) NOT NULL,
  `requested_quantity` int(10) NOT NULL,
  `request_notes` text DEFAULT NULL,
  `response_notes` text DEFAULT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `restock_requests`
--

INSERT INTO `restock_requests` (`request_id`, `supplier_id`, `product_id`, `requested_quantity`, `request_notes`, `response_notes`, `status`, `created_at`, `updated_at`) VALUES
(18, 2, 8, 450, 'recovery', 'Cancelled by manager', 'rejected', '2025-06-14 09:02:30', '2025-06-14 09:27:17');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL CHECK (`rating` >= 1 and `rating` <= 5),
  `review_text` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `manager_response` text DEFAULT NULL,
  `response_date` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `risk_assessments`
--

CREATE TABLE `risk_assessments` (
  `assessment_id` int(10) NOT NULL,
  `auditor_id` int(10) NOT NULL,
  `assessment_date` date NOT NULL,
  `supplier_id` int(10) DEFAULT NULL,
  `risk_category` enum('financial','operational','compliance','reputational') NOT NULL,
  `risk_score` decimal(5,2) NOT NULL,
  `mitigation_strategy` text NOT NULL,
  `status` enum('identified','in_progress','mitigated') DEFAULT 'identified',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shift_change_requests`
--

CREATE TABLE `shift_change_requests` (
  `request_id` int(10) NOT NULL,
  `staff_id` int(10) NOT NULL,
  `current_shift` enum('morning','afternoon','night') NOT NULL,
  `requested_shift` enum('morning','afternoon','night') NOT NULL,
  `effective_date` date NOT NULL,
  `reason` text NOT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staff_tasks`
--

CREATE TABLE `staff_tasks` (
  `task_id` int(10) NOT NULL,
  `staff_id` int(10) NOT NULL,
  `task_name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `priority` enum('high','medium','low') DEFAULT 'medium',
  `status` enum('pending','in_progress','completed') DEFAULT 'pending',
  `due_date` date DEFAULT NULL,
  `completion_notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_alert`
--

CREATE TABLE `stock_alert` (
  `alert_id` int(10) NOT NULL,
  `product_id` int(10) NOT NULL,
  `threshold` int(10) NOT NULL,
  `is_resolved` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `supplier_id` int(10) NOT NULL,
  `name` varchar(18) NOT NULL,
  `phone` int(10) NOT NULL,
  `email` varchar(40) NOT NULL,
  `address` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`supplier_id`, `name`, `phone`, `email`, `address`, `password`) VALUES
(1, 'Madhuka', 711234567, 'madhuka@gmail.com', 'No.43,Bibila Road', '6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2'),
(2, 'Tchalla', 987654321, 'blackpanther@gmail.com', 'Head office, kings cart, Wakanda', '6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2');

-- --------------------------------------------------------

--
-- Table structure for table `supply_orders`
--

CREATE TABLE `supply_orders` (
  `supply_order_id` int(10) NOT NULL,
  `supplier_id` int(10) NOT NULL,
  `order_date` datetime NOT NULL DEFAULT current_timestamp(),
  `expected_delivery` date DEFAULT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('pending','in_progress','completed','cancelled') DEFAULT 'pending',
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supply_orders`
--

INSERT INTO `supply_orders` (`supply_order_id`, `supplier_id`, `order_date`, `expected_delivery`, `total_amount`, `status`, `notes`) VALUES
(1, 1, '2025-02-24 01:38:05', '2025-02-25', 200.00, 'completed', 'aaaaaaaaaaaaaaaaaaaaaaaa'),
(2, 2, '2025-06-14 14:25:19', '2025-06-28', 5200.00, 'completed', 'Lat&#39;s check');

-- --------------------------------------------------------

--
-- Table structure for table `supply_order_items`
--

CREATE TABLE `supply_order_items` (
  `supply_order_item_id` int(10) NOT NULL,
  `supply_order_id` int(10) NOT NULL,
  `product_id` int(10) NOT NULL,
  `quantity` int(100) NOT NULL,
  `unit_cost` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supply_order_items`
--

INSERT INTO `supply_order_items` (`supply_order_item_id`, `supply_order_id`, `product_id`, `quantity`, `unit_cost`, `subtotal`) VALUES
(2, 2, 8, 150, 16.00, 2400.00),
(3, 2, 8, 200, 14.00, 2800.00);

-- --------------------------------------------------------

--
-- Table structure for table `ticket_history`
--

CREATE TABLE `ticket_history` (
  `history_id` int(10) NOT NULL,
  `ticket_id` int(10) DEFAULT NULL,
  `csr_id` int(10) DEFAULT NULL,
  `old_status` varchar(20) DEFAULT NULL,
  `new_status` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_responses`
--

CREATE TABLE `ticket_responses` (
  `response_id` int(10) NOT NULL,
  `ticket_id` int(10) DEFAULT NULL,
  `csr_id` int(10) DEFAULT NULL,
  `response` text NOT NULL,
  `type` enum('reply','note') DEFAULT 'reply',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(100) NOT NULL,
  `name` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`) VALUES
(2, 'ThevinduW', 'itsthw9@gmail.com', '784e9240155834852dff458a730cceb50229df32'),
(4, 'asdas', 'thevinduh21@gmail.com', '40bd001563085fc35165329ea1ff5c5ecbdbbeef'),
(5, 'mc', 'demo@gmail.com', '7c222fb2927d828af22f592134e8932480637c0d'),
(6, 'ThevinduH', 'th@gmail.com', '6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2'),
(8, 'Madhuka', 'madhuka@gmail.com', '6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2'),
(9, 'Customer1', 'customer1@gmail.com', '6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2'),
(10, 'User2', 'user2@gmail.com', '6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2');

-- --------------------------------------------------------

--
-- Table structure for table `warehouse_staff`
--

CREATE TABLE `warehouse_staff` (
  `staff_id` int(10) NOT NULL,
  `name` varchar(30) NOT NULL,
  `phone` int(10) NOT NULL,
  `shift` varchar(20) NOT NULL,
  `is_available` tinyint(1) DEFAULT 1,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `warehouse_staff`
--

INSERT INTO `warehouse_staff` (`staff_id`, `name`, `phone`, `shift`, `is_available`, `password`) VALUES
(1, 'Madhuka', 711234567, 'morning', 1, '6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2'),
(2, 'Thor', 112222224, 'morning', 1, 'a5b23f338648cb6f21e2cc1284e4d1b7b930ac97');

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `id` int(100) NOT NULL,
  `user_id` int(100) NOT NULL,
  `pid` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` int(100) NOT NULL,
  `image` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wishlist`
--

INSERT INTO `wishlist` (`id`, `user_id`, `pid`, `name`, `price`, `image`) VALUES
(18, 6, 4, 'Casing', 100, 'casing.png'),
(22, 8, 1, 'Headset', 420, 'home-img-3.png'),
(23, 8, 2, 'tysm', 912, 'home-img-1.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD PRIMARY KEY (`message_id`),
  ADD KEY `session_id` (`session_id`);

--
-- Indexes for table `chat_sessions`
--
ALTER TABLE `chat_sessions`
  ADD PRIMARY KEY (`session_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `csr_id` (`csr_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `customer_sales_representatives`
--
ALTER TABLE `customer_sales_representatives`
  ADD PRIMARY KEY (`csr_id`);

--
-- Indexes for table `customer_support_tickets`
--
ALTER TABLE `customer_support_tickets`
  ADD PRIMARY KEY (`ticket_id`),
  ADD KEY `fk_csr` (`csr_id`),
  ADD KEY `fk_customer_support_tickets_user` (`user_id`);

--
-- Indexes for table `delivery_agents`
--
ALTER TABLE `delivery_agents`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Indexes for table `delivery_assignments`
--
ALTER TABLE `delivery_assignments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_order_assignment` (`order_id`),
  ADD KEY `fk_delivery_agent` (`delivery_agent_id`);

--
-- Indexes for table `financial_auditors`
--
ALTER TABLE `financial_auditors`
  ADD PRIMARY KEY (`auditor_id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `financial_audit_logs`
--
ALTER TABLE `financial_audit_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `auditor_id` (`auditor_id`);

--
-- Indexes for table `financial_reports`
--
ALTER TABLE `financial_reports`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `auditor_id` (`auditor_id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`inventory_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `supplier_id` (`supplier_id`);

--
-- Indexes for table `inventory_log`
--
ALTER TABLE `inventory_log`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `supplier_id` (`supplier_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `manager_settings`
--
ALTER TABLE `manager_settings`
  ADD PRIMARY KEY (`settings_id`),
  ADD UNIQUE KEY `manager_id` (`manager_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `product_manager`
--
ALTER TABLE `product_manager`
  ADD PRIMARY KEY (`manager_id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `restock_requests`
--
ALTER TABLE `restock_requests`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `supplier_id` (`supplier_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `risk_assessments`
--
ALTER TABLE `risk_assessments`
  ADD PRIMARY KEY (`assessment_id`),
  ADD KEY `auditor_id` (`auditor_id`),
  ADD KEY `supplier_id` (`supplier_id`);

--
-- Indexes for table `shift_change_requests`
--
ALTER TABLE `shift_change_requests`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Indexes for table `staff_tasks`
--
ALTER TABLE `staff_tasks`
  ADD PRIMARY KEY (`task_id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Indexes for table `stock_alert`
--
ALTER TABLE `stock_alert`
  ADD PRIMARY KEY (`alert_id`),
  ADD UNIQUE KEY `product_id` (`product_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Indexes for table `supply_orders`
--
ALTER TABLE `supply_orders`
  ADD PRIMARY KEY (`supply_order_id`),
  ADD KEY `supplier_id` (`supplier_id`);

--
-- Indexes for table `supply_order_items`
--
ALTER TABLE `supply_order_items`
  ADD PRIMARY KEY (`supply_order_item_id`),
  ADD KEY `supply_order_id` (`supply_order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `ticket_history`
--
ALTER TABLE `ticket_history`
  ADD PRIMARY KEY (`history_id`),
  ADD KEY `ticket_id` (`ticket_id`),
  ADD KEY `csr_id` (`csr_id`);

--
-- Indexes for table `ticket_responses`
--
ALTER TABLE `ticket_responses`
  ADD PRIMARY KEY (`response_id`),
  ADD KEY `ticket_id` (`ticket_id`),
  ADD KEY `csr_id` (`csr_id`),
  ADD KEY `fk_ticket_responses_user` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `warehouse_staff`
--
ALTER TABLE `warehouse_staff`
  ADD PRIMARY KEY (`staff_id`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `chat_messages`
--
ALTER TABLE `chat_messages`
  MODIFY `message_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chat_sessions`
--
ALTER TABLE `chat_sessions`
  MODIFY `session_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `customer_sales_representatives`
--
ALTER TABLE `customer_sales_representatives`
  MODIFY `csr_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `customer_support_tickets`
--
ALTER TABLE `customer_support_tickets`
  MODIFY `ticket_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `delivery_agents`
--
ALTER TABLE `delivery_agents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `delivery_assignments`
--
ALTER TABLE `delivery_assignments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `financial_auditors`
--
ALTER TABLE `financial_auditors`
  MODIFY `auditor_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `financial_audit_logs`
--
ALTER TABLE `financial_audit_logs`
  MODIFY `log_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `financial_reports`
--
ALTER TABLE `financial_reports`
  MODIFY `report_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `inventory_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `inventory_log`
--
ALTER TABLE `inventory_log`
  MODIFY `log_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `manager_settings`
--
ALTER TABLE `manager_settings`
  MODIFY `settings_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `order_item_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `product_manager`
--
ALTER TABLE `product_manager`
  MODIFY `manager_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `restock_requests`
--
ALTER TABLE `restock_requests`
  MODIFY `request_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `risk_assessments`
--
ALTER TABLE `risk_assessments`
  MODIFY `assessment_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shift_change_requests`
--
ALTER TABLE `shift_change_requests`
  MODIFY `request_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `staff_tasks`
--
ALTER TABLE `staff_tasks`
  MODIFY `task_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock_alert`
--
ALTER TABLE `stock_alert`
  MODIFY `alert_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplier_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `supply_orders`
--
ALTER TABLE `supply_orders`
  MODIFY `supply_order_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `supply_order_items`
--
ALTER TABLE `supply_order_items`
  MODIFY `supply_order_item_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ticket_history`
--
ALTER TABLE `ticket_history`
  MODIFY `history_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ticket_responses`
--
ALTER TABLE `ticket_responses`
  MODIFY `response_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `warehouse_staff`
--
ALTER TABLE `warehouse_staff`
  MODIFY `staff_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD CONSTRAINT `chat_messages_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `chat_sessions` (`session_id`);

--
-- Constraints for table `chat_sessions`
--
ALTER TABLE `chat_sessions`
  ADD CONSTRAINT `chat_sessions_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `chat_sessions_ibfk_2` FOREIGN KEY (`csr_id`) REFERENCES `customer_sales_representatives` (`csr_id`);

--
-- Constraints for table `customer_support_tickets`
--
ALTER TABLE `customer_support_tickets`
  ADD CONSTRAINT `fk_csr` FOREIGN KEY (`csr_id`) REFERENCES `csrs` (`csr_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_customer_support_tickets_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `delivery_assignments`
--
ALTER TABLE `delivery_assignments`
  ADD CONSTRAINT `fk_delivery_agent` FOREIGN KEY (`delivery_agent_id`) REFERENCES `delivery_agents` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `financial_auditors`
--
ALTER TABLE `financial_auditors`
  ADD CONSTRAINT `financial_auditors_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `financial_audit_logs`
--
ALTER TABLE `financial_audit_logs`
  ADD CONSTRAINT `financial_audit_logs_ibfk_1` FOREIGN KEY (`auditor_id`) REFERENCES `financial_auditors` (`auditor_id`) ON DELETE CASCADE;

--
-- Constraints for table `financial_reports`
--
ALTER TABLE `financial_reports`
  ADD CONSTRAINT `financial_reports_ibfk_1` FOREIGN KEY (`auditor_id`) REFERENCES `financial_auditors` (`auditor_id`) ON DELETE CASCADE;

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inventory_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`) ON DELETE CASCADE;

--
-- Constraints for table `inventory_log`
--
ALTER TABLE `inventory_log`
  ADD CONSTRAINT `inventory_log_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inventory_log_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE SET NULL;

--
-- Constraints for table `product_manager`
--
ALTER TABLE `product_manager`
  ADD CONSTRAINT `product_manager_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `restock_requests`
--
ALTER TABLE `restock_requests`
  ADD CONSTRAINT `restock_requests_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `restock_requests_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `risk_assessments`
--
ALTER TABLE `risk_assessments`
  ADD CONSTRAINT `risk_assessments_ibfk_1` FOREIGN KEY (`auditor_id`) REFERENCES `financial_auditors` (`auditor_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `risk_assessments_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`) ON DELETE SET NULL;

--
-- Constraints for table `shift_change_requests`
--
ALTER TABLE `shift_change_requests`
  ADD CONSTRAINT `shift_change_requests_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `warehouse_staff` (`staff_id`) ON DELETE CASCADE;

--
-- Constraints for table `staff_tasks`
--
ALTER TABLE `staff_tasks`
  ADD CONSTRAINT `staff_tasks_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `warehouse_staff` (`staff_id`) ON DELETE CASCADE;

--
-- Constraints for table `stock_alert`
--
ALTER TABLE `stock_alert`
  ADD CONSTRAINT `stock_alert_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `supply_orders`
--
ALTER TABLE `supply_orders`
  ADD CONSTRAINT `supply_orders_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`) ON DELETE CASCADE;

--
-- Constraints for table `supply_order_items`
--
ALTER TABLE `supply_order_items`
  ADD CONSTRAINT `supply_order_items_ibfk_1` FOREIGN KEY (`supply_order_id`) REFERENCES `supply_orders` (`supply_order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `supply_order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ticket_history`
--
ALTER TABLE `ticket_history`
  ADD CONSTRAINT `ticket_history_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `support_tickets` (`ticket_id`),
  ADD CONSTRAINT `ticket_history_ibfk_2` FOREIGN KEY (`csr_id`) REFERENCES `customer_sales_representatives` (`csr_id`);

--
-- Constraints for table `ticket_responses`
--
ALTER TABLE `ticket_responses`
  ADD CONSTRAINT `fk_ticket_responses_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `ticket_responses_ibfk_2` FOREIGN KEY (`csr_id`) REFERENCES `customer_sales_representatives` (`csr_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
