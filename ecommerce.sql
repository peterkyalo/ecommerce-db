CREATE TABLE `attribute_type` (
  `attr_type_id` int PRIMARY KEY AUTO_INCREMENT,
  `type_name` varchar(50) NOT NULL,
  `description` varchar(255),
  `created_at` timestamp DEFAULT (now())
);

CREATE TABLE `attribute_category` (
  `attr_category_id` int PRIMARY KEY AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  `description` text,
  `created_at` timestamp DEFAULT (now())
);

CREATE TABLE `size_category` (
  `size_category_id` int PRIMARY KEY AUTO_INCREMENT,
  `category_name` varchar(50) NOT NULL,
  `description` varchar(255),
  `created_at` timestamp DEFAULT (now())
);

CREATE TABLE `color` (
  `color_id` int PRIMARY KEY AUTO_INCREMENT,
  `color_name` varchar(50) NOT NULL,
  `hex_code` varchar(7),
  `created_at` timestamp DEFAULT (now())
);

CREATE TABLE `brand` (
  `brand_id` int PRIMARY KEY AUTO_INCREMENT,
  `brand_name` varchar(100) NOT NULL,
  `description` text,
  `logo_url` varchar(255),
  `created_at` timestamp DEFAULT (now()),
  `updated_at` timestamp DEFAULT (now())
);

CREATE TABLE `product_category` (
  `category_id` int PRIMARY KEY AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  `parent_category_id` int,
  `description` text,
  `created_at` timestamp DEFAULT (now())
);

CREATE TABLE `product` (
  `product_id` int PRIMARY KEY AUTO_INCREMENT,
  `product_name` varchar(255) NOT NULL,
  `description` text,
  `base_price` decimal(10,2) NOT NULL,
  `created_at` timestamp DEFAULT (now()),
  `updated_at` timestamp DEFAULT (now()),
  `brand_id` int,
  `category_id` int
);

CREATE TABLE `product_image` (
  `image_id` int PRIMARY KEY AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `alt_text` varchar(255),
  `is_primary` boolean DEFAULT false,
  `display_order` int DEFAULT 0,
  `created_at` timestamp DEFAULT (now())
);

CREATE TABLE `size_option` (
  `size_id` int PRIMARY KEY AUTO_INCREMENT,
  `size_category_id` int,
  `size_value` varchar(20) NOT NULL,
  `description` varchar(100),
  `created_at` timestamp DEFAULT (now())
);

CREATE TABLE `product_variation` (
  `variation_id` int PRIMARY KEY AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `color_id` int,
  `size_id` int,
  `sku` varchar(50) UNIQUE,
  `additional_price` decimal(10,2) DEFAULT 0,
  `created_at` timestamp DEFAULT (now())
);

CREATE TABLE `product_item` (
  `item_id` int PRIMARY KEY AUTO_INCREMENT,
  `variation_id` int NOT NULL,
  `quantity_in_stock` int NOT NULL DEFAULT 0,
  `barcode` varchar(50),
  `created_at` timestamp DEFAULT (now()),
  `updated_at` timestamp DEFAULT (now())
);

CREATE TABLE `product_attribute` (
  `attribute_id` int PRIMARY KEY AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `attr_category_id` int,
  `attr_type_id` int,
  `attribute_name` varchar(100) NOT NULL,
  `attribute_value` text NOT NULL,
  `display_order` int DEFAULT 0,
  `created_at` timestamp DEFAULT (now())
);

ALTER TABLE `product_category` ADD FOREIGN KEY (`parent_category_id`) REFERENCES `product_category` (`category_id`);

ALTER TABLE `product` ADD FOREIGN KEY (`brand_id`) REFERENCES `brand` (`brand_id`);

ALTER TABLE `product` ADD FOREIGN KEY (`category_id`) REFERENCES `product_category` (`category_id`);

ALTER TABLE `product_image` ADD FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

ALTER TABLE `size_option` ADD FOREIGN KEY (`size_category_id`) REFERENCES `size_category` (`size_category_id`);

ALTER TABLE `product_variation` ADD FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

ALTER TABLE `product_variation` ADD FOREIGN KEY (`color_id`) REFERENCES `color` (`color_id`);

ALTER TABLE `product_variation` ADD FOREIGN KEY (`size_id`) REFERENCES `size_option` (`size_id`);

ALTER TABLE `product_item` ADD FOREIGN KEY (`variation_id`) REFERENCES `product_variation` (`variation_id`);

ALTER TABLE `product_attribute` ADD FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

ALTER TABLE `product_attribute` ADD FOREIGN KEY (`attr_category_id`) REFERENCES `attribute_category` (`attr_category_id`);

ALTER TABLE `product_attribute` ADD FOREIGN KEY (`attr_type_id`) REFERENCES `attribute_type` (`attr_type_id`);