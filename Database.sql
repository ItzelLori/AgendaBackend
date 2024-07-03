CREATE DATABASE tutorias;
Use tutorias;


CREATE TABLE Profesor (
    `ID_Profesor` int AUTO_INCREMENT NOT NULL,
    `nombre` varchar(255) NOT NULL,
    `correoInstitucional` varchar(255) NOT NULL UNIQUE,
    `contraseña` varchar(255) NOT NULL,
    `Descripcion_profesional` text,
    PRIMARY KEY (`ID_Profesor`)
);

CREATE TABLE Curso (
    `ID_Curso` int AUTO_INCREMENT NOT NULL,
    `nombreCurso` varchar(255) NOT NULL,
    `materia` varchar(255) NOT NULL,
    `instructor` int NOT NULL,
    `Duracion` int,
    `Descripcion` text NOT NULL,
    `Requisitos` text,
    PRIMARY KEY (`ID_Curso`),
    CONSTRAINT `Curso_fk3` FOREIGN KEY (`instructor`) REFERENCES `Profesor`(`ID_Profesor`)
);

CREATE TABLE Alumno (
    `ID_Alumno` int AUTO_INCREMENT NOT NULL,
    `nombre` varchar(255) NOT NULL,
    `correoInstitucional` varchar(255) NOT NULL UNIQUE,
    `contraseña` varchar(255) NOT NULL,
    `boleta` varchar(255) NOT NULL UNIQUE,
    `carrera` varchar(255),
    PRIMARY KEY (`ID_Alumno`)
);

CREATE TABLE CursosInscritos (
    `curso` int NOT NULL,
    `alumnoInscrito` int NOT NULL,
    PRIMARY KEY (`curso`, `alumnoInscrito`),
    CONSTRAINT `CursosInscritos_fk1` FOREIGN KEY (`curso`) REFERENCES `Curso`(`ID_Curso`),
    CONSTRAINT `CursosInscritos_fk2` FOREIGN KEY (`alumnoInscrito`) REFERENCES `Alumno`(`ID_Alumno`)
);

CREATE TABLE Administradores (
    `id_admin` int AUTO_INCREMENT NOT NULL UNIQUE,
    `Nombre` varchar(255) NOT NULL,
    `usuario` varchar(255) NOT NULL UNIQUE,
    `contraseña` varchar(255) NOT NULL,
    PRIMARY KEY (`id_admin`)
);

CREATE TABLE CursosImpartidos (
    `curso` int NOT NULL,
    `instructor` int NOT NULL,
    PRIMARY KEY (`curso`, `instructor`),
    CONSTRAINT `CursosImpartidos_fk1` FOREIGN KEY (`curso`) REFERENCES `Curso`(`ID_Curso`),
    CONSTRAINT `CursosImpartidos_fk2` FOREIGN KEY (`instructor`) REFERENCES `Profesor`(`ID_Profesor`)
);


-- Insertar datos en Profesor
INSERT INTO `Profesor` (`nombre`, `correoInstitucional`, `contraseña`, `Descripcion_profesional`) VALUES
('Juan Pérez', 'juan.perez@instituto.edu', 'password123', 'Profesor de Matemáticas con 10 años de experiencia.'),
('Ana García', 'ana.garcia@instituto.edu', 'password456', 'Especialista en Física Cuántica.');

-- Insertar datos en Curso
INSERT INTO `Curso` (`nombreCurso`, `materia`, `instructor`, `Duracion`, `Descripcion`, `Requisitos`) VALUES
('Cálculo I', 'Matemáticas', 1, 40, 'Curso introductorio de cálculo diferencial e integral.', 'Conocimientos básicos de álgebra.'),
('Física Cuántica Avanzada', 'Física', 2, 60, 'Estudio avanzado de los principios de la mecánica cuántica.', 'Física Cuántica Básica.');

-- Insertar datos en Alumno
INSERT INTO `Alumno` (`nombre`, `correoInstitucional`, `contraseña`, `boleta`, `carrera`) VALUES
('Carlos López', 'carlos.lopez@estudiantes.edu', 'password789', '20210001', 'Ingeniería en Sistemas'),
('María Martínez', 'maria.martinez@estudiantes.edu', 'password012', '20210002', 'Arquitectura');

-- Insertar datos en CursosInscritos
INSERT INTO `CursosInscritos` (`curso`, `alumnoInscrito`) VALUES
(1, 1), -- Carlos López inscrito en Cálculo I
(2, 2); -- María Martínez inscrita en Física Cuántica Avanzada

-- Insertar datos en Administradores
INSERT INTO `Administradores` (`Nombre`, `usuario`, `contraseña`) VALUES
('Admin1', 'admin1', 'adminpass1'),
('Admin2', 'admin2', 'adminpass2');

-- Insertar datos en CursosImpartidos
INSERT INTO `CursosImpartidos` (`curso`, `instructor`) VALUES
(1, 1), -- Juan Pérez imparte Cálculo I
(2, 2); -- Ana García imparte Física Cuántica Avanzada


USE tutorias;


USE tutorias;

-- Borrar registros de las tablas que dependen de otras primero
DELETE FROM CursosInscritos;
DELETE FROM CursosImpartidos;

-- Borrar registros de las tablas que no dependen de otras
DELETE FROM Curso;
DELETE FROM Alumno;
DELETE FROM Profesor;
DELETE FROM Administradores;

ALTER TABLE CursosInscritos AUTO_INCREMENT = 1;
ALTER TABLE CursosImpartidos AUTO_INCREMENT = 1;
ALTER TABLE Curso AUTO_INCREMENT = 1;
ALTER TABLE Alumno AUTO_INCREMENT = 1;
ALTER TABLE Profesor AUTO_INCREMENT = 1;
ALTER TABLE Administradores AUTO_INCREMENT = 1;

