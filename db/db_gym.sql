-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 28-10-2023 a las 05:08:40
-- Versión del servidor: 8.0.34
-- Versión de PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_gym`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `ID_cliente` int NOT NULL,
  `nombre` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `apellido` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `direccion` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `telefono` varchar(9) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `fecha_nacimiento` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`ID_cliente`, `nombre`, `apellido`, `direccion`, `telefono`, `email`, `fecha_nacimiento`) VALUES
(1, 'Prueba', 'Prueba', 'Jr. Prueba', '987654321', 'prueba@prueba.com', '2002-02-02');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles_venta`
--

CREATE TABLE `detalles_venta` (
  `ID_detalle_venta` int NOT NULL,
  `cantidad` decimal(10,0) NOT NULL,
  `ID_venta` int NOT NULL,
  `ID_producto` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `enseña_en`
--

CREATE TABLE `enseña_en` (
  `ID_enseña_en` int NOT NULL,
  `ID_horario` int NOT NULL,
  `ID_instructor` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `enseña_en`
--

INSERT INTO `enseña_en` (`ID_enseña_en`, `ID_horario`, `ID_instructor`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios`
--

CREATE TABLE `horarios` (
  `ID_horario` int NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_finalizacion` time NOT NULL,
  `turno` varchar(20) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `horarios`
--

INSERT INTO `horarios` (`ID_horario`, `hora_inicio`, `hora_finalizacion`, `turno`) VALUES
(1, '05:00:00', '06:00:00', 'Primer turno Mañana');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inscripciones`
--

CREATE TABLE `inscripciones` (
  `ID_inscripcion` int NOT NULL,
  `fecha_inscripcion` date NOT NULL,
  `ID_cliente` int NOT NULL,
  `ID_enseña_en` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inscripciones`
--

INSERT INTO `inscripciones` (`ID_inscripcion`, `fecha_inscripcion`, `ID_cliente`, `ID_enseña_en`) VALUES
(1, '2023-10-23', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `instructores`
--

CREATE TABLE `instructores` (
  `ID_instructor` int NOT NULL,
  `nombre` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `apellido` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `direccion` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `telefono` varchar(9) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `especializacion` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `foto_instructor` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `instructores`
--

INSERT INTO `instructores` (`ID_instructor`, `nombre`, `apellido`, `direccion`, `telefono`, `email`, `fecha_nacimiento`, `especializacion`, `foto_instructor`) VALUES
(1, 'Ins Prueba', 'Ins Prueba', 'Ins Prueba', '987654321', 'Ins Prueba', '1999-01-01', 'Cardio', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `membresias`
--

CREATE TABLE `membresias` (
  `ID_membresia` int NOT NULL,
  `nombre_membresia` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `precio` decimal(10,0) NOT NULL,
  `beneficios` varchar(30) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `membresias`
--

INSERT INTO `membresias` (`ID_membresia`, `nombre_membresia`, `precio`, `beneficios`) VALUES
(1, 'Gym', 90, 'Solo Maquinas del Gym');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `miembros`
--

CREATE TABLE `miembros` (
  `ID_miembro` int NOT NULL,
  `estado_inscripcion` tinyint(1) NOT NULL,
  `ID_membresia` int NOT NULL,
  `ID_cliente` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `miembros`
--

INSERT INTO `miembros` (`ID_miembro`, `estado_inscripcion`, `ID_membresia`, `ID_cliente`) VALUES
(1, 0, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago_membresias`
--

CREATE TABLE `pago_membresias` (
  `ID_pago_mem` int NOT NULL,
  `fecha_pago` date NOT NULL,
  `cantidad` int NOT NULL,
  `metodo_pago` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `ID_miembro` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `ID_producto` int NOT NULL,
  `nombre_producto` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `descripcion` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `cantidad_stock` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`ID_producto`, `nombre_producto`, `descripcion`, `precio`, `cantidad_stock`) VALUES
(1, 'Agua', 'Agua de mesa San Luis', 2.50, 24);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `ID_venta` int NOT NULL,
  `fecha_pago` date NOT NULL,
  `metodo_pago` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `ID_cliente` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`ID_cliente`),
  ADD UNIQUE KEY `ID_cliente` (`ID_cliente`),
  ADD UNIQUE KEY `telefono` (`telefono`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `detalles_venta`
--
ALTER TABLE `detalles_venta`
  ADD PRIMARY KEY (`ID_detalle_venta`),
  ADD UNIQUE KEY `ID_detalle_venta` (`ID_detalle_venta`),
  ADD KEY `ID_producto` (`ID_producto`),
  ADD KEY `ID_venta` (`ID_venta`);

--
-- Indices de la tabla `enseña_en`
--
ALTER TABLE `enseña_en`
  ADD PRIMARY KEY (`ID_enseña_en`),
  ADD UNIQUE KEY `ID_enseña_en` (`ID_enseña_en`),
  ADD KEY `ID_horario` (`ID_horario`),
  ADD KEY `ID_instructor` (`ID_instructor`);

--
-- Indices de la tabla `horarios`
--
ALTER TABLE `horarios`
  ADD PRIMARY KEY (`ID_horario`),
  ADD UNIQUE KEY `ID_horario` (`ID_horario`);

--
-- Indices de la tabla `inscripciones`
--
ALTER TABLE `inscripciones`
  ADD PRIMARY KEY (`ID_inscripcion`),
  ADD UNIQUE KEY `ID_inscripcion` (`ID_inscripcion`),
  ADD KEY `ID_cliente` (`ID_cliente`),
  ADD KEY `ID_enseña_en` (`ID_enseña_en`);

--
-- Indices de la tabla `instructores`
--
ALTER TABLE `instructores`
  ADD PRIMARY KEY (`ID_instructor`),
  ADD UNIQUE KEY `ID_instructor` (`ID_instructor`),
  ADD UNIQUE KEY `telefono` (`telefono`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `membresias`
--
ALTER TABLE `membresias`
  ADD PRIMARY KEY (`ID_membresia`),
  ADD UNIQUE KEY `ID_membresia` (`ID_membresia`);

--
-- Indices de la tabla `miembros`
--
ALTER TABLE `miembros`
  ADD PRIMARY KEY (`ID_miembro`),
  ADD UNIQUE KEY `ID_miembro` (`ID_miembro`),
  ADD KEY `ID_membresia` (`ID_membresia`),
  ADD KEY `ID_cliente` (`ID_cliente`);

--
-- Indices de la tabla `pago_membresias`
--
ALTER TABLE `pago_membresias`
  ADD PRIMARY KEY (`ID_pago_mem`),
  ADD KEY `ID_miembro` (`ID_miembro`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`ID_producto`),
  ADD UNIQUE KEY `ID_producto` (`ID_producto`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`ID_venta`),
  ADD KEY `ID_cliente` (`ID_cliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `ID_cliente` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `detalles_venta`
--
ALTER TABLE `detalles_venta`
  MODIFY `ID_detalle_venta` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `enseña_en`
--
ALTER TABLE `enseña_en`
  MODIFY `ID_enseña_en` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `horarios`
--
ALTER TABLE `horarios`
  MODIFY `ID_horario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `inscripciones`
--
ALTER TABLE `inscripciones`
  MODIFY `ID_inscripcion` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `instructores`
--
ALTER TABLE `instructores`
  MODIFY `ID_instructor` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `membresias`
--
ALTER TABLE `membresias`
  MODIFY `ID_membresia` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `miembros`
--
ALTER TABLE `miembros`
  MODIFY `ID_miembro` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `pago_membresias`
--
ALTER TABLE `pago_membresias`
  MODIFY `ID_pago_mem` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `ID_producto` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `ID_venta` int NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalles_venta`
--
ALTER TABLE `detalles_venta`
  ADD CONSTRAINT `detalles_venta_ibfk_1` FOREIGN KEY (`ID_producto`) REFERENCES `productos` (`ID_producto`),
  ADD CONSTRAINT `detalles_venta_ibfk_2` FOREIGN KEY (`ID_venta`) REFERENCES `venta` (`ID_venta`);

--
-- Filtros para la tabla `enseña_en`
--
ALTER TABLE `enseña_en`
  ADD CONSTRAINT `enseña_en_ibfk_1` FOREIGN KEY (`ID_horario`) REFERENCES `horarios` (`ID_horario`),
  ADD CONSTRAINT `enseña_en_ibfk_2` FOREIGN KEY (`ID_instructor`) REFERENCES `instructores` (`ID_instructor`);

--
-- Filtros para la tabla `inscripciones`
--
ALTER TABLE `inscripciones`
  ADD CONSTRAINT `inscripciones_ibfk_1` FOREIGN KEY (`ID_cliente`) REFERENCES `clientes` (`ID_cliente`),
  ADD CONSTRAINT `inscripciones_ibfk_2` FOREIGN KEY (`ID_enseña_en`) REFERENCES `enseña_en` (`ID_enseña_en`);

--
-- Filtros para la tabla `miembros`
--
ALTER TABLE `miembros`
  ADD CONSTRAINT `miembros_ibfk_1` FOREIGN KEY (`ID_membresia`) REFERENCES `membresias` (`ID_membresia`),
  ADD CONSTRAINT `miembros_ibfk_2` FOREIGN KEY (`ID_cliente`) REFERENCES `clientes` (`ID_cliente`);

--
-- Filtros para la tabla `pago_membresias`
--
ALTER TABLE `pago_membresias`
  ADD CONSTRAINT `pago_membresias_ibfk_1` FOREIGN KEY (`ID_miembro`) REFERENCES `miembros` (`ID_miembro`);

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`ID_cliente`) REFERENCES `clientes` (`ID_cliente`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
