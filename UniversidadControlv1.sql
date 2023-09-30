/*
    Creado Por: I.S.C Martin Cruz Medinilla
    Base de datos: ControlEscolarUniAng
    Fecha Creación: Septiembre 2023
    Modificaciónes:
    ==================================================
    Fecha: 26 Septiembre 
    Cambios: se agregan mas tablas
*/


CREATE TABLE TipoUsuario(
    TipoUsuarioId INTEGER AUTO_INCREMENT,
    NombreTipo VARCHAR(50),
    FechaRegistro DATETIME DEFAULT NOW(),
    PRIMARY KEY(TipoUsuarioId)
);
INSERT INTO TipoUsuario(NombreTipo) 
    VALUES('Alumno'),('Docente');

CREATE TABLE Usuario(
    UsuarioId INTEGER AUTO_INCREMENT,
    NickName VARCHAR(50) UNIQUE,
    Contrasenia VARCHAR(50),
    TipoUsuarioId INTEGER,
    UltimoAcceso DATETIME,
    FechaRegistro DATETIME DEFAULT NOW(),
    Activo BOOLEAN,
    PRIMARY KEY(UsuarioId),
    CONSTRAINT fk_usuarioTipoUsuario 
    FOREIGN KEY (TipoUsuarioId) REFERENCES TipoUsuario (TipoUsuarioId)
);
INSERT INTO Usuario(NickName, Contrasenia, TipoUsuarioId, Activo) 
    VALUES('usuarioGenerico', MD5('12345'),1,1),('codemcm', MD5('12345'),2,1);
CREATE TABLE Carrera(
    CarreraId INTEGER AUTO_INCREMENT,
    Nombre VARCHAR(50),
    Clave VARCHAR(50),
    Active BOOLEAN DEFAULT 1,
    CreatedBy INTEGER,
    PRIMARY KEY(CarreraId)
);

INSERT INTO Carrera (Nombre, Clave, CreatedBy) VALUES('ING SISTEMAS', 'CLVSISTEMAS', 1);

CREATE TABLE EstatusEst(
    EstatusEstId INT AUTO_INCREMENT,
    NombreEstatus VARCHAR(50),
    Active BOOLEAN DEFAULT 1,
    PRIMARY KEY(EstatusEstId)
);
INSERT INTO EstatusEst (NombreEstatus) VALUES('Activo'),('Baja');

CREATE TABLE Periodo(
    PeriodoId INT AUTO_INCREMENT,
    NombrePeriodo VARCHAR(50),
    PRIMARY KEY(PeriodoId)
);
INSERT INTO Periodo (NombrePeriodo) VALUES('EneroJunio'),('AgostoDiciembre');

CREATE TABLE Estudiante(
    EstudianteId INTEGER AUTO_INCREMENT,
    Nombre VARCHAR(50),
    APaterno VARCHAR(50),
    AMaterno VARCHAR(50),
    AnioIngreso INT,
    PeriodoId INT, 
    Celular VARCHAR(10),
    Email VARCHAR(30),
    EstatusEstId INTEGER DEFAULT 1,
    FechaNacimiento DATE,
    UsuarioId INTEGER,
    CreadoPor INTEGER,
    CarreraId INTEGER,
    PRIMARY KEY(EstudianteId),
    CONSTRAINT fk_EstudianteCarrera 
    FOREIGN KEY (CarreraId) REFERENCES Carrera(CarreraId),
    CONSTRAINT fk_EstudianteEstatusEst
    FOREIGN KEY (EstatusEstId) REFERENCES EstatusEst(EstatusEstId),
    CONSTRAINT fk_EstudianteUsuario
    FOREIGN KEY (UsuarioId) REFERENCES Usuario(UsuarioId),
    CONSTRAINT fk_EstudianteUsuarioMetadata
    FOREIGN KEY (CreadoPor) REFERENCES Usuario(UsuarioId),
    CONSTRAINT fk_EstudiantePeriodo
    FOREIGN KEY (PeriodoId) REFERENCES Periodo(PeriodoId)
);
/*5° SEMESTRE*/
INSERT INTO Estudiante (Nombre, APaterno, AMaterno, AnioIngreso, PeriodoId, celular, email, EstatusEstId, UsuarioId, CreadoPor, CarreraId)
    VALUES('Agustin','Alvarez','Velasco',2023,1,'9516101498','velaajustin28@gmail.com', 1, 1, 2, 1),
        ('Janeth Carola', 'Martin', 'Velazquez',2023,1, 2382528793,'janettecaro54@gmail.com', 1, 1, 2, 1),
        ('Alexander','Hernandez','De La Luz',2023,1, 2361228744,'alexanderhdl13@gmail.com ', 1, 1, 2, 1),
        ('Clara','Carvajal','Ramirez',2023,1, 2381196281,'clara.carvram@gmail.com', 1, 1, 2, 1);
/*3°*/
INSERT INTO Estudiante (Nombre, APaterno, AMaterno, AnioIngreso, PeriodoId, celular, email, EstatusEstId, UsuarioId, CreadoPor, CarreraId)
    VALUES('Abigail','Mendoza','Ortega',2022,1, 2384095818,'m.o.abigail7@gmail.com', 1, 1, 2, 1),
        ('Rigoberto','Gregorio','Guerrero',2022,1, '9511114529','rigoberto.aguilas04@gmail.com', 1, 1, 2, 1),
        ('Iris Lizeth','Sanchez','Garcia',2022,1,'2381817068','sanchezgarciairislizeth@gmail.com', 1, 1, 2, 1),
        ('Wemdy','Mayoral','Fuentes',2022,1,'9531433162','wendymayoralfuentes@gmail.com', 1, 1, 2, 1);
        
