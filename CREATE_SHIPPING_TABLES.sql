-- ========================================
-- انسخ هذا الكود كله وشغله في phpMyAdmin
-- ========================================

USE shark;

-- حذف الجداول القديمة إن وجدت
DROP TABLE IF EXISTS `shipping_orders`;
DROP TABLE IF EXISTS `shipping_companies`;

-- إنشاء جدول شركات الشحن
CREATE TABLE `shipping_companies` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(50) DEFAULT '',
    `address` TEXT DEFAULT '',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- إنشاء جدول طلبات الشحن
CREATE TABLE `shipping_orders` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `company_id` INT NOT NULL,
    `order_number` VARCHAR(100) DEFAULT '',
    `customer_name` VARCHAR(255) DEFAULT '',
    `customer_phone` VARCHAR(50) DEFAULT '',
    `customer_address` TEXT DEFAULT '',
    `total_amount` DECIMAL(15,2) DEFAULT 0,
    `collected_amount` DECIMAL(15,2) DEFAULT 0,
    `shipping_cost` DECIMAL(15,2) DEFAULT 0,
    `notes` TEXT DEFAULT '',
    `status` ENUM('pending', 'shipped', 'delivered', 'returned') DEFAULT 'pending',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`company_id`) REFERENCES `shipping_companies`(`id`) ON DELETE CASCADE,
    INDEX `idx_company` (`company_id`),
    INDEX `idx_status` (`status`),
    INDEX `idx_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- إضافة بيانات تجريبية
INSERT INTO `shipping_companies` (`name`, `phone`, `address`) VALUES
('شركة الشحن السريع', '01234567890', 'القاهرة'),
('شركة النقل الآمن', '01098765432', 'الجيزة');

-- عرض النتيجة
SELECT '✅ تم إنشاء الجداول بنجاح!' as status;
SELECT * FROM shipping_companies;
