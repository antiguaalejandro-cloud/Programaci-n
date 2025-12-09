
CREATE DATABASE IF NOT EXISTS gestion_academica;
USE gestion_academica;

CREATE TABLE Departamento (
    id_departamento INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    codigo VARCHAR(10) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100),
    fecha_creacion DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE Profesor (
    id_profesor INT AUTO_INCREMENT PRIMARY KEY,
    dni VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100),
    id_departamento INT,
    fecha_contratacion DATE DEFAULT (CURRENT_DATE),
    salario DECIMAL(10,2) CHECK (salario > 0),
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento) ON DELETE SET NULL
);

CREATE TABLE Estudiante (
    id_estudiante INT AUTO_INCREMENT PRIMARY KEY,
    matricula VARCHAR(20) UNIQUE NOT NULL,
    dni VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    direccion VARCHAR(200),
    telefono VARCHAR(20),
    email VARCHAR(100),
    fecha_ingreso DATE DEFAULT (CURRENT_DATE),
    carrera VARCHAR(100),
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE Curso (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    creditos INT NOT NULL CHECK (creditos > 0),
    id_departamento INT,
    nivel ENUM('Básico', 'Intermedio', 'Avanzado') DEFAULT 'Básico',
    horas_semana INT DEFAULT 3,
    FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento) ON DELETE CASCADE
);

CREATE TABLE Clase (
    id_clase INT AUTO_INCREMENT PRIMARY KEY,
    id_curso INT NOT NULL,
    id_profesor INT,
    codigo_seccion VARCHAR(10) NOT NULL,
    semestre VARCHAR(20) NOT NULL,
    año INT NOT NULL,
    horario VARCHAR(100),
    aula VARCHAR(20),
    cupo_maximo INT DEFAULT 30,
    cupo_actual INT DEFAULT 0,
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso) ON DELETE CASCADE,
    FOREIGN KEY (id_profesor) REFERENCES Profesor(id_profesor) ON DELETE SET NULL,
    UNIQUE KEY clase_unica (id_curso, codigo_seccion, semestre, año)
);

CREATE TABLE Inscripcion (
    id_inscripcion INT AUTO_INCREMENT PRIMARY KEY,
    id_estudiante INT NOT NULL,
    id_clase INT NOT NULL,
    fecha_inscripcion DATE DEFAULT (CURRENT_DATE),
    estado ENUM('Activa', 'Retirada', 'Aprobada', 'Reprobada') DEFAULT 'Activa',
    FOREIGN KEY (id_estudiante) REFERENCES Estudiante(id_estudiante) ON DELETE CASCADE,
    FOREIGN KEY (id_clase) REFERENCES Clase(id_clase) ON DELETE CASCADE,
    UNIQUE KEY inscripcion_unica (id_estudiante, id_clase)
);

CREATE TABLE Calificacion (
    id_calificacion INT AUTO_INCREMENT PRIMARY KEY,
    id_inscripcion INT UNIQUE NOT NULL,
    parcial1 DECIMAL(4,2) CHECK (parcial1 BETWEEN 0 AND 20),
    parcial2 DECIMAL(4,2) CHECK (parcial2 BETWEEN 0 AND 20),
    final DECIMAL(4,2) CHECK (final BETWEEN 0 AND 20),
    promedio DECIMAL(4,2) GENERATED ALWAYS AS (
        COALESCE((parcial1 * 0.3 + parcial2 * 0.3 + final * 0.4), 0)
    ) STORED,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_inscripcion) REFERENCES Inscripcion(id_inscripcion) ON DELETE CASCADE
);


CREATE INDEX idx_profesor_departamento ON Profesor(id_departamento);
CREATE INDEX idx_curso_departamento ON Curso(id_departamento);
CREATE INDEX idx_clase_curso ON Clase(id_curso);
CREATE INDEX idx_clase_profesor ON Clase(id_profesor);
CREATE INDEX idx_inscripcion_estudiante ON Inscripcion(id_estudiante);
CREATE INDEX idx_inscripcion_clase ON Inscripcion(id_clase);
CREATE INDEX idx_estudiante_activo ON Estudiante(activo);
CREATE INDEX idx_profesor_activo ON Profesor(activo);

