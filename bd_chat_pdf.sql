
-- Dump completed on 2024-12-13 11:12:17
CREATE DATABASE  IF NOT EXISTS `dbcpdf` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `dbcpdf`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: dbcpdf
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `chat`
--

DROP TABLE IF EXISTS `chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `usuario_Id` int NOT NULL,
  `pdf_Id` int NOT NULL,
  `rol` enum('user','assistant') NOT NULL,
  `message` longtext NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_usuario_has_pdf_pdf1_idx` (`pdf_Id`),
  KEY `fk_usuario_has_pdf_usuario_idx` (`usuario_Id`),
  CONSTRAINT `fk_usuario_has_pdf_pdf1` FOREIGN KEY (`pdf_Id`) REFERENCES `pdf` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_has_pdf_usuario` FOREIGN KEY (`usuario_Id`) REFERENCES `usuario` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat`
--

LOCK TABLES `chat` WRITE;
/*!40000 ALTER TABLE `chat` DISABLE KEYS */;
INSERT INTO `chat` VALUES (1,1,1,'user','hola'),(2,1,1,'assistant','buenas tardes'),(3,1,1,'user','a cuanto en poyo'),(4,1,1,'assistant','a 10 varos'),(5,1,2,'user','hola'),(6,2,1,'user','buenas'),(7,1,2,'assistant','kionda'),(8,2,1,'user','wenas');
/*!40000 ALTER TABLE `chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pdf`
--

DROP TABLE IF EXISTS `pdf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pdf` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `SourceId` varchar(45) NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `Pregunta1` varchar(100) NOT NULL,
  `Pregunta2` varchar(100) NOT NULL,
  `Pregunta3` varchar(100) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pdf`
--

LOCK TABLES `pdf` WRITE;
/*!40000 ALTER TABLE `pdf` DISABLE KEYS */;
INSERT INTO `pdf` VALUES (1,'pdf1','pdf1','pdf1','pdf1','pdf1'),(2,'pdf2','pdf2','pdf2','pdf2','pdf2');
/*!40000 ALTER TABLE `pdf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `User` varchar(45) NOT NULL,
  `Contrasenia` longtext NOT NULL,
  `Salt` char(128) NOT NULL,
  `Tipo` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `User_UNIQUE` (`User`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'usuario1','a3ce765c7ce4093300037b05bb88d06b4279dd04092a89d4b9a20ef33f4503c92fd95e538a56a21f7fcdf9a0cf19aea14e3fd83f0430b1ecfb9fde72da638058','ff2d07caf5bf068bae71cb9d80fc64cd85784b9807ca7bb638decfcc51547c8b6242022ac64d5d3e594eeb4a1fbc25c805e5bd5c7ad2a84f82dcb93a9abee0fd',0),(2,'usuario2','aaa308ee2922e2c92accf5eef37021363bafde09391a20f1246f4821441485c4fe5205987def53564c5ead224f55dcf49e184fbcd6d8590dd4224c84f3fe3291','098a3ddca46f063b4b8a28b3831318485f84021fe292b55adf4d3772c9c52c5f6c0df0a60d3b11e51f93ca551c76de331e754ec3ef7366cf8bf5e35ee914d094',0);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'dbcpdf'
--

--
-- Dumping routines for database 'dbcpdf'
--
/*!50003 DROP PROCEDURE IF EXISTS `ActualizarUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarUsuario`(
IN p_Id int,
   IN p_User VARCHAR(45),
  IN p_Contrasenia VARCHAR(256)
)
BEGIN
DECLARE p_Salt CHAR(128);
  DECLARE p_HashedPassword VARCHAR(256);
  
  -- Genera una sal aleatoria
  SET p_Salt = SHA2(UUID(), 512);
  
  -- Hashea la contraseña con la sal
  SET p_HashedPassword = SHA2(CONCAT(p_Contrasenia, p_Salt), 512);
  
  -- Actualiza el usuario en la tabla
  UPDATE Usuario
  SET  Contrasenia = p_HashedPassword, Salt = p_Salt,
  User=p_User
  WHERE ID = p_Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarUsuario`(
   IN p_User VARCHAR(45),
  IN p_Contrasenia VARCHAR(256)
)
BEGIN
DECLARE p_Salt CHAR(128);
  DECLARE p_HashedPassword VARCHAR(256);
  
  -- Genera una sal aleatoria
  SET p_Salt = SHA2(UUID(), 512);
  
  -- Hashea la contraseña con la sal
  SET p_HashedPassword = SHA2(CONCAT(p_Contrasenia, p_Salt), 512);
  
  -- Inserta el nuevo usuario en la tabla
  INSERT INTO Usuario ( User, Contrasenia,Salt)
  VALUES (p_User,p_HashedPassword,p_Salt);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Login`(
IN p_Usuario VARCHAR(45),
  IN p_Contrasenia VARCHAR(256)
)
BEGIN
DECLARE p_HashedPassword VARCHAR(256);
  
  -- Hashea la contraseña con la sal
  SET p_HashedPassword = SHA2(CONCAT(p_Contrasenia, (SELECT Salt FROM Usuario WHERE User = p_Usuario)), 512);
  
  -- Recupera el usuario en base a las credenciales
  SELECT Id,User,Tipo FROM Usuario WHERE User = p_Usuario AND Contrasenia = p_HashedPassword;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-13 11:12:17