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