-- Insertar Departamentos
INSERT INTO Departamento (nombre, codigo, telefono, email) VALUES
('Ciencias de la Computación', 'CC', '555-1001', 'cc@universidad.edu'),
('Matemáticas', 'MAT', '555-1002', 'mat@universidad.edu'),
('Ingeniería Civil', 'IC', '555-1003', 'ic@universidad.edu'),
('Administración', 'ADM', '555-1004', 'adm@universidad.edu'),
('Derecho', 'DER', '555-1005', 'der@universidad.edu');

-- Insertar Profesores
INSERT INTO Profesor (dni, nombre, apellido, especialidad, id_departamento, salario) VALUES
('11111111A', 'Carlos', 'García', 'Base de Datos', 1, 3500.00),
('22222222B', 'María', 'López', 'Algoritmos', 1, 3200.00),
('33333333C', 'Juan', 'Martínez', 'Cálculo', 2, 3000.00),
('44444444D', 'Ana', 'Rodríguez', 'Álgebra Lineal', 2, 3100.00),
('55555555E', 'Pedro', 'Sánchez', 'Estructuras', 3, 3400.00),
('66666666F', 'Laura', 'Fernández', 'Contabilidad', 4, 2900.00),
('77777777G', 'Diego', 'Torres', 'Derecho Civil', 5, 3300.00);

-- Insertar Estudiantes
INSERT INTO Estudiante (matricula, dni, nombre, apellido, fecha_nacimiento, direccion, telefono, email, carrera) VALUES
('2024001', '88888888H', 'Luis', 'Pérez', '2000-05-15', 'Calle 123', '555-2001', 'luis@email.com', 'Ing. Sistemas'),
('2024002', '99999999I', 'Sofía', 'Gómez', '2001-03-20', 'Av. Principal', '555-2002', 'sofia@email.com', 'Matemáticas'),
('2024003', '10101010J', 'Miguel', 'Ramírez', '1999-11-10', 'Plaza Central', '555-2003', 'miguel@email.com', 'Ing. Civil'),
('2024004', '12121212K', 'Valeria', 'Castro', '2000-08-25', 'Calle Luna', '555-2004', 'valeria@email.com', 'Administración'),
('2024005', '13131313L', 'Andrés', 'Mendoza', '2001-02-14', 'Av. Norte', '555-2005', 'andres@email.com', 'Derecho'),
('2024006', '14141414M', 'Camila', 'Rojas', '2000-07-30', 'Calle Sol', '555-2006', 'camila@email.com', 'Ing. Sistemas'),
('2024007', '15151515N', 'Javier', 'Vargas', '1999-12-05', 'Paseo del Río', '555-2007', 'javier@email.com', 'Matemáticas'),
('2024008', '16161616O', 'Daniela', 'Silva', '2001-04-18', 'Av. Sur', '555-2008', 'daniela@email.com', 'Ing. Civil');

-- Insertar Cursos
INSERT INTO Curso (codigo, nombre, descripcion, creditos, id_departamento, nivel, horas_semana) VALUES
('CC101', 'Introducción a la Programación', 'Fundamentos de programación', 4, 1, 'Básico', 4),
('CC201', 'Base de Datos I', 'Diseño e implementación de bases de datos', 5, 1, 'Intermedio', 5),
('MAT101', 'Cálculo I', 'Cálculo diferencial e integral', 4, 2, 'Básico', 4),
('MAT201', 'Álgebra Lineal', 'Vectores y matrices', 4, 2, 'Intermedio', 4),
('IC101', 'Estática', 'Equilibrio de cuerpos rígidos', 3, 3, 'Básico', 3),
('ADM101', 'Contabilidad Básica', 'Principios contables', 3, 4, 'Básico', 3),
('DER101', 'Derecho Civil I', 'Introducción al derecho civil', 4, 5, 'Básico', 4),
('CC301', 'Desarrollo Web', 'Desarrollo de aplicaciones web', 5, 1, 'Avanzado', 5);