-- Borrar registros de las tablas que dependen de otras primero
TRUNCATE TABLE CursosInscritos;
TRUNCATE TABLE CursosImpartidos;

-- Borrar registros de las tablas que no dependen de otras
TRUNCATE TABLE Curso;
TRUNCATE TABLE Alumno;
TRUNCATE TABLE Profesor;
TRUNCATE TABLE Administradores;





CREATE DATABASE tutorias;
USE tutorias;

-- Añadir columnas de auditoría a las tablas existentes
ALTER TABLE Profesor 
ADD COLUMN created_by VARCHAR(255),
ADD COLUMN created_at DATETIME,
ADD COLUMN updated_by VARCHAR(255),
ADD COLUMN updated_at DATETIME;

ALTER TABLE Curso 
ADD COLUMN created_by VARCHAR(255),
ADD COLUMN created_at DATETIME,
ADD COLUMN updated_by VARCHAR(255),
ADD COLUMN updated_at DATETIME;

ALTER TABLE Alumno 
ADD COLUMN created_by VARCHAR(255),
ADD COLUMN created_at DATETIME,
ADD COLUMN updated_by VARCHAR(255),
ADD COLUMN updated_at DATETIME;

ALTER TABLE CursosInscritos 
ADD COLUMN created_by VARCHAR(255),
ADD COLUMN created_at DATETIME,
ADD COLUMN updated_by VARCHAR(255),
ADD COLUMN updated_at DATETIME;

ALTER TABLE Administradores 
ADD COLUMN created_by VARCHAR(255),
ADD COLUMN created_at DATETIME,
ADD COLUMN updated_by VARCHAR(255),
ADD COLUMN updated_at DATETIME;

ALTER TABLE CursosImpartidos 
ADD COLUMN created_by VARCHAR(255),
ADD COLUMN created_at DATETIME,
ADD COLUMN updated_by VARCHAR(255),
ADD COLUMN updated_at DATETIME;


-- Triggers para la tabla Profesor
DELIMITER //

CREATE TRIGGER before_insert_Profesor
BEFORE INSERT ON Profesor
FOR EACH ROW
BEGIN
    SET NEW.created_at = NOW();
    SET NEW.updated_at = NOW();
    SET NEW.created_by = CURRENT_USER();
    SET NEW.updated_by = CURRENT_USER();
END //

CREATE TRIGGER before_update_Profesor
BEFORE UPDATE ON Profesor
FOR EACH ROW
BEGIN
    SET NEW.updated_at = NOW();
    SET NEW.updated_by = CURRENT_USER();
END //

-- Triggers para la tabla Curso
CREATE TRIGGER before_insert_Curso
BEFORE INSERT ON Curso
FOR EACH ROW
BEGIN
    SET NEW.created_at = NOW();
    SET NEW.updated_at = NOW();
    SET NEW.created_by = CURRENT_USER();
    SET NEW.updated_by = CURRENT_USER();
END //

CREATE TRIGGER before_update_Curso
BEFORE UPDATE ON Curso
FOR EACH ROW
BEGIN
    SET NEW.updated_at = NOW();
    SET NEW.updated_by = CURRENT_USER();
END //

-- Triggers para la tabla Alumno
CREATE TRIGGER before_insert_Alumno
BEFORE INSERT ON Alumno
FOR EACH ROW
BEGIN
    SET NEW.created_at = NOW();
    SET NEW.updated_at = NOW();
    SET NEW.created_by = CURRENT_USER();
    SET NEW.updated_by = CURRENT_USER();
END //

CREATE TRIGGER before_update_Alumno
BEFORE UPDATE ON Alumno
FOR EACH ROW
BEGIN
    SET NEW.updated_at = NOW();
    SET NEW.updated_by = CURRENT_USER();
END //

-- Triggers para la tabla CursosInscritos
CREATE TRIGGER before_insert_CursosInscritos
BEFORE INSERT ON CursosInscritos
FOR EACH ROW
BEGIN
    SET NEW.created_at = NOW();
    SET NEW.updated_at = NOW();
    SET NEW.created_by = CURRENT_USER();
    SET NEW.updated_by = CURRENT_USER();
END //

CREATE TRIGGER before_update_CursosInscritos
BEFORE UPDATE ON CursosInscritos
FOR EACH ROW
BEGIN
    SET NEW.updated_at = NOW();
    SET NEW.updated_by = CURRENT_USER();
END //

-- Triggers para la tabla Administradores
CREATE TRIGGER before_insert_Administradores
BEFORE INSERT ON Administradores
FOR EACH ROW
BEGIN
    SET NEW.created_at = NOW();
    SET NEW.updated_at = NOW();
    SET NEW.created_by = CURRENT_USER();
    SET NEW.updated_by = CURRENT_USER();
END //

CREATE TRIGGER before_update_Administradores
BEFORE UPDATE ON Administradores
FOR EACH ROW
BEGIN
    SET NEW.updated_at = NOW();
    SET NEW.updated_by = CURRENT_USER();
END //

-- Triggers para la tabla CursosImpartidos
CREATE TRIGGER before_insert_CursosImpartidos
BEFORE INSERT ON CursosImpartidos
FOR EACH ROW
BEGIN
    SET NEW.created_at = NOW();
    SET NEW.updated_at = NOW();
    SET NEW.created_by = CURRENT_USER();
    SET NEW.updated_by = CURRENT_USER();
END //

CREATE TRIGGER before_update_CursosImpartidos
BEFORE UPDATE ON CursosImpartidos
FOR EACH ROW
BEGIN
    SET NEW.updated_at = NOW();
    SET NEW.updated_by = CURRENT_USER();
END //

DELIMITER ;
