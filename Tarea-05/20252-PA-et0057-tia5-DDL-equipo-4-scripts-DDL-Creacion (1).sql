-- Tarea 5 - Parte #1 del Proyecto de Aula
-- SCRIPTS DE CREACIÃ“N DE LA BASE DE DATOS
--
-- Miembros del grupo
--Diego Ordoñez
--Juan Felipe Serna 
--Maria Fernanda Rodriguez
--Juan Camilo Valencia


CREATE DATABASE hce_antioquia;

-- Tabla 1
CREATE TABLE eps (
	codigo_eps INT PRIMARY KEY,
    nombre_eps VARCHAR(50) NOT NULL UNIQUE
);

-- Tabla 2
CREATE TABLE ciudad (
    codigo_ciudad INT PRIMARY KEY,
    nombre_ciudad VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL
);

-- Tabla 3
CREATE TABLE especialidad (
    codigo_especialidad INT PRIMARY KEY,
    nombre_especialidad VARCHAR(50) NOT NULL
);

-- Tabla 4
CREATE TABLE medicamento (
    sku_medicamento INT PRIMARY KEY,
    nombre_medicamento VARCHAR(50) UNIQUE
);

-- Tabla 5
CREATE TABLE visitante (
    cedula_visitante VARCHAR(15)PRIMARY KEY,
    nombre_visitante VARCHAR(50) NOT NULL,
    apellido_visitante VARCHAR(50) NOT NULL
);


-- Tabla 6 
CREATE TABLE planta (
    numero_planta INT PRIMARY KEY,
    cantidad_cuarto INT NOT NULL
);



-- Tabla 7 
    CREATE TABLE paciente (
    cedula_paciente VARCHAR(15)PRIMARY KEY,
    nombre_paciente VARCHAR(50) NOT NULL,
    apellido_paciente VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL ,
    sexo CHAR(1) NOT NULL,
    contacto1_paciente VARCHAR(12)NOT NULL,
    contacto2_paciente VARCHAR(12),
    codigo_eps INT NOT NULL,
    codigo_ciudad INT NOT NULL,
    ingreso DATE NOT NULL,
    alta DATE,
    FOREIGN KEY (codigo_eps) REFERENCES eps(codigo_eps),
    FOREIGN KEY (codigo_ciudad) REFERENCES ciudad(codigo_ciudad)
);

-- Tabla 8
CREATE TABLE hospital (
    codigo_hospital INT PRIMARY KEY,
    nombre_hospital VARCHAR(50) NOT NULL,
    codigo_ciudad INT NOT NULL,
    FOREIGN KEY (codigo_ciudad) REFERENCES ciudad(codigo_ciudad) 
);

-- Tabla 9
CREATE TABLE medico (
    codigo_medico INT PRIMARY KEY,
    nombre_medico VARCHAR(50) NOT NULL,
    apellido_medico VARCHAR(50) NOT NULL,
    contacto_medico VARCHAR(25)NOT NULL,
    codigo_especialidad INT,
    FOREIGN KEY (codigo_especialidad) REFERENCES especialidad(codigo_especialidad)
);



-- Tabla 10
CREATE TABLE cuarto (
    numero_cuarto INT PRIMARY KEY,
    numero_planta INT NOT NULL,
    FOREIGN KEY (numero_planta) REFERENCES planta(numero_planta)
);

-- Tabla 11
CREATE TABLE tarjeta (
    id_tarjeta INT PRIMARY KEY,
    cedula_paciente VARCHAR(15)NOT NULL,
    cedula_visitante VARCHAR(15)NOT NULL,
    hora_inicio TIME,
    hora_fin TIME,
    FOREIGN KEY (cedula_paciente) REFERENCES paciente(cedula_paciente),
    FOREIGN KEY (cedula_visitante) REFERENCES visitante(cedula_visitante)
);

-- Tabla 12
CREATE TABLE consulta (
    id_consulta SERIAL PRIMARY KEY,
    cedula_paciente VARCHAR(15)NOT NULL,
    codigo_medico INT NOT NULL,
    fecha_atencion DATE NOT NULL,
    motivo_consulta VARCHAR(180),
    FOREIGN KEY (cedula_paciente) REFERENCES paciente(cedula_paciente),
    FOREIGN KEY (codigo_medico) REFERENCES medico(codigo_medico)
);



-- Tabla 13
CREATE TABLE cama (
    numero_cama INT PRIMARY KEY,
    numero_cuarto INT NOT NULL,
    FOREIGN KEY (numero_cuarto) REFERENCES cuarto(numero_cuarto)
);

-- Tabla 14
CREATE TABLE diagnostico (
    codigo_diagnostico INT PRIMARY KEY,
    nombre_diagnostico VARCHAR(80) NOT NULL,
    id_consulta INT NOT NULL UNIQUE, 
    FOREIGN KEY (id_consulta) REFERENCES consulta(id_consulta)
);




-- Tabla 15
CREATE TABLE paciente_cama (
    id_asignacion SERIAL PRIMARY KEY,
    cedula_paciente VARCHAR(15)NOT NULL,
    numero_cama INT NOT NULL,
    fecha_asignacion DATE NOT NULL,
    fecha_liberacion DATE,
    FOREIGN KEY (cedula_paciente) REFERENCES paciente(cedula_paciente),
    FOREIGN KEY (numero_cama) REFERENCES cama(numero_cama)
);


-- Tabla 16
CREATE TABLE tratamiento (
    id_tratamiento SERIAL PRIMARY KEY,
    codigo_diagnostico INT NOT NULL,
    FOREIGN KEY (codigo_diagnostico) REFERENCES diagnostico(codigo_diagnostico)
);

-- Tabla 17
CREATE TABLE medicamento_tratamiento (
    id_medicamento_tratamiento SERIAL PRIMARY KEY,
    id_tratamiento INT NOT NULL,
    sku_medicamento INT NOT NULL,
    cantidad_medicamento INT NOT NULL,
    frecuencia_medicamento DECIMAL(4,2),
    FOREIGN KEY (id_tratamiento) REFERENCES tratamiento(id_tratamiento),
    FOREIGN KEY (sku_medicamento) REFERENCES medicamento(sku_medicamento)
);
