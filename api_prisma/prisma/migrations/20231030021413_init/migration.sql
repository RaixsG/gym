-- CreateTable
CREATE TABLE `clientes` (
    `ID_cliente` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(30) NOT NULL,
    `apellido` VARCHAR(30) NOT NULL,
    `direccion` VARCHAR(50) NOT NULL,
    `telefono` VARCHAR(9) NOT NULL,
    `email` VARCHAR(30) NOT NULL,
    `fecha_nacimiento` DATE NOT NULL,

    UNIQUE INDEX `ID_cliente`(`ID_cliente`),
    UNIQUE INDEX `telefono`(`telefono`),
    UNIQUE INDEX `email`(`email`),
    PRIMARY KEY (`ID_cliente`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `detalles_venta` (
    `ID_detalle_venta` INTEGER NOT NULL AUTO_INCREMENT,
    `cantidad` DECIMAL(10, 0) NOT NULL,
    `ID_venta` INTEGER NOT NULL,
    `ID_producto` INTEGER NOT NULL,

    UNIQUE INDEX `ID_detalle_venta`(`ID_detalle_venta`),
    INDEX `ID_producto`(`ID_producto`),
    INDEX `ID_venta`(`ID_venta`),
    PRIMARY KEY (`ID_detalle_venta`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `enseña_en` (
    `ID_enseña_en` INTEGER NOT NULL AUTO_INCREMENT,
    `ID_horario` INTEGER NOT NULL,
    `ID_instructor` INTEGER NOT NULL,

    UNIQUE INDEX `ID_enseña_en`(`ID_enseña_en`),
    INDEX `ID_horario`(`ID_horario`),
    INDEX `ID_instructor`(`ID_instructor`),
    PRIMARY KEY (`ID_enseña_en`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `horarios` (
    `ID_horario` INTEGER NOT NULL AUTO_INCREMENT,
    `hora_inicio` TIME(0) NOT NULL,
    `hora_finalizacion` TIME(0) NOT NULL,
    `turno` VARCHAR(20) NOT NULL,

    UNIQUE INDEX `ID_horario`(`ID_horario`),
    PRIMARY KEY (`ID_horario`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inscripciones` (
    `ID_inscripcion` INTEGER NOT NULL AUTO_INCREMENT,
    `fecha_inscripcion` DATE NOT NULL,
    `ID_cliente` INTEGER NOT NULL,
    `ID_enseña_en` INTEGER NOT NULL,

    UNIQUE INDEX `ID_inscripcion`(`ID_inscripcion`),
    INDEX `ID_cliente`(`ID_cliente`),
    INDEX `ID_enseña_en`(`ID_enseña_en`),
    PRIMARY KEY (`ID_inscripcion`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `instructores` (
    `ID_instructor` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(30) NOT NULL,
    `apellido` VARCHAR(30) NOT NULL,
    `direccion` VARCHAR(50) NOT NULL,
    `telefono` VARCHAR(9) NOT NULL,
    `email` VARCHAR(50) NOT NULL,
    `fecha_nacimiento` DATE NOT NULL,
    `especializacion` VARCHAR(30) NOT NULL,
    `foto_instructor` BLOB NULL,

    UNIQUE INDEX `ID_instructor`(`ID_instructor`),
    UNIQUE INDEX `telefono`(`telefono`),
    UNIQUE INDEX `email`(`email`),
    PRIMARY KEY (`ID_instructor`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `membresias` (
    `ID_membresia` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre_membresia` VARCHAR(30) NOT NULL,
    `precio` DECIMAL(10, 0) NOT NULL,
    `beneficios` VARCHAR(30) NOT NULL,

    UNIQUE INDEX `ID_membresia`(`ID_membresia`),
    PRIMARY KEY (`ID_membresia`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `miembros` (
    `ID_miembro` INTEGER NOT NULL AUTO_INCREMENT,
    `estado_inscripcion` BOOLEAN NOT NULL,
    `ID_membresia` INTEGER NOT NULL,
    `ID_cliente` INTEGER NOT NULL,

    UNIQUE INDEX `ID_miembro`(`ID_miembro`),
    INDEX `ID_cliente`(`ID_cliente`),
    INDEX `ID_membresia`(`ID_membresia`),
    PRIMARY KEY (`ID_miembro`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pago_membresias` (
    `ID_pago_mem` INTEGER NOT NULL AUTO_INCREMENT,
    `fecha_pago` DATE NOT NULL,
    `cantidad` INTEGER NOT NULL,
    `metodo_pago` VARCHAR(30) NOT NULL,
    `ID_miembro` INTEGER NOT NULL,

    INDEX `ID_miembro`(`ID_miembro`),
    PRIMARY KEY (`ID_pago_mem`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `productos` (
    `ID_producto` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre_producto` VARCHAR(30) NOT NULL,
    `descripcion` VARCHAR(50) NOT NULL,
    `precio` DECIMAL(10, 2) NOT NULL,
    `cantidad_stock` INTEGER NOT NULL,

    UNIQUE INDEX `ID_producto`(`ID_producto`),
    PRIMARY KEY (`ID_producto`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `venta` (
    `ID_venta` INTEGER NOT NULL AUTO_INCREMENT,
    `fecha_pago` DATE NOT NULL,
    `metodo_pago` VARCHAR(30) NOT NULL,
    `ID_cliente` INTEGER NOT NULL,

    INDEX `ID_cliente`(`ID_cliente`),
    PRIMARY KEY (`ID_venta`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `detalles_venta` ADD CONSTRAINT `detalles_venta_ibfk_1` FOREIGN KEY (`ID_producto`) REFERENCES `productos`(`ID_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `detalles_venta` ADD CONSTRAINT `detalles_venta_ibfk_2` FOREIGN KEY (`ID_venta`) REFERENCES `venta`(`ID_venta`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `enseña_en` ADD CONSTRAINT `enseña_en_ibfk_1` FOREIGN KEY (`ID_horario`) REFERENCES `horarios`(`ID_horario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `enseña_en` ADD CONSTRAINT `enseña_en_ibfk_2` FOREIGN KEY (`ID_instructor`) REFERENCES `instructores`(`ID_instructor`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `inscripciones` ADD CONSTRAINT `inscripciones_ibfk_1` FOREIGN KEY (`ID_cliente`) REFERENCES `clientes`(`ID_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `inscripciones` ADD CONSTRAINT `inscripciones_ibfk_2` FOREIGN KEY (`ID_enseña_en`) REFERENCES `enseña_en`(`ID_enseña_en`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `miembros` ADD CONSTRAINT `miembros_ibfk_1` FOREIGN KEY (`ID_membresia`) REFERENCES `membresias`(`ID_membresia`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `miembros` ADD CONSTRAINT `miembros_ibfk_2` FOREIGN KEY (`ID_cliente`) REFERENCES `clientes`(`ID_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pago_membresias` ADD CONSTRAINT `pago_membresias_ibfk_1` FOREIGN KEY (`ID_miembro`) REFERENCES `miembros`(`ID_miembro`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `venta` ADD CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`ID_cliente`) REFERENCES `clientes`(`ID_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION;
