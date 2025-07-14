/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE IF NOT EXISTS `ugds` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `ugds`;

CREATE TABLE IF NOT EXISTS `cliente` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cedula` char(13) NOT NULL DEFAULT '',
  `nombre` varchar(50) NOT NULL DEFAULT '',
  `correo` varchar(100) NOT NULL DEFAULT '',
  `direcc` varchar(250) NOT NULL DEFAULT '',
  `telefono` varchar(10) NOT NULL DEFAULT '',
  `estado` tinyint(1) NOT NULL DEFAULT 0,
  `fecact` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index2` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 `PAGE_COMPRESSED`='ON';

CREATE TABLE IF NOT EXISTS `facdet` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `facid` int(11) unsigned NOT NULL DEFAULT 0,
  `iteid` int(11) unsigned NOT NULL DEFAULT 0,
  `cantid` double(10,2) unsigned NOT NULL DEFAULT 0.00,
  `prcvta` double(10,2) unsigned NOT NULL DEFAULT 0.00,
  `totnet` double(10,2) unsigned NOT NULL DEFAULT 0.00,
  `tipdet` char(1) NOT NULL DEFAULT 'P',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index2` (`facid`,`id`) USING BTREE,
  CONSTRAINT `FK_facdet_factura` FOREIGN KEY (`facid`) REFERENCES `factura` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 `PAGE_COMPRESSED`='ON';

CREATE TABLE IF NOT EXISTS `factura` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `codcli` char(13) NOT NULL DEFAULT '',
  `ordid` int(11) NOT NULL DEFAULT 0,
  `codtec` char(10) NOT NULL DEFAULT '',
  `totbru` double(10,2) NOT NULL DEFAULT 0.00,
  `totiva` double(10,2) NOT NULL DEFAULT 0.00,
  `totnet` double(10,2) NOT NULL DEFAULT 0.00,
  `estado` tinyint(1) NOT NULL DEFAULT 0,
  `obsini` text DEFAULT NULL,
  `obsfin` text DEFAULT NULL,
  `fecemi` date DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_factura_cliente` (`codcli`),
  KEY `FK_factura_tecnico` (`codtec`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 `PAGE_COMPRESSED`='ON';

CREATE TABLE IF NOT EXISTS `items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tipo` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT '0 Producto, 1 Servicio',
  `refere` varchar(25) NOT NULL DEFAULT '',
  `nombre` varchar(100) NOT NULL DEFAULT '',
  `marca` varchar(30) NOT NULL DEFAULT '',
  `cantid` double(10,2) unsigned NOT NULL DEFAULT 0.00,
  `costo` double(10,2) unsigned NOT NULL DEFAULT 0.00,
  `prcvta` double(10,2) unsigned NOT NULL DEFAULT 0.00,
  `estado` tinyint(1) NOT NULL DEFAULT 0,
  `fecact` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='productos/servicios' `PAGE_COMPRESSED`='ON';

CREATE TABLE IF NOT EXISTS `orddet` (
  `id` int(11) unsigned NOT NULL DEFAULT 0,
  `ordid` int(11) unsigned NOT NULL DEFAULT 0,
  `tipdet` int(1) unsigned NOT NULL DEFAULT 0 COMMENT '0 Observ, 1 Ingreso Rep, 2 Ingreso Serv',
  `fecdet` datetime DEFAULT NULL,
  `iteid` int(11) unsigned NOT NULL DEFAULT 0,
  `prcvta` double(10,2) unsigned NOT NULL DEFAULT 0.00,
  `cantid` double(10,2) unsigned NOT NULL DEFAULT 0.00,
  `estado` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `observ` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_orddet_orden` (`ordid`),
  CONSTRAINT `FK_orddet_orden` FOREIGN KEY (`ordid`) REFERENCES `orden` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 `PAGE_COMPRESSED`='ON';

CREATE TABLE IF NOT EXISTS `orden` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `codcli` char(13) NOT NULL DEFAULT '',
  `codtec` char(10) NOT NULL DEFAULT '',
  `marca` varchar(50) NOT NULL DEFAULT '',
  `modelo` varchar(50) NOT NULL DEFAULT '',
  `imei` varchar(15) NOT NULL DEFAULT '',
  `observ` text NOT NULL DEFAULT '',
  `fecing` datetime DEFAULT NULL,
  `fecfac` datetime DEFAULT NULL,
  `estado` char(1) NOT NULL DEFAULT 'A',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_orden_cliente` (`codcli`),
  KEY `FK_orden_tecnico` (`codtec`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 `PAGE_COMPRESSED`='ON';

CREATE TABLE IF NOT EXISTS `ordlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ordid` int(11) unsigned NOT NULL,
  `feclog` datetime DEFAULT NULL,
  `observ` text NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `FK_ordlog_orden` (`ordid`),
  CONSTRAINT `FK_ordlog_orden` FOREIGN KEY (`ordid`) REFERENCES `orden` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 `PAGE_COMPRESSED`='ON';

CREATE TABLE IF NOT EXISTS `registro` (
  `userid` char(10) NOT NULL DEFAULT '' COMMENT 'codigo de user',
  `fecexp` char(15) NOT NULL DEFAULT '0' COMMENT 'fecha unix',
  `token` text DEFAULT NULL,
  `ipnum` char(15) NOT NULL DEFAULT '' COMMENT 'numero de ip',
  `fecact` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 `PAGE_COMPRESSED`='ON';

CREATE TABLE IF NOT EXISTS `tecnico` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cedula` char(10) NOT NULL DEFAULT '',
  `nombre` varchar(50) NOT NULL DEFAULT '',
  `correo` varchar(100) NOT NULL DEFAULT '',
  `direcc` varchar(250) NOT NULL DEFAULT '',
  `telefono` varchar(10) NOT NULL DEFAULT '',
  `estado` tinyint(4) NOT NULL DEFAULT 0,
  `fecact` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `Índice 2` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 `PAGE_COMPRESSED`='ON';

CREATE TABLE IF NOT EXISTS `users` (
  `usuario` char(10) NOT NULL DEFAULT '',
  `clave` varchar(20) NOT NULL DEFAULT '',
  `nombre` varchar(50) NOT NULL DEFAULT '',
  `correo` varchar(150) NOT NULL DEFAULT '',
  `tipusr` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT '0 Admin, 1 Tecnico, 2 Caja',
  `estado` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 Activo, 9 Inactivo',
  `fecact` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'fecha',
  PRIMARY KEY (`usuario`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 `PAGE_COMPRESSED`='ON';

DELIMITER //
CREATE PROCEDURE `SP_ACTUALIZA_CLIENTE`(
	IN `id_cliente` CHAR(11),
	IN `cedula` CHAR(13),
	IN `nombre` VARCHAR(50),
	IN `telefe` VARCHAR(10),
	IN `correo` VARCHAR(100),
	IN `direcc` VARCHAR(250)
)
BEGIN
    UPDATE cliente
    SET
        nombre = nombre,
        correo = correo,
        cedula = cedula,
        direcc = direcc,
        telefono = telefe,
        fecact = NOW()
    WHERE id = id_cliente;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `SP_ACTUALIZA_PRODUCTO`(
	IN `p_id` INT,
	IN `p_descri` VARCHAR(100),
	IN `p_refere` VARCHAR(25),
	IN `p_marca` VARCHAR(30),
	IN `p_cantid` DOUBLE(10,2),
	IN `p_prcvta` DOUBLE(10,2),
	IN `p_prccpa` DOUBLE(10,2)
)
BEGIN
    UPDATE items
    SET nombre = p_descri,
        refere = p_refere,
        marca = p_marca,
        cantid = p_cantid,
        costo = p_prccpa,
        prcvta = p_prcvta
    WHERE id = p_id AND tipo = 0;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `SP_ACTUALIZA_SERVICIO`(
	IN `s_id` INT,
	IN `s_descri` VARCHAR(100),
	IN `s_refere` VARCHAR(25),
	IN `s_prcvta` DOUBLE(10,2)
)
BEGIN
    UPDATE `items`
    SET `nombre` = s_descri,
        `refere` = s_refere,
        `prcvta` = s_prcvta
    WHERE `id` = s_id AND `tipo` = 1;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `SP_ACTUALIZA_TECNICO`(
	IN `id_tec` CHAR(11),
	IN `nombre` VARCHAR(50),
	IN `cedula` CHAR(10),
	IN `telefe` VARCHAR(10),
	IN `correo` VARCHAR(100),
	IN `direcc` VARCHAR(250)
)
BEGIN
    UPDATE tecnico
    SET cedula = cedula,
        nombre = nombre,
        correo = correo,
        direcc = direcc,
        telefono = telefe,
        fecact = NOW()
    WHERE id = id_tec;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `SP_CREA_CLIENTE`(
	IN `cedula` CHAR(13),
	IN `nombre` VARCHAR(50),
	IN `telefe` VARCHAR(10),
	IN `correo` VARCHAR(100),
	IN `direcc` VARCHAR(250)
)
BEGIN
    INSERT INTO cliente (
        cedula, nombre, correo, direcc, telefono, estado, fecact
    ) VALUES (
        cedula, nombre, correo, direcc, telefe, 0, NOW()
    );
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `SP_CREA_ORDEN`(
    IN id_cli CHAR(13),
    IN id_tec CHAR(10),
    IN fecing DATETIME,
    IN marca VARCHAR(50),
    IN modelo VARCHAR(50),
    IN imei VARCHAR(15),
    IN observ TEXT,
    IN estado CHAR(1)
)
BEGIN
    INSERT INTO orden (
        codcli, codtec, fecing, marca, modelo, imei, observ, estado
    ) VALUES (
        id_cli, id_tec, fecing, marca, modelo, imei, observ, 
        IF(estado = 'A', 1, 0)
    );
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `SP_CREA_PRODUCTO`(
	IN `p_descri` VARCHAR(100),
	IN `p_refere` VARCHAR(25),
	IN `p_marca` VARCHAR(30),
	IN `p_cantid` DOUBLE(10,2),
	IN `p_prcvta` DOUBLE(10,2),
	IN `p_prccpa` DOUBLE(10,2)
)
BEGIN
    INSERT INTO `items` (`tipo`, `nombre`, `refere`, `marca`, `cantid`, `costo`, `prcvta`, `estado`)
    VALUES (0, p_descri, p_refere, p_marca, p_cantid, p_prccpa, p_prcvta, 0);
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `SP_CREA_SERVICIO`(
	IN `s_descri` VARCHAR(100),
	IN `s_refere` VARCHAR(25),
	IN `s_prcvta` DOUBLE(10,2)
)
BEGIN
    INSERT INTO `items` (`tipo`, `nombre`, `refere`, `marca`, `cantid`, `costo`, `prcvta`, `estado`)
    VALUES (1, s_descri, s_refere, '', 0, 0.00, s_prcvta, 0);
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `SP_CREA_TECNICO`(
    IN nombre VARCHAR(50),
    IN cedula CHAR(10),
    IN telefe VARCHAR(10),
    IN correo VARCHAR(100),
    IN direcc VARCHAR(250)
)
BEGIN
    INSERT INTO tecnico (id, nombre, correo, direcc, telefono, estado, fecact)
    VALUES (cedula, nombre, correo, direcc, telefe, 1, NOW());
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `SP_ELIMINA_CLIENTE`(
    IN id_cliente CHAR(13)
)
BEGIN
    DELETE FROM cliente WHERE id = id_cliente;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `SP_ELIMINA_PRODUCTO`(
	IN `p_id` INT
)
BEGIN
    DELETE FROM `items` WHERE `id` = p_id AND `tipo` = 0;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `SP_ELIMINA_SERVICIO`(
	IN `s_id` INT
)
BEGIN
    DELETE FROM `items` WHERE `id` = s_id AND `tipo` = 1;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `SP_ELIMINA_TECNICO`(
	IN `t_id` CHAR(10)
)
BEGIN
    DELETE FROM tecnico WHERE id = t_id;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `SP_GET_ALL`(
	IN `nombre_tabla` VARCHAR(50)
)
    COMMENT 'consultas generales'
BEGIN
    DECLARE v_sql TEXT;

    -- Validación básica
    IF nombre_tabla IS NULL OR nombre_tabla = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nombre de tabla no válida';
    END IF;

    -- Construcción de consulta
    SET v_sql = CONCAT('SELECT * FROM `', nombre_tabla, '`');
    PREPARE stmt FROM v_sql;
    EXECUTE stmt;

    DEALLOCATE PREPARE stmt;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `SP_GET_ALL_ITEMS`()
BEGIN
    DECLARE v_sql TEXT;

    -- Construcción de consulta
    SET v_sql = 'SELECT * FROM items WHERE tipo = 0';

    PREPARE stmt FROM v_sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `SP_GET_ALL_SERV`()
BEGIN
    DECLARE v_sql TEXT;

    -- Construcción de consulta
    SET v_sql = 'SELECT * FROM items WHERE tipo = 1';

    PREPARE stmt FROM v_sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `SP_GET_ORDDET`(
    IN idord INT UNSIGNED
)
BEGIN
    SELECT 
        d.id,
        d.ordid,
        d.tipdet,
        d.fecdet,
        d.iteid,
        i.nombre AS item_nombre,
        d.prcvta,
        d.cantid,
        d.observ,
        d.estado
    FROM orddet d
    LEFT JOIN items i ON d.iteid = i.id
    WHERE d.ordid = idord
    ORDER BY d.fecdet ASC;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `SP_GET_ORDENES`(
	IN `tipo` CHAR(1)
)
BEGIN
    IF tipo = 'A' THEN
        SELECT o.id,
        o.codcli,
        c.nombre AS cliente,
        o.codtec,
        t.nombre AS tecnico,
        o.marca,
        o.modelo,
        o.imei,
        o.observ,
        o.fecing,
        o.fecfac,
        o.estado FROM orden o
        INNER JOIN cliente c ON o.codcli = c.id
        INNER JOIN tecnico t ON o.codtec = t.id
        WHERE o.estado = 0;
    ELSEIF tipo = 'F' THEN
        SELECT o.id,
        o.codcli,
        c.nombre AS cliente,
        o.codtec,
        t.nombre AS tecnico,
        o.marca,
        o.modelo,
        o.imei,
        o.observ,
        o.fecing,
        o.fecfac,
        o.estado FROM orden o
        INNER JOIN cliente c ON o.codcli = c.id
        INNER JOIN tecnico t ON o.codtec = t.id
        WHERE o.estado = 1;
    ELSE
        SELECT o.id,
        o.codcli,
        c.nombre AS cliente,
        o.codtec,
        t.nombre AS tecnico,
        o.marca,
        o.modelo,
        o.imei,
        o.observ,
        o.fecing,
        o.fecfac,
        o.estado FROM orden o
        INNER JOIN cliente c ON o.codcli = c.id
        INNER JOIN tecnico t ON o.codtec = t.id;
    END IF;
    
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `SP_GET_RECORD`(
	IN `id` VARCHAR(11),
	IN `nombre_tabla` VARCHAR(50)
)
BEGIN
    DECLARE v_sql TEXT;

    -- Validación básica
    IF nombre_tabla IS NULL OR nombre_tabla = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nombre de tabla no válida';
    END IF;

    -- Pasar valor del parámetro a variable de sistema
    SET @id_param = id;

    -- Construcción y ejecución
    SET v_sql = CONCAT('SELECT * FROM `', nombre_tabla, '` WHERE id = ?');
    PREPARE stmt FROM v_sql;
    EXECUTE stmt USING @id_param;
    DEALLOCATE PREPARE stmt;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `SP_GRABA_FACDET`(
    IN id_fac INT UNSIGNED,
    IN id_ite INT UNSIGNED,
    IN tipdet CHAR(1),
    IN prcvta DOUBLE(10,2),
    IN cantid DOUBLE(10,2),
    IN totnet DOUBLE(10,2)
)
BEGIN
    DECLARE tipo_valido BOOLEAN;

    -- Validar tipo de detalle (opcional, depende de tu lógica)
    SET tipo_valido = tipdet IN ('P', 'S'); -- Por ejemplo: 'P' producto, 'S' servicio

    IF NOT tipo_valido THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tipo de detalle no válido (tipdet)';
    END IF;

    -- Inserción del detalle
    INSERT INTO facdet (
        facid,
        iteid,
        cantid,
        prcvta,
        totnet
    )
    VALUES (
        id_fac,
        id_ite,
        cantid,
        prcvta,
        totnet
    );
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `SP_GRABA_FACTURA`(
    IN id_cli CHAR(13),
    IN id_tec CHAR(10),
    IN fecfac DATE,
    IN id_ord INT,
    IN totbru DOUBLE(10,2),
    IN totiva DOUBLE(10,2),
    IN totnet DOUBLE(10,2),
    IN obsini TEXT,
    IN obsfin TEXT,
    IN estado CHAR(1),
    OUT ultimoId INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- En caso de error, establece el id en 0
        SET ultimoId = 0;
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO factura (
        codcli, codtec, fecemi, ordid,
        totbru, totiva, totnet,
        obsini, obsfin, estado
    )
    VALUES (
        id_cli, id_tec, fecfac, id_ord,
        totbru, totiva, totnet,
        obsini, obsfin, estado
    );

    SET ultimoId = LAST_INSERT_ID();

    COMMIT;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `SP_GRABA_ORDDET`(
    IN id_ord INT UNSIGNED,
    IN id_ite INT UNSIGNED,
    IN fecdet DATETIME,
    IN tipdet TINYINT UNSIGNED,
    IN prcvta DOUBLE(10,2),
    IN cantid DOUBLE(10,2),
    IN observ TEXT,
    IN estado CHAR(1)
)
BEGIN
    DECLARE new_id INT;

    -- Obtener último ID actual + 1 para asignarlo manualmente (si no usas AUTO_INCREMENT)
    SELECT IFNULL(MAX(id), 0) + 1 INTO new_id FROM orddet;

    INSERT INTO orddet (
        id, ordid, iteid, fecdet, tipdet, prcvta, cantid, observ, estado
    ) VALUES (
        new_id, id_ord, id_ite, fecdet, tipdet, prcvta, cantid, observ,
        IF(estado = 'A', 1, 0)
    );
END//
DELIMITER ;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

INSERT INTO `users` (`usuario`, `clave`, `nombre`, `correo`, `tipusr`, `estado`, `fecact`) VALUES
	('admin', 'admin1234', 'Administrador', 'admin@algo.com', 0, 0, '2025-07-10 22:31:59'),
	('cajero', 'cajero1234', 'Cajero', 'cajero@algo.com', 2, 0, '2025-07-10 22:32:10');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
