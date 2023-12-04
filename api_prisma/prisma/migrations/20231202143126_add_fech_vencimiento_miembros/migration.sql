/*
  Warnings:

  - Added the required column `fecha_vencimiento` to the `miembros` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `miembros` ADD COLUMN `fecha_vencimiento` DATE NOT NULL;
