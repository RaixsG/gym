-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 04-12-2023 a las 17:06:08
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
  `nombre` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_nacimiento` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`ID_cliente`, `nombre`, `apellido`, `direccion`, `telefono`, `email`, `fecha_nacimiento`) VALUES
(1, 'Alessyo', 'Linares Vargas', 'Jr. 20 de abril', '989369107', 'jhardelloficial@gmail.com', '2002-02-02'),
(2, 'Aria', 'Vargas', 'Jr. Los mangos', '923145766', 'oferplus210@sakurape.com', '2004-01-05'),
(3, 'Kheisy', 'Vargas', 'Jr. Los mangos', '975315984', '989369107@gmail.com', '2003-08-24'),
(4, 'Pancho', 'Apuela', 'Jr. Apuela', '123456789', 'apuela@apuela.com', '2003-06-17'),
(5, 'Prueba 1', 'Prueba 1', 'Prueba 1', 'Prueba 32', 'Prueba 4', '2002-01-01'),
(6, 'Su', 'Apuela', 'Jr. Apuela', '741258963', '2022200042@ucss.pe', '2005-01-11'),
(7, 'General01', 'General01', 'General01', 'General01', 'General01@General01.com', '2000-01-01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles_venta`
--

CREATE TABLE `detalles_venta` (
  `ID_detalle_venta` int NOT NULL,
  `cantidad` int NOT NULL,
  `ID_venta` int NOT NULL,
  `ID_producto` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalles_venta`
--

INSERT INTO `detalles_venta` (`ID_detalle_venta`, `cantidad`, `ID_venta`, `ID_producto`) VALUES
(1, 5, 1, 1),
(2, 3, 2, 1),
(3, 5, 3, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `enseña_en`
--

CREATE TABLE `enseña_en` (
  `ID_enseña_en` int NOT NULL,
  `ID_horario` int NOT NULL,
  `ID_instructor` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `enseña_en`
--

INSERT INTO `enseña_en` (`ID_enseña_en`, `ID_horario`, `ID_instructor`) VALUES
(1, 1, 1),
(2, 1, 1),
(3, 2, 2),
(4, 3, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios`
--

CREATE TABLE `horarios` (
  `ID_horario` int NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_finalizacion` time NOT NULL,
  `turno` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `horarios`
--

INSERT INTO `horarios` (`ID_horario`, `hora_inicio`, `hora_finalizacion`, `turno`) VALUES
(1, '05:30:00', '11:59:00', 'Mañana'),
(2, '12:00:00', '16:59:00', 'Tarde'),
(3, '17:00:00', '21:00:00', 'Noche');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inscripciones`
--

CREATE TABLE `inscripciones` (
  `ID_inscripcion` int NOT NULL,
  `fecha_inscripcion` date NOT NULL,
  `ID_cliente` int NOT NULL,
  `ID_enseña_en` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `inscripciones`
--

INSERT INTO `inscripciones` (`ID_inscripcion`, `fecha_inscripcion`, `ID_cliente`, `ID_enseña_en`) VALUES
(1, '2023-12-02', 6, 3),
(2, '2023-12-02', 5, 3),
(3, '2023-12-01', 2, 3),
(4, '2023-12-01', 3, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `instructores`
--

CREATE TABLE `instructores` (
  `ID_instructor` int NOT NULL,
  `nombre` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `especializacion` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto_instructor` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `instructores`
--

INSERT INTO `instructores` (`ID_instructor`, `nombre`, `apellido`, `direccion`, `telefono`, `email`, `fecha_nacimiento`, `especializacion`, `foto_instructor`) VALUES
(1, 'Instructor 1', 'Instructor 1', 'Instructor 1', '975315984', 'jhardelloficial@gmail.com', '1985-06-12', 'Cardio', NULL),
(2, 'Instructor 2', 'Instructor 2', 'Instructor 2', '923145766', 'Instructor2@Instructor2.com', '1991-11-12', 'Peso', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `membresias`
--

CREATE TABLE `membresias` (
  `ID_membresia` int NOT NULL,
  `nombre_membresia` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `beneficios` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `membresias`
--

INSERT INTO `membresias` (`ID_membresia`, `nombre_membresia`, `precio`, `beneficios`) VALUES
(1, 'Normal', 100.00, 'GYM + BAILE'),
(2, 'VIP', 110.00, 'GYM + BAILE + AGUA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `miembros`
--

CREATE TABLE `miembros` (
  `ID_miembro` int NOT NULL,
  `estado_inscripcion` tinyint(1) NOT NULL,
  `ID_membresia` int NOT NULL,
  `ID_cliente` int NOT NULL,
  `fecha_vencimiento` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `miembros`
--

INSERT INTO `miembros` (`ID_miembro`, `estado_inscripcion`, `ID_membresia`, `ID_cliente`, `fecha_vencimiento`) VALUES
(1, 1, 1, 5, '2023-12-02'),
(2, 1, 1, 2, '2023-12-02'),
(3, 1, 1, 3, '2023-12-02');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago_membresias`
--

CREATE TABLE `pago_membresias` (
  `ID_pago_mem` int NOT NULL,
  `fecha_pago` date NOT NULL,
  `cantidad` int NOT NULL,
  `metodo_pago` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ID_miembro` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `ID_producto` int NOT NULL,
  `nombre_producto` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `cantidad_stock` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`ID_producto`, `nombre_producto`, `descripcion`, `precio`, `cantidad_stock`) VALUES
(1, 'Proteina', 'Proteina de calidad', 150.00, 2),
(2, 'Trembolona', 'Pa ser más fuertes', 500.00, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `username`, `password`) VALUES
(1, 'admin', 'admin');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `ID_venta` int NOT NULL,
  `fecha_pago` date NOT NULL,
  `metodo_pago` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ID_cliente` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`ID_venta`, `fecha_pago`, `metodo_pago`, `ID_cliente`) VALUES
(1, '2023-12-02', 'efectivo', 1),
(2, '2023-12-02', 'efectivo', 7),
(3, '2023-12-02', 'tarjeta', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_prisma_migrations`
--

CREATE TABLE `_prisma_migrations` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checksum` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `migration_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logs` text COLLATE utf8mb4_unicode_ci,
  `rolled_back_at` datetime(3) DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `applied_steps_count` int UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `_prisma_migrations`
--

INSERT INTO `_prisma_migrations` (`id`, `checksum`, `finished_at`, `migration_name`, `logs`, `rolled_back_at`, `started_at`, `applied_steps_count`) VALUES
('0c51b0e8-b44d-459f-ba34-da29e9be2e37', '3de8759f32fe5074ebadcc2139476a96f0361a93841432eaa80da6eb12fd3a42', '2023-12-02 15:21:47.122', '20231120180132_login', NULL, NULL, '2023-12-02 15:21:47.109', 1),
('28b3aaa5-75eb-490a-9cc9-151765815b52', 'd5a18f8d2d413ded98bdbda7c25340bcc2ff9e5a002006e2ff0c4150f066733f', '2023-12-02 15:21:47.048', '20231030021413_init', NULL, NULL, '2023-12-02 15:21:46.620', 1),
('9ca723e4-9d03-4b4a-8148-7fd95f59bf08', 'f8161d04a9872b79f150cb86c6371ca80127792b101d3a46907820239d5196a8', '2023-12-02 15:21:47.107', '20231031182451_refactor', NULL, NULL, '2023-12-02 15:21:47.050', 1),
('eadaa509-cde1-41e3-aa12-a217789d6fce', '2f890eb191d74ab7ecf209f8afde5e358904847dd355bcdacce2ef55c32b2a31', '2023-12-02 15:21:47.183', '20231202143126_add_fech_vencimiento_miembros', NULL, NULL, '2023-12-02 15:21:47.150', 1),
('f2a2ce9b-a3be-4c4e-8405-8788a089698c', '5f00a0193d5246f8b5438c220ad8bbbd44d5bb26cb0eecbaf62695d0ae913fcd', '2023-12-02 15:21:47.148', '20231120181259_edit_login', NULL, NULL, '2023-12-02 15:21:47.125', 1);

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
  ADD KEY `ID_cliente` (`ID_cliente`),
  ADD KEY `ID_membresia` (`ID_membresia`);

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
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_key` (`username`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`ID_venta`),
  ADD KEY `ID_cliente` (`ID_cliente`);

--
-- Indices de la tabla `_prisma_migrations`
--
ALTER TABLE `_prisma_migrations`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `ID_cliente` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `detalles_venta`
--
ALTER TABLE `detalles_venta`
  MODIFY `ID_detalle_venta` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `enseña_en`
--
ALTER TABLE `enseña_en`
  MODIFY `ID_enseña_en` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `horarios`
--
ALTER TABLE `horarios`
  MODIFY `ID_horario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `inscripciones`
--
ALTER TABLE `inscripciones`
  MODIFY `ID_inscripcion` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `instructores`
--
ALTER TABLE `instructores`
  MODIFY `ID_instructor` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `membresias`
--
ALTER TABLE `membresias`
  MODIFY `ID_membresia` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `miembros`
--
ALTER TABLE `miembros`
  MODIFY `ID_miembro` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `pago_membresias`
--
ALTER TABLE `pago_membresias`
  MODIFY `ID_pago_mem` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `ID_producto` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `ID_venta` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