-- Insertar Clases
INSERT INTO Clase (id_curso, id_profesor, codigo_seccion, semestre, año, horario, aula, cupo_maximo) VALUES
(1, 1, 'A', '2024-1', 2024, 'Lunes 8:00-10:00', 'A-101', 25),
(1, 1, 'B', '2024-1', 2024, 'Martes 10:00-12:00', 'A-102', 25),
(2, 2, 'A', '2024-1', 2024, 'Miércoles 8:00-11:00', 'B-201', 20),
(3, 3, 'A', '2024-1', 2024, 'Jueves 14:00-16:00', 'C-301', 30),
(4, 4, 'A', '2024-1', 2024, 'Viernes 8:00-10:00', 'D-401', 25),
(5, 5, 'A', '2024-1', 2024, 'Lunes 16:00-19:00', 'E-101', 20),
(6, 6, 'A', '2024-1', 2024, 'Martes 14:00-17:00', 'F-201', 30),
(7, 7, 'A', '2024-1', 2024, 'Miércoles 10:00-12:00', 'G-301', 25),
(8, 1, 'A', '2024-1', 2024, 'Jueves 8:00-11:00', 'H-401', 15);

-- Insertar Inscripciones
INSERT INTO Inscripcion (id_estudiante, id_clase, estado) VALUES
(1, 1, 'Activa'),
(1, 3, 'Activa'),
(2, 4, 'Activa'),
(2, 5, 'Activa'),
(3, 6, 'Activa'),
(4, 7, 'Activa'),
(5, 8, 'Activa'),
(6, 1, 'Activa'),
(6, 2, 'Activa'),
(7, 4, 'Activa'),
(8, 6, 'Activa'),
(1, 9, 'Activa'),
(6, 9, 'Activa');

-- Insertar Calificaciones
INSERT INTO Calificacion (id_inscripcion, parcial1, parcial2, final) VALUES
(1, 18.5, 17.0, 19.0),
(2, 16.0, 15.5, 17.0),
(3, 19.0, 18.5, 20.0),
(4, 14.0, 15.0, 16.0),
(5, 17.5, 16.0, 18.0),
(6, 13.0, 14.5, 15.0),
(7, 12.0, 11.5, 13.0),
(8, 15.0, 16.5, 17.0),
(9, 18.0, 17.5, 19.0);


-- 1. Seleccionar todos los estudiantes
SELECT * FROM Estudiante;

-- 2. Seleccionar profesores activos
SELECT * FROM Profesor WHERE activo = TRUE;

-- 3. Seleccionar cursos con más de 4 créditos
SELECT * FROM Curso WHERE creditos > 4;

-- 4. Contar estudiantes por carrera
SELECT carrera, COUNT(*) AS cantidad
FROM Estudiante
GROUP BY carrera
ORDER BY cantidad DESC;

-- 5. Mostrar departamentos con su cantidad de profesores
SELECT d.nombre, COUNT(p.id_profesor) AS num_profesores
FROM Departamento d
LEFT JOIN Profesor p ON d.id_departamento = p.id_departamento
GROUP BY d.id_departamento;

SELECT 
    e.nombre,
    e.apellido,
    c.nombre AS curso,
    cl.codigo_seccion,
    cl.semestre
FROM Estudiante e
INNER JOIN Inscripcion i ON e.id_estudiante = i.id_estudiante
INNER JOIN Clase cl ON i.id_clase = cl.id_clase
INNER JOIN Curso c ON cl.id_curso = c.id_curso
WHERE e.activo = TRUE
ORDER BY e.apellido;

SELECT 
    d.nombre AS departamento,
    c.codigo AS codigo_curso,
    c.nombre AS nombre_curso,
    c.creditos
FROM Departamento d
LEFT JOIN Curso c ON d.id_departamento = c.id_departamento
ORDER BY d.nombre, c.nombre;

SELECT 
    p.nombre AS profesor_nombre,
    p.apellido AS profesor_apellido,
    c.nombre AS curso,
    cl.codigo_seccion,
    cl.horario
