-- Tarea 5 - Parte #1 del Proyecto de Aula
-- SCRIPTS DE MODIFICACIÓN DE LA BASE DE DATOS
--
-- Miembros del grupo
-- 1 MARIA FERNANDA RODRIGUEZ TUBERQUIA
-- 2 DIEGO CAMILO ORDOÑEZ BUSTOS
-- 3 JUAN FELIPE SERNA BEDOYA
-- 4 JUAN CAMILO VALENCIA ESTRADA


-- 5.1 Indices diferentes


-- 1) Índice por apellido del paciente
CREATE INDEX indice_paciente_apellido_paciente
ON paciente (apellido_paciente);

-- 2) Índice por apellido del médico
CREATE INDEX indice_medico_apellido_medico
ON medico (apellido_medico);

-- 3) Índice por fecha de atención de la consulta
CREATE INDEX indice_consulta_fecha_atencion
ON consulta (fecha_atencion);

-- 4) Índice por número de cama en la asignación paciente_cama
CREATE INDEX indice_paciente_cama_numero_cama
ON paciente_cama (numero_cama);

-- 5) Índice por medicamento en la tabla medicamento_tratamiento
CREATE INDEX indice_medicamento_tratamiento_sku_medicamento
ON medicamento_tratamiento (sku_medicamento);




-- 5.2 Campos nuevos


-- 1) Correo electrónico del paciente
ALTER TABLE paciente
ADD COLUMN correo_paciente VARCHAR(80);

-- 2) Correo electrónico del médico
ALTER TABLE medico
ADD COLUMN correo_medico VARCHAR(80);

-- 3) Dirección del hospital
ALTER TABLE hospital
ADD COLUMN direccion_hospital VARCHAR(100);

-- 4) Estado de la cama (Disponible, Ocupada, Limpieza)
ALTER TABLE cama
ADD COLUMN estado_cama VARCHAR(20);

-- 5) Observaciones generales del tratamiento
ALTER TABLE tratamiento
ADD COLUMN observaciones_tratamiento VARCHAR(200);



-- 5.3 CHECK


-- 1) Sexo del paciente solo puede ser M, F
ALTER TABLE paciente
ADD CONSTRAINT restriccion_paciente_sexo_valido
CHECK (sexo IN ('M','F'));

-- 2) Nombre del medicamento no puede ser vacío
ALTER TABLE medicamento
ADD CONSTRAINT restriccion_medicamento_nombre_valido
CHECK (nombre_medicamento IS NOT NULL AND nombre_medicamento <> '');

-- 3) Estado de la cama debe ser uno de los permitidos
ALTER TABLE cama
ADD CONSTRAINT restriccion_cama_estado_valido
CHECK (estado_cama IN ('Disponible','Ocupada','Limpieza'));

-- 4) La cantidad de medicamento en un tratamiento debe ser mayor a cero
ALTER TABLE medicamento_tratamiento
ADD CONSTRAINT restriccion_medicamento_tratamiento_cantidad_mayor_0
CHECK (cantidad_medicamento > 0);

-- 5) La fecha de liberación de la cama no puede ser anterior a la asignación
ALTER TABLE paciente_cama
ADD CONSTRAINT restriccion_paciente_cama_fechas_validas
CHECK (
    fecha_liberacion IS NULL
    OR fecha_liberacion >= fecha_asignacion
);



--5.4 Modificar nombres.


-- 1) Tabla paciente: renombrar contacto principal
ALTER TABLE paciente
RENAME COLUMN contacto1_paciente TO telefono_principal_paciente;

-- 2) Tabla medico: renombrar teléfono de contacto
ALTER TABLE medico
RENAME COLUMN contacto_medico TO telefono_contacto_medico;

-- 3) Tabla planta: renombrar cantidad_cuarto a un nombre más claro
ALTER TABLE planta
RENAME COLUMN cantidad_cuarto TO cantidad_cuartos_planta;

-- 4) Tabla cama: renombrar estado_cama a un nombre más descriptivo
ALTER TABLE cama
RENAME COLUMN estado_cama TO estado_actual_cama;

-- 5) Tabla medicamento_tratamiento: renombrar cantidad_medicamento
ALTER TABLE medicamento_tratamiento
RENAME COLUMN cantidad_medicamento TO cantidad_unidades_medicamento;