CREATE TABLE Materia(
    MateriaId INT AUTO_INCREMENT,
    Nombre VARCHAR(50) UNIQUE,
    Active boolean DEFAULT TRUE,
    Clave VARCHAR(12) UNIQUE,
    CarreraId INTEGER,
    PRIMARY KEY(MateriaId),
    CONSTRAINT fk_MateriaCarreraId
    FOREIGN KEY (CarreraId) REFERENCES Carrera(CarreraId)
);
INSERT INTO Materia(Nombre, Clave, CarreraId)
    VALUES('Sistemas de información','sistemasInfo',1),
            ('Automatas Finitos','automatas',1),
            ('Métodos Estadisticos','metEstad',1),
            ('Bases de datos distribuidas','bddistribuidas',1),
            ('Investigación de Operaciones','ioOperaciones',1);
CREATE TABLE Profesor(
    ProfesorId INT AUTO_INCREMENT,
    Nombre VARCHAR(50),
    APaterno VARCHAR(50),
    AMaterno VARCHAR(50),
    Active BOOLEAN DEFAULT TRUE,
    RFC VARCHAR(30) UNIQUE,
    CarreraId INTEGER, 
    PRIMARY KEY(ProfesorId),
    CONSTRAINT fk_ProfesorCarreraId
    FOREIGN KEY (CarreraId) REFERENCES Carrera(CarreraId)
);
INSERT INTO Profesor(Nombre, APaterno, AMaterno, RFC, CarreraId)
    VALUES('Martin', 'Cruz', 'Medinilla', 'rfcmartin',1);

CREATE TABLE Clase(
    ClaseId INT AUTO_INCREMENT,
    Nombre VARCHAR(50),
    Horario VARCHAR(500),
    MateriaId INTEGER,
    Active BOOLEAN DEFAULT TRUE,
    ProfesorId INTEGER,
    PRIMARY KEY(ClaseId),
    CONSTRAINT fk_ClaseProfesorId
    FOREIGN KEY (ProfesorId) REFERENCES Profesor(ProfesorId)
);
INSERT INTO Clase(Nombre, Horario, MateriaId, ProfesorId)
    VALUES('SistemasInformacion', '8:00-9:00', 1, 1);

CREATE TABLE TipoActividad(
    TipoActividadId INT AUTO_INCREMENT,
    Nombre VARCHAR(50),
    Observaciones VARCHAR(500),
    PRIMARY KEY(TipoActividadId)
);
INSERT INTO TipoActividad(Nombre) VALUES('Tarea'),('Puntos Extra');

CREATE TABLE Actividad(
    ActividadId INTEGER AUTO_INCREMENT,
    Nombre VARCHAR(50),
    Descripcion VARCHAR(50),
    ClaseId INTEGER,
    ValorMaximo INTEGER,
    FechaExpiracion DATE,
    FechaRegistro DATE DEFAULT NOW(), 
    TipoActividadId INTEGER NOT NULL,
    PRIMARY KEY(ActividadId),
    CONSTRAINT fk_ActividadClase
    FOREIGN KEY (ClaseId) REFERENCES Clase (ClaseId),
    CONSTRAINT fk_ActividadTipoActividadId
    FOREIGN KEY (TipoActividadId) REFERENCES TipoActividad(TipoActividadId)
);
INSERT INTO Actividad(Nombre, Descripcion, ClaseId, ValorMaximo, TipoActividadId)
    VALUES('Script bd control escolar', 'script para sistema',1, 10, 1);

CREATE TABLE EstudianteActividad(
    EstudianteActividadId INT AUTO_INCREMENT,
    FechaRegistro DATETIME DEFAULT NOW(),
    Calificacion INTEGER,
    EstudianteId INTEGER,
    ClaseId INTEGER,
    ActividadId INTEGER, 
    PRIMARY KEY(EstudianteActividadId),
    CONSTRAINT fk_EstudianteActividadEstudiante
    FOREIGN KEY (EstudianteId) REFERENCES Estudiante (EstudianteId),
    CONSTRAINT fk_EstudianteActividadClaseId
    FOREIGN KEY (ClaseId) REFERENCES Clase(ClaseId),
    CONSTRAINT fk_EstudianteActividadActividadId
    FOREIGN KEY (ActividadId) REFERENCES Actividad(ActividadId)
);

CREATE TABLE Version(
    VersionId INTEGER AUTO_INCREMENT,
    Descripcion VARCHAR(6),
    VersionBD VARCHAR(6),
    VersionSistema INTEGER,
    Notas TEXT,
    PRIMARY KEY(VersionId)
);

CREATE TABLE Estado(
    EstadoId INTEGER AUTO_INCREMENT,
    Clave VARCHAR(50),
    Nombre VARCHAR(50) UNIQUE,
    PRIMARY KEY(EstadoId)
);

CREATE TABLE Ciudad(
    CiudadId INTEGER AUTO_INCREMENT,
    NombreCiudad VARCHAR(50) UNIQUE,
    Clave VARCHAR(50),
    EstadoId INTEGER,
    PRIMARY KEY(CiudadId)
);