FROM Profesor p
RIGHT JOIN Clase cl ON p.id_profesor = cl.id_profesor
INNER JOIN Curso c ON cl.id_curso = c.id_curso
ORDER BY p.apellido;

SELECT 
    e.matricula,
    CONCAT(e.nombre, ' ', e.apellido) AS estudiante,
    c.codigo AS codigo_curso,
    c.nombre AS curso,
    CONCAT(p.nombre, ' ', p.apellido) AS profesor,
    cl.codigo_seccion,
    cl.semestre,
    cl.año,
    i.fecha_inscripcion,
    cal.promedio AS calificacion_promedio
FROM Estudiante e
INNER JOIN Inscripcion i ON e.id_estudiante = i.id_estudiante
INNER JOIN Clase cl ON i.id_clase = cl.id_clase
INNER JOIN Curso c ON cl.id_curso = c.id_curso
LEFT JOIN Profesor p ON cl.id_profesor = p.id_profesor
LEFT JOIN Calificacion cal ON i.id_inscripcion = cal.id_inscripcion
ORDER BY e.apellido, c.nombre;


SELECT 
    c.nombre AS curso,
    COUNT(cal.id_calificacion) AS num_calificaciones,
    ROUND(AVG(cal.promedio), 2) AS promedio_curso,
    MIN(cal.promedio) AS minima,
    MAX(cal.promedio) AS maxima
FROM Curso c
INNER JOIN Clase cl ON c.id_curso = c.id_curso
INNER JOIN Inscripcion i ON cl.id_clase = i.id_clase
INNER JOIN Calificacion cal ON i.id_inscripcion = cal.id_inscripcion
GROUP BY c.id_curso
ORDER BY promedio_curso DESC;

SELECT 
    c.nombre AS curso,
    cl.codigo_seccion,
    cl.semestre,
    cl.año,
    COUNT(i.id_estudiante) AS estudiantes_inscritos,
    cl.cupo_maximo,
    CONCAT(ROUND((COUNT(i.id_estudiante) / cl.cupo_maximo * 100), 1), '%') AS porcentaje_ocupacion
FROM Curso c
INNER JOIN Clase cl ON c.id_curso = cl.id_curso
LEFT JOIN Inscripcion i ON cl.id_clase = i.id_clase AND i.estado = 'Activa'
GROUP BY cl.id_clase
ORDER BY c.nombre, cl.codigo_seccion;

SELECT 
    CONCAT(p.nombre, ' ', p.apellido) AS profesor,
    d.nombre AS departamento,
    COUNT(cl.id_clase) AS clases_asignadas,
    SUM(c.creditos) AS creditos_totales
FROM Profesor p
INNER JOIN Departamento d ON p.id_departamento = d.id_departamento
LEFT JOIN Clase cl ON p.id_profesor = cl.id_profesor
LEFT JOIN Curso c ON cl.id_curso = c.id_curso
GROUP BY p.id_profesor
ORDER BY clases_asignadas DESC;

SELECT 
    e.matricula,
    CONCAT(e.nombre, ' ', e.apellido) AS estudiante,
    e.carrera,
    COUNT(i.id_inscripcion) AS cursos_inscritos,
    ROUND(AVG(cal.promedio), 2) AS promedio_general
FROM Estudiante e
LEFT JOIN Inscripcion i ON e.id_estudiante = i.id_estudiante
LEFT JOIN Calificacion cal ON i.id_inscripcion = cal.id_inscripcion
WHERE cal.promedio IS NOT NULL
GROUP BY e.id_estudiante
HAVING COUNT(i.id_inscripcion) >= 2
ORDER BY promedio_general DESC
LIMIT 5;

SELECT 
    d.nombre AS departamento,
    COUNT(DISTINCT p.id_profesor) AS num_profesores,
    COUNT(DISTINCT c.id_curso) AS num_cursos,
    COUNT(DISTINCT cl.id_clase) AS num_clases,
    COUNT(DISTINCT i.id_estudiante) AS estudiantes_inscritos,
    ROUND(AVG(cal.promedio), 2) AS promedio_departamento
