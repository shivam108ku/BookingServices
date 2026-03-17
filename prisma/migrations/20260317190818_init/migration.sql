-- CreateTable
CREATE TABLE `users` (
    `id` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `firstName` VARCHAR(191) NOT NULL,
    `lastName` VARCHAR(191) NOT NULL,
    `phone` VARCHAR(191) NULL,
    `profileImage` VARCHAR(191) NULL,
    `bio` VARCHAR(191) NULL,
    `isHost` BOOLEAN NOT NULL DEFAULT false,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `users_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `properties` (
    `id` VARCHAR(191) NOT NULL,
    `title` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NOT NULL,
    `address` VARCHAR(191) NOT NULL,
    `city` VARCHAR(191) NOT NULL,
    `country` VARCHAR(191) NOT NULL,
    `zipCode` VARCHAR(191) NOT NULL,
    `latitude` DOUBLE NULL,
    `longitude` DOUBLE NULL,
    `pricePerNight` DOUBLE NOT NULL,
    `bedrooms` INTEGER NOT NULL,
    `bathrooms` INTEGER NOT NULL,
    `maxGuests` INTEGER NOT NULL,
    `propertyType` VARCHAR(191) NOT NULL,
    `status` VARCHAR(191) NOT NULL DEFAULT 'available',
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `hostId` VARCHAR(191) NOT NULL,

    INDEX `properties_hostId_idx`(`hostId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `bookings` (
    `id` VARCHAR(191) NOT NULL,
    `checkIn` DATETIME(3) NOT NULL,
    `checkOut` DATETIME(3) NOT NULL,
    `numberOfGuests` INTEGER NOT NULL,
    `totalPrice` DOUBLE NOT NULL,
    `status` VARCHAR(191) NOT NULL DEFAULT 'pending',
    `specialRequests` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `guestId` VARCHAR(191) NOT NULL,
    `propertyId` VARCHAR(191) NOT NULL,

    INDEX `bookings_guestId_idx`(`guestId`),
    INDEX `bookings_propertyId_idx`(`propertyId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `reviews` (
    `id` VARCHAR(191) NOT NULL,
    `rating` INTEGER NOT NULL,
    `comment` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `authorId` VARCHAR(191) NOT NULL,
    `propertyId` VARCHAR(191) NOT NULL,

    INDEX `reviews_authorId_idx`(`authorId`),
    INDEX `reviews_propertyId_idx`(`propertyId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `payments` (
    `id` VARCHAR(191) NOT NULL,
    `amount` DOUBLE NOT NULL,
    `currency` VARCHAR(191) NOT NULL DEFAULT 'USD',
    `paymentMethod` VARCHAR(191) NOT NULL,
    `status` VARCHAR(191) NOT NULL DEFAULT 'pending',
    `transactionId` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `bookingId` VARCHAR(191) NOT NULL,
    `userId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `payments_transactionId_key`(`transactionId`),
    UNIQUE INDEX `payments_bookingId_key`(`bookingId`),
    INDEX `payments_userId_idx`(`userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `amenities` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `icon` VARCHAR(191) NULL,
    `description` VARCHAR(191) NULL,

    UNIQUE INDEX `amenities_name_key`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `property_images` (
    `id` VARCHAR(191) NOT NULL,
    `url` VARCHAR(191) NOT NULL,
    `alt` VARCHAR(191) NULL,
    `displayOrder` INTEGER NOT NULL DEFAULT 0,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `propertyId` VARCHAR(191) NOT NULL,

    INDEX `property_images_propertyId_idx`(`propertyId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_AmenityToProperty` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_AmenityToProperty_AB_unique`(`A`, `B`),
    INDEX `_AmenityToProperty_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `properties` ADD CONSTRAINT `properties_hostId_fkey` FOREIGN KEY (`hostId`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `bookings` ADD CONSTRAINT `bookings_guestId_fkey` FOREIGN KEY (`guestId`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `bookings` ADD CONSTRAINT `bookings_propertyId_fkey` FOREIGN KEY (`propertyId`) REFERENCES `properties`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `reviews` ADD CONSTRAINT `reviews_authorId_fkey` FOREIGN KEY (`authorId`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `reviews` ADD CONSTRAINT `reviews_propertyId_fkey` FOREIGN KEY (`propertyId`) REFERENCES `properties`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `payments` ADD CONSTRAINT `payments_bookingId_fkey` FOREIGN KEY (`bookingId`) REFERENCES `bookings`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `payments` ADD CONSTRAINT `payments_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `property_images` ADD CONSTRAINT `property_images_propertyId_fkey` FOREIGN KEY (`propertyId`) REFERENCES `properties`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_AmenityToProperty` ADD CONSTRAINT `_AmenityToProperty_A_fkey` FOREIGN KEY (`A`) REFERENCES `amenities`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_AmenityToProperty` ADD CONSTRAINT `_AmenityToProperty_B_fkey` FOREIGN KEY (`B`) REFERENCES `properties`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
