/*
  Warnings:

  - You are about to drop the `_amenitytoproperty` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `amenities` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `bookings` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `payments` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `properties` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `property_images` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `reviews` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `users` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `_amenitytoproperty` DROP FOREIGN KEY `_AmenityToProperty_A_fkey`;

-- DropForeignKey
ALTER TABLE `_amenitytoproperty` DROP FOREIGN KEY `_AmenityToProperty_B_fkey`;

-- DropForeignKey
ALTER TABLE `bookings` DROP FOREIGN KEY `bookings_guestId_fkey`;

-- DropForeignKey
ALTER TABLE `bookings` DROP FOREIGN KEY `bookings_propertyId_fkey`;

-- DropForeignKey
ALTER TABLE `payments` DROP FOREIGN KEY `payments_bookingId_fkey`;

-- DropForeignKey
ALTER TABLE `payments` DROP FOREIGN KEY `payments_userId_fkey`;

-- DropForeignKey
ALTER TABLE `properties` DROP FOREIGN KEY `properties_hostId_fkey`;

-- DropForeignKey
ALTER TABLE `property_images` DROP FOREIGN KEY `property_images_propertyId_fkey`;

-- DropForeignKey
ALTER TABLE `reviews` DROP FOREIGN KEY `reviews_authorId_fkey`;

-- DropForeignKey
ALTER TABLE `reviews` DROP FOREIGN KEY `reviews_propertyId_fkey`;

-- DropTable
DROP TABLE `_amenitytoproperty`;

-- DropTable
DROP TABLE `amenities`;

-- DropTable
DROP TABLE `bookings`;

-- DropTable
DROP TABLE `payments`;

-- DropTable
DROP TABLE `properties`;

-- DropTable
DROP TABLE `property_images`;

-- DropTable
DROP TABLE `reviews`;

-- DropTable
DROP TABLE `users`;

-- CreateTable
CREATE TABLE `User` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `hotelId` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `bookingAmount` INTEGER NOT NULL,
    `status` ENUM('PENDING', 'CONFIRMED', 'CANCELLED') NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