FROM Departamento d
LEFT JOIN Profesor p ON d.id_departamento = p.id_departamento
LEFT JOIN Curso c ON d.id_departamento = c.id_departamento
LEFT JOIN Clase cl ON c.id_curso = cl.id_curso
LEFT JOIN Inscripcion i ON cl.id_clase = i.id_clase
LEFT JOIN Calificacion cal ON i.id_inscripcion = cal.id_inscripcion
GROUP BY d.id_departamento
ORDER BY num_cursos DESC;


SELECT 
    e.matricula,
    CONCAT(e.nombre, ' ', e.apellido) AS estudiante,
    COUNT(i.id_inscripcion) AS cursos_inscritos
FROM Estudiante e
INNER JOIN Inscripcion i ON e.id_estudiante = i.id_estudiante
GROUP BY e.id_estudiante
HAVING cursos_inscritos > (
    SELECT AVG(num_cursos)
    FROM (
        SELECT COUNT(*) AS num_cursos
        FROM Inscripcion
        GROUP BY id_estudiante
    ) AS promedio_cursos
)
ORDER BY cursos_inscritos DESC;

SELECT 
    c.nombre AS curso,
    ROUND(AVG(cal.promedio), 2) AS promedio_curso
FROM Curso c
INNER JOIN Clase cl ON c.id_curso = cl.id_curso
INNER JOIN Inscripcion i ON cl.id_clase = i.id_clase
INNER JOIN Calificacion cal ON i.id_inscripcion = cal.id_inscripcion
GROUP BY c.id_curso
HAVING promedio_curso > (
    SELECT AVG(promedio) FROM Calificacion
)
ORDER BY promedio_curso DESC;

SELECT 
    p.nombre,
    p.apellido,
    d.nombre AS departamento,
    p.salario,
    (SELECT AVG(salario) FROM Profesor WHERE id_departamento = p.id_departamento) AS promedio_departamento
FROM Profesor p
INNER JOIN Departamento d ON p.id_departamento = d.id_departamento
WHERE p.salario > (
    SELECT AVG(salario) 
    FROM Profesor 
    WHERE id_departamento = p.id_departamento
)
ORDER BY p.salario DESC;


INSERT INTO Estudiante (matricula, dni, nombre, apellido, fecha_nacimiento, direccion, telefono, email, carrera)
VALUES ('2024009', '17171717P', 'Fernando', 'Morales', '2000-09-12', 'Calle Nueva 456', '555-2009', 'fernando@email.com', 'Ing. Sistemas');

-- 9.2 INSERT - Agregar nuevo curso
INSERT INTO Curso (codigo, nombre, descripcion, creditos, id_departamento, nivel, horas_semana)
VALUES ('CC401', 'Inteligencia Artificial', 'Fundamentos de IA y machine learning', 5, 1, 'Avanzado', 5);

-- 9.3 UPDATE - Actualizar información de estudiante
UPDATE Estudiante 
SET direccion = 'Nueva Dirección 789', telefono = '555-9999'
WHERE matricula = '2024001';

-- 9.4 UPDATE - Aumentar salario a profesores
UPDATE Profesor 
SET salario = salario * 1.10  -- Aumento del 10%
WHERE id_departamento = 1;  -- Solo profesores de Ciencias de la Computación

-- 9.5 UPDATE - Cambiar estado de inscripción
UPDATE Inscripcion 
SET estado = 'Aprobada'
WHERE id_inscripcion IN (
    SELECT id_inscripcion 
    FROM Calificacion 
    WHERE promedio >= 11
);

-- 9.6 UPDATE - Actualizar cupo actual en clases
UPDATE Clase cl
SET cupo_actual = (
    SELECT COUNT(*) 
    FROM Inscripcion i 
    WHERE i.id_clase = cl.id_clase AND i.estado = 'Activa'
);

-- 9.7 DELETE - Eliminar estudiante inactivo (ejemplo)
-- Primero verificar que no tenga inscripciones activas
DELETE FROM Estudiante 
WHERE activo = FALSE 
AND id_estudiante NOT IN (
    SELECT DISTINCT id_estudiante 
    FROM Inscripcion 
    WHERE estado = 'Activa'
);

