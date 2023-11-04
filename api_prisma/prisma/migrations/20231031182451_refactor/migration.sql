/*
  Warnings:

  - You are about to alter the column `cantidad` on the `detalles_venta` table. The data in that column could be lost. The data in that column will be cast from `Decimal(10,0)` to `Int`.
  - You are about to alter the column `precio` on the `membresias` table. The data in that column could be lost. The data in that column will be cast from `Decimal(10,0)` to `Decimal(10,2)`.

*/
-- AlterTable
ALTER TABLE `detalles_venta` MODIFY `cantidad` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `membresias` MODIFY `precio` DECIMAL(10, 2) NOT NULL;
