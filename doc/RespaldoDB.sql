CREATE DATABASE  IF NOT EXISTS `apivanilla` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `apivanilla`;
-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: apivanilla
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `desaarrollador`
--

DROP TABLE IF EXISTS `desaarrollador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `desaarrollador` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `idEspecialidad` int DEFAULT '1',
  `idStatus` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_desarrollador_status_idx` (`idStatus`),
  KEY `fk_desarrollador_especialidad_idx` (`idEspecialidad`),
  CONSTRAINT `fk_desarrollador_especialidad` FOREIGN KEY (`idEspecialidad`) REFERENCES `especialidad` (`id`),
  CONSTRAINT `fk_desarrollador_status` FOREIGN KEY (`idStatus`) REFERENCES `status` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `desaarrollador`
--

LOCK TABLES `desaarrollador` WRITE;
/*!40000 ALTER TABLE `desaarrollador` DISABLE KEYS */;
/*!40000 ALTER TABLE `desaarrollador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `especialidad`
--

DROP TABLE IF EXISTS `especialidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `especialidad` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NOT NULL,
  `detalle` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `especialidad`
--

LOCK TABLES `especialidad` WRITE;
/*!40000 ALTER TABLE `especialidad` DISABLE KEYS */;
INSERT INTO `especialidad` VALUES (1,'Desarrollador','Produce pieezas de código dentro del proyecto');
/*!40000 ALTER TABLE `especialidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lista`
--

DROP TABLE IF EXISTS `lista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lista` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  `detalle` varchar(500) DEFAULT NULL,
  `idTipoLista` int NOT NULL,
  `idDesarrollador` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_lista_tipoLista_idx` (`idTipoLista`),
  KEY `fk_lista_desarrollador_idx` (`idDesarrollador`),
  CONSTRAINT `fk_lista_desarrollador` FOREIGN KEY (`idDesarrollador`) REFERENCES `desaarrollador` (`id`),
  CONSTRAINT `fk_lista_tipoLista` FOREIGN KEY (`idTipoLista`) REFERENCES `tipolista` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lista`
--

LOCK TABLES `lista` WRITE;
/*!40000 ALTER TABLE `lista` DISABLE KEYS */;
/*!40000 ALTER TABLE `lista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimientos`
--

DROP TABLE IF EXISTS `movimientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimientos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idDesarrollador` int NOT NULL,
  `idTarea` int NOT NULL,
  `inicio` datetime NOT NULL,
  `fin` datetime DEFAULT NULL,
  `listaOrigen` int NOT NULL,
  `listaDestino` int DEFAULT NULL,
  `mensajeDesarrollador` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_movimientos_desarrollador_idx` (`idDesarrollador`),
  KEY `fk_movimientos_listaOrigen_idx` (`listaOrigen`),
  KEY `fk_movimientos_listaDestino_idx` (`listaDestino`),
  KEY `fk_movimientos_tarea_idx` (`idTarea`),
  CONSTRAINT `fk_movimientos_desarrollador` FOREIGN KEY (`idDesarrollador`) REFERENCES `desaarrollador` (`id`),
  CONSTRAINT `fk_movimientos_listaDestino` FOREIGN KEY (`listaDestino`) REFERENCES `lista` (`id`),
  CONSTRAINT `fk_movimientos_listaOrigen` FOREIGN KEY (`listaOrigen`) REFERENCES `lista` (`id`),
  CONSTRAINT `fk_movimientos_tarea` FOREIGN KEY (`idTarea`) REFERENCES `tarea` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Esta tabla contendra todos los movimientos generados entre tareas y listas\nSI listaOrigen y listaDestino son iguales, será la creación de la tarea\nSI listaDestino es la lista Especial "En Desarrollo" será una toma de tarea por el desarrollador\nSI listaOrigen es la lista Especial "En Desarrollo" será la liberación de tarea por el desarrollador que la colocó en "En Desarrollo"\nLa listaOrigen de un movimiento debe ser la listaDestino del movimiento inmediato anterior\nSI la listaDestino de un movimiento apunta a una lista de tipo Terminal, ya no puede registrar nuevos movimientos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimientos`
--

LOCK TABLES `movimientos` WRITE;
/*!40000 ALTER TABLE `movimientos` DISABLE KEYS */;
/*!40000 ALTER TABLE `movimientos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (1,'Habilitado'),(2,'Deshabilitado');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tarea`
--

DROP TABLE IF EXISTS `tarea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tarea` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  `detalle` varchar(500) DEFAULT NULL,
  `prioridad` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tarea`
--

LOCK TABLES `tarea` WRITE;
/*!40000 ALTER TABLE `tarea` DISABLE KEYS */;
/*!40000 ALTER TABLE `tarea` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipolista`
--

DROP TABLE IF EXISTS `tipolista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipolista` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipolista`
--

LOCK TABLES `tipolista` WRITE;
/*!40000 ALTER TABLE `tipolista` DISABLE KEYS */;
INSERT INTO `tipolista` VALUES (1,'Normal'),(2,'Terminal'),(3,'Especial');
/*!40000 ALTER TABLE `tipolista` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-14 14:20:34