-- 9.8 DELETE - Eliminar curso sin clases
DELETE FROM Curso 
WHERE id_curso NOT IN (
    SELECT DISTINCT id_curso 
    FROM Clase
);

-- 10.1 Transacción para inscribir un estudiante
START TRANSACTION;

-- Verificar cupo disponible
SELECT cupo_actual, cupo_maximo 
INTO @cupo_actual, @cupo_maximo
FROM Clase 
WHERE id_clase = 1;

IF @cupo_actual < @cupo_maximo THEN
    -- Inscribir estudiante
    INSERT INTO Inscripcion (id_estudiante, id_clase, estado)
    VALUES (1, 1, 'Activa');
    
    -- Actualizar cupo actual
    UPDATE Clase 
    SET cupo_actual = cupo_actual + 1 
    WHERE id_clase = 1;
    
    COMMIT;
    SELECT 'Inscripción exitosa' AS mensaje;
ELSE
    ROLLBACK;
    SELECT 'No hay cupos disponibles' AS mensaje;
END IF;

-- 10.2 Transacción para registrar calificaciones
START TRANSACTION;

-- Registrar calificaciones
INSERT INTO Calificacion (id_inscripcion, parcial1, parcial2, final)
VALUES (10, 16.5, 17.0, 18.0);

-- Actualizar estado de inscripción según calificación
UPDATE Inscripcion i
JOIN Calificacion c ON i.id_inscripcion = c.id_inscripcion
SET i.estado = CASE 
    WHEN c.promedio >= 11 THEN 'Aprobada'
    ELSE 'Reprobada'
END
WHERE i.id_inscripcion = 10;

COMMIT;


CREATE VIEW Vista_Estudiantes_Activos AS
SELECT 
    e.matricula,
    CONCAT(e.nombre, ' ', e.apellido) AS nombre_completo,
    e.carrera,
    e.email,
    e.telefono,
    COUNT(i.id_inscripcion) AS cursos_activos,
    ROUND(AVG(cal.promedio), 2) AS promedio_general
FROM Estudiante e
LEFT JOIN Inscripcion i ON e.id_estudiante = i.id_estudiante AND i.estado = 'Activa'
LEFT JOIN Calificacion cal ON i.id_inscripcion = cal.id_inscripcion
WHERE e.activo = TRUE
GROUP BY e.id_estudiante;

-- Vista: Horario de clases
CREATE VIEW Vista_Horario_Clases AS
SELECT 
    c.codigo AS codigo_curso,
    c.nombre AS curso,
    cl.codigo_seccion,
    CONCAT(p.nombre, ' ', p.apellido) AS profesor,
    cl.horario,
    cl.aula,
    cl.semestre,
    cl.año,
    cl.cupo_actual,
    cl.cupo_maximo
FROM Clase cl
INNER JOIN Curso c ON cl.id_curso = c.id_curso
LEFT JOIN Profesor p ON cl.id_profesor = p.id_profesor
ORDER BY cl.horario;

-- Vista: Calificaciones detalladas
CREATE VIEW Vista_Calificaciones_Detalladas AS
SELECT 
    e.matricula,
    CONCAT(e.nombre, ' ', e.apellido) AS estudiante,
    c.codigo AS codigo_curso,
    c.nombre AS curso,
    cal.parcial1,
    cal.parcial2,
    cal.final,
    cal.promedio,
    CASE 
        WHEN cal.promedio >= 11 THEN 'Aprobado'
        ELSE 'Reprobado'
    END AS resultado,
    i.estado
FROM Estudiante e
INNER JOIN Inscripcion i ON e.id_estudiante = i.id_estudiante
INNER JOIN Calificacion cal ON i.id_inscripcion = cal.id_inscripcion
INNER JOIN Clase cl ON i.id_clase = cl.id_clase
INNER JOIN Curso c ON cl.id_curso = c.id_curso;


-- Usar vista de estudiantes activos
SELECT * FROM Vista_Estudiantes_Activos 
ORDER BY promedio_general DESC;

-- Usar vista de horario
SELECT * FROM Vista_Horario_Clases 
WHERE semestre = '2024-1'
ORDER BY horario;

-- Usar vista de calificaciones
SELECT * FROM Vista_Calificaciones_Detalladas 
WHERE resultado = 'Aprobado'
ORDER BY promedio DESC;


-- Procedimiento para inscribir estudiante
DELIMITER //
CREATE PROCEDURE InscribirEstudiante(
    IN p_matricula VARCHAR(20),
    IN p_id_clase INT,
    OUT p_mensaje VARCHAR(100)
)
BEGIN
    DECLARE v_id_estudiante INT;
    DECLARE v_cupo_actual INT;
    DECLARE v_cupo_maximo INT;
    
    -- Obtener ID del estudiante
    SELECT id_estudiante INTO v_id_estudiante
    FROM Estudiante
    WHERE matricula = p_matricula;
    
    -- Obtener información de cupos
    SELECT cupo_actual, cupo_maximo INTO v_cupo_actual, v_cupo_maximo
    FROM Clase
    WHERE id_clase = p_id_clase;
    
    -- Verificar cupos
    IF v_cupo_actual < v_cupo_maximo THEN
        -- Realizar inscripción
        INSERT INTO Inscripcion (id_estudiante, id_clase, estado)
        VALUES (v_id_estudiante, p_id_clase, 'Activa');
        
        -- Actualizar cupo
        UPDATE Clase 
        SET cupo_actual = cupo_actual + 1 
        WHERE id_clase = p_id_clase;
        
        SET p_mensaje = 'Inscripción exitosa';
    ELSE
        SET p_mensaje = 'No hay cupos disponibles';
    END IF;
END //
DELIMITER ;

-- Procedimiento para obtener reporte de profesor
DELIMITER //
CREATE PROCEDURE ReporteProfesor(
    IN p_id_profesor INT
)
BEGIN
    SELECT 
        CONCAT(p.nombre, ' ', p.apellido) AS profesor,
        d.nombre AS departamento,
        COUNT(cl.id_clase) AS clases_asignadas,
        GROUP_CONCAT(c.nombre SEPARATOR ', ') AS cursos,
        SUM(c.creditos) AS creditos_totales,
        COUNT(DISTINCT i.id_estudiante) AS estudiantes
    FROM Profesor p
    INNER JOIN Departamento d ON p.id_departamento = d.id_departamento
    LEFT JOIN Clase cl ON p.id_profesor = cl.id_profesor
    LEFT JOIN Curso c ON cl.id_curso = c.id_curso
    LEFT JOIN Inscripcion i ON cl.id_clase = i.id_clase
    WHERE p.id_profesor = p_id_profesor
    GROUP BY p.id_profesor;
END //
DELIMITER ;



-- Llamar procedimiento de inscripción
CALL InscribirEstudiante('2024001', 1, @mensaje);
SELECT @mensaje;

-- Llamar procedimiento de reporte
CALL ReporteProfesor(1);


-- Mostrar todas las tablas
SHOW TABLES;

-- Mostrar estructura de tablas principales
DESCRIBE Departamento;
DESCRIBE Profesor;
DESCRIBE Estudiante;
DESCRIBE Curso;
DESCRIBE Clase;
DESCRIBE Inscripcion;
DESCRIBE Calificacion;

-- Mostrar vistas creadas
SHOW FULL TABLES WHERE Table_type = 'VIEW';

-- Estadísticas generales
SELECT 
    (SELECT COUNT(*) FROM Departamento) AS departamentos,
    (SELECT COUNT(*) FROM Profesor WHERE activo = TRUE) AS profesores_activos,
    (SELECT COUNT(*) FROM Estudiante WHERE activo = TRUE) AS estudiantes_activos,
    (SELECT COUNT(*) FROM Curso) AS cursos,
    (SELECT COUNT(*) FROM Clase) AS clases,
    (SELECT COUNT(*) FROM Inscripcion WHERE estado = 'Activa') AS inscripciones_activas,
    (SELECT ROUND(AVG(promedio), 2) FROM Calificacion) AS promedio_general;