-- 1. Crear la base de datos
CREATE DATABASE IF NOT EXISTS colegio;
USE colegio;

-- 2. Crear tabla estudiantes
CREATE TABLE estudiantes (
    id_estudiante INT AUTO_INCREMENT PRIMARY KEY,
    dni VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    direccion VARCHAR(200),
    telefono VARCHAR(20),
    email VARCHAR(100),
    fecha_ingreso DATE DEFAULT (CURRENT_DATE)
);

-- 3. Crear tabla profesores
CREATE TABLE profesores (
    id_profesor INT AUTO_INCREMENT PRIMARY KEY,
    dni VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100),
    telefono VARCHAR(20),
    email VARCHAR(100),
    fecha_contratacion DATE DEFAULT (CURRENT_DATE)
);

-- 4. Crear tabla cursos
CREATE TABLE cursos (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    id_profesor INT,
    grado ENUM('1°', '2°', '3°', '4°', '5°') NOT NULL,
    horario VARCHAR(50),
    cupo_maximo INT DEFAULT 30,
    FOREIGN KEY (id_profesor) REFERENCES profesores(id_profesor) ON DELETE SET NULL
);

-- 5. Crear tabla matriculas
CREATE TABLE matriculas (
    id_matricula INT AUTO_INCREMENT PRIMARY KEY,
    id_estudiante INT NOT NULL,
    id_curso INT NOT NULL,
    fecha_matricula DATE DEFAULT (CURRENT_DATE),
    año_escolar YEAR DEFAULT (YEAR(CURRENT_DATE)),
    calificacion_final DECIMAL(4,2) CHECK (calificacion_final BETWEEN 0 AND 20),
    estado ENUM('activo', 'retirado', 'aprobado', 'reprobado') DEFAULT 'activo',
    FOREIGN KEY (id_estudiante) REFERENCES estudiantes(id_estudiante) ON DELETE CASCADE,
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso) ON DELETE CASCADE,
    UNIQUE KEY matricula_unica (id_estudiante, id_curso, año_escolar)
);

-- 6. Crear tabla calificaciones (para evaluaciones parciales)
CREATE TABLE calificaciones (
    id_calificacion INT AUTO_INCREMENT PRIMARY KEY,
    id_matricula INT NOT NULL,
    tipo_evaluacion ENUM('parcial', 'tarea', 'proyecto', 'examen final') NOT NULL,
    nota DECIMAL(4,2) CHECK (nota BETWEEN 0 AND 20),
    fecha_evaluacion DATE DEFAULT (CURRENT_DATE),
    observaciones TEXT,
    FOREIGN KEY (id_matricula) REFERENCES matriculas(id_matricula) ON DELETE CASCADE
);

-- ============================================
-- INSERTAR DATOS DE EJEMPLO
-- ============================================

-- Insertar profesores
INSERT INTO profesores (dni, nombre, apellido, especialidad, telefono, email) VALUES
('12345678A', 'Ana', 'García', 'Matemáticas', '555-1001', 'ana.garcia@colegio.edu'),
('23456789B', 'Carlos', 'Martínez', 'Literatura', '555-1002', 'carlos.martinez@colegio.edu'),
('34567890C', 'María', 'López', 'Ciencias', '555-1003', 'maria.lopez@colegio.edu'),
('45678901D', 'Pedro', 'Rodríguez', 'Historia', '555-1004', 'pedro.rodriguez@colegio.edu'),
('56789012E', 'Laura', 'Sánchez', 'Inglés', '555-1005', 'laura.sanchez@colegio.edu');

-- Insertar cursos
INSERT INTO cursos (codigo, nombre, descripcion, id_profesor, grado, horario, cupo_maximo) VALUES
('MAT-101', 'Matemáticas Básicas', 'Fundamentos de aritmética y álgebra', 1, '1°', 'Lunes 8:00-10:00', 30),
('LIT-201', 'Literatura Española', 'Estudio de literatura clásica española', 2, '2°', 'Martes 10:00-12:00', 25),
('CIE-301', 'Ciencias Naturales', 'Biología, física y química básica', 3, '3°', 'Miércoles 8:00-10:00', 28),
('HIS-401', 'Historia Universal', 'Historia mundial desde la antigüedad', 4, '4°', 'Jueves 10:00-12:00', 30),
('ING-501', 'Inglés Avanzado', 'Inglés conversacional y gramática', 5, '5°', 'Viernes 8:00-10:00', 20),
('MAT-202', 'Álgebra', 'Álgebra intermedia', 1, '2°', 'Lunes 10:00-12:00', 25),
('CIE-102', 'Biología', 'Introducción a la biología', 3, '1°', 'Martes 8:00-10:00', 30);

-- Insertar estudiantes
INSERT INTO estudiantes (dni, nombre, apellido, fecha_nacimiento, direccion, telefono, email) VALUES
('11111111A', 'Juan', 'Pérez', '2010-05-15', 'Calle Primavera 123', '555-2001', 'juan.perez@email.com'),
('22222222B', 'María', 'Gómez', '2010-08-20', 'Av. Libertad 456', '555-2002', 'maria.gomez@email.com'),
('33333333C', 'Carlos', 'López', '2009-03-10', 'Plaza Central 789', '555-2003', 'carlos.lopez@email.com'),
('44444444D', 'Ana', 'Martínez', '2009-11-05', 'Calle Luna 321', '555-2004', 'ana.martinez@email.com'),
('55555555E', 'Luis', 'Fernández', '2008-07-22', 'Gran Vía 654', '555-2005', 'luis.fernandez@email.com'),
('66666666F', 'Sofía', 'Ramírez', '2008-12-30', 'Paseo del Prado 987', '555-2006', 'sofia.ramirez@email.com'),
('77777777G', 'Diego', 'Torres', '2007-04-18', 'Calle Sol 147', '555-2007', 'diego.torres@email.com'),
('88888888H', 'Valeria', 'Castro', '2007-09-25', 'Av. Norte 258', '555-2008', 'valeria.castro@email.com'),
('99999999I', 'Andrés', 'Rojas', '2006-01-12', 'Calle Sur 369', '555-2009', 'andres.rojas@email.com'),
('10101010J', 'Camila', 'Mendoza', '2006-06-08', 'Plaza Mayor 741', '555-2010', 'camila.mendoza@email.com');

-- Insertar matrículas
INSERT INTO matriculas (id_estudiante, id_curso, año_escolar, calificacion_final, estado) VALUES
(1, 1, 2024, 18.5, 'aprobado'),
(1, 7, 2024, 16.0, 'aprobado'),
(2, 1, 2024, 17.0, 'aprobado'),
(2, 7, 2024, 15.5, 'aprobado'),
(3, 2, 2024, 19.0, 'aprobado'),
(3, 6, 2024, 14.0, 'reprobado'),
(4, 2, 2024, 16.5, 'aprobado'),
(4, 6, 2024, 18.0, 'aprobado'),
(5, 3, 2024, 13.5, 'reprobado'),
(5, 4, 2024, 17.5, 'aprobado'),
(6, 3, 2024, 12.0, 'reprobado'),
(6, 4, 2024, 16.0, 'aprobado'),
(7, 5, 2024, 19.5, 'aprobado'),
(8, 5, 2024, 18.0, 'aprobado'),
(9, 5, 2024, 11.0, 'reprobado'),
(10, 5, 2024, 20.0, 'aprobado');

-- Insertar calificaciones parciales
INSERT INTO calificaciones (id_matricula, tipo_evaluacion, nota, fecha_evaluacion) VALUES
(1, 'parcial', 18.0, '2024-03-15'),
(1, 'parcial', 19.0, '2024-06-20'),
(1, 'examen final', 18.5, '2024-07-10'),
(2, 'tarea', 15.0, '2024-04-10'),
(2, 'proyecto', 17.0, '2024-05-15'),
(3, 'parcial', 16.5, '2024-03-15'),
(4, 'parcial', 15.0, '2024-03-15'),
(5, 'parcial', 19.5, '2024-03-20'),
(6, 'parcial', 14.0, '2024-03-20'),
(7, 'tarea', 17.0, '2024-04-05'),
(8, 'proyecto', 18.5, '2024-05-20');

-- ============================================
-- CONSULTAS BÁSICAS
-- ============================================

-- 1. Ver todos los estudiantes
SELECT * FROM estudiantes ORDER BY apellido, nombre;

-- 2. Ver todos los cursos
SELECT * FROM cursos ORDER BY grado, nombre;

-- 3. Ver todos los profesores
SELECT * FROM profesores ORDER BY apellido, nombre;

-- 4. Ver todas las matrículas
SELECT * FROM matriculas;

-- 5. Estudiantes con edad actual
SELECT 
    id_estudiante,
    CONCAT(nombre, ' ', apellido) AS estudiante,
    fecha_nacimiento,
    TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()) AS edad
FROM estudiantes
ORDER BY edad;

-- ============================================
-- CONSULTAS CON JOINS
-- ============================================

-- 6. Estudiantes matriculados en cada curso
SELECT 
    c.nombre AS curso,
    c.grado,
    CONCAT(e.nombre, ' ', e.apellido) AS estudiante,
    m.estado AS estado_matricula
FROM matriculas m
JOIN estudiantes e ON m.id_estudiante = e.id_estudiante
JOIN cursos c ON m.id_curso = c.id_curso
WHERE m.año_escolar = 2024
ORDER BY c.nombre, e.apellido;

-- 7. Cursos con su profesor asignado
SELECT 
    c.codigo,
    c.nombre AS curso,
    c.grado,
    c.horario,
    CONCAT(p.nombre, ' ', p.apellido) AS profesor,
    p.especialidad
FROM cursos c
LEFT JOIN profesores p ON c.id_profesor = p.id_profesor
ORDER BY c.grado, c.nombre;

-- 8. Estudiantes y sus calificaciones
SELECT 
    CONCAT(e.nombre, ' ', e.apellido) AS estudiante,
    c.nombre AS curso,
    cal.tipo_evaluacion,
    cal.nota,
    cal.fecha_evaluacion
FROM calificaciones cal
JOIN matriculas m ON cal.id_matricula = m.id_matricula
JOIN estudiantes e ON m.id_estudiante = e.id_estudiante
JOIN cursos c ON m.id_curso = c.id_curso
ORDER BY cal.fecha_evaluacion DESC;

-- 9. Promedio de calificaciones por estudiante
SELECT 
    CONCAT(e.nombre, ' ', e.apellido) AS estudiante,
    COUNT(cal.id_calificacion) AS evaluaciones,
    ROUND(AVG(cal.nota), 2) AS promedio_general
FROM estudiantes e
JOIN matriculas m ON e.id_estudiante = m.id_estudiante
LEFT JOIN calificaciones cal ON m.id_matricula = cal.id_matricula
GROUP BY e.id_estudiante
ORDER BY promedio_general DESC;

-- 10. Cursos más populares (con más estudiantes)
SELECT 
    c.nombre AS curso,
    c.grado,
    COUNT(m.id_estudiante) AS estudiantes_matriculados,
    c.cupo_maximo,
    CONCAT(ROUND((COUNT(m.id_estudiante) / c.cupo_maximo * 100), 1), '%') AS ocupacion
FROM cursos c
LEFT JOIN matriculas m ON c.id_curso = m.id_curso AND m.estado = 'activo'
GROUP BY c.id_curso
ORDER BY estudiantes_matriculados DESC;

-- ============================================
-- CONSULTAS DE ANÁLISIS
-- ============================================

-- 11. Estudiantes aprobados y reprobados por curso
SELECT 
    c.nombre AS curso,
    SUM(CASE WHEN m.calificacion_final >= 11 THEN 1 ELSE 0 END) AS aprobados,
    SUM(CASE WHEN m.calificacion_final < 11 THEN 1 ELSE 0 END) AS reprobados,
    COUNT(*) AS total_estudiantes,
    ROUND(AVG(m.calificacion_final), 2) AS promedio_curso
FROM matriculas m
JOIN cursos c ON m.id_curso = c.id_curso
WHERE m.estado IN ('aprobado', 'reprobado')
GROUP BY c.id_curso
ORDER BY promedio_curso DESC;

-- 12. Mejores estudiantes (promedio mayor a 16)
SELECT 
    CONCAT(e.nombre, ' ', e.apellido) AS estudiante,
    COUNT(DISTINCT m.id_curso) AS cursos_matriculados,
    ROUND(AVG(m.calificacion_final), 2) AS promedio_final
FROM estudiantes e
JOIN matriculas m ON e.id_estudiante = m.id_estudiante
WHERE m.calificacion_final IS NOT NULL
GROUP BY e.id_estudiante
HAVING AVG(m.calificacion_final) >= 16
ORDER BY promedio_final DESC;

-- 13. Estudiantes que necesitan apoyo (promedio menor a 11)
SELECT 
    CONCAT(e.nombre, ' ', e.apellido) AS estudiante,
    c.nombre AS curso_reprobado,
    m.calificacion_final,
    e.telefono,
    e.email
FROM estudiantes e
JOIN matriculas m ON e.id_estudiante = m.id_estudiante
JOIN cursos c ON m.id_curso = c.id_curso
WHERE m.calificacion_final < 11
ORDER BY m.calificacion_final;

-- 14. Profesores y cantidad de cursos que imparten
SELECT 
    CONCAT(p.nombre, ' ', p.apellido) AS profesor,
    p.especialidad,
    COUNT(c.id_curso) AS cursos_asignados,
    GROUP_CONCAT(c.nombre SEPARATOR ', ') AS lista_cursos
FROM profesores p
LEFT JOIN cursos c ON p.id_profesor = c.id_profesor
GROUP BY p.id_profesor
ORDER BY cursos_asignados DESC;

-- 15. Cupos disponibles por curso
SELECT 
    c.codigo,
    c.nombre,
    c.grado,
    c.cupo_maximo,
    COUNT(m.id_estudiante) AS matriculados_actuales,
    (c.cupo_maximo - COUNT(m.id_estudiante)) AS cupos_disponibles
FROM cursos c
LEFT JOIN matriculas m ON c.id_curso = m.id_curso AND m.estado = 'activo'
GROUP BY c.id_curso
ORDER BY c.grado, c.nombre;

-- ============================================
-- CONSULTAS ESPECÍFICAS
-- ============================================

-- 16. Historial académico de un estudiante específico
SELECT 
    c.nombre AS curso,
    c.grado,
    m.año_escolar,
    m.calificacion_final,
    m.estado,
    CONCAT(p.nombre, ' ', p.apellido) AS profesor
FROM matriculas m
JOIN cursos c ON m.id_curso = c.id_curso
LEFT JOIN profesores p ON c.id_profesor = p.id_profesor
WHERE m.id_estudiante = 1  -- Cambiar por el ID del estudiante
ORDER BY m.año_escolar DESC, c.grado;

-- 17. Estudiantes matriculados en Matemáticas Básicas
SELECT 
    CONCAT(e.nombre, ' ', e.apellido) AS estudiante,
    e.telefono,
    e.email,
    m.calificacion_final
FROM matriculas m
JOIN estudiantes e ON m.id_estudiante = e.id_estudiante
JOIN cursos c ON m.id_curso = c.id_curso
WHERE c.nombre = 'Matemáticas Básicas' 
  AND m.año_escolar = 2024
ORDER BY e.apellido;

-- 18. Cursos de un grado específico (ej: 1° grado)
SELECT 
    c.nombre AS curso,
    c.horario,
    CONCAT(p.nombre, ' ', p.apellido) AS profesor,
    COUNT(m.id_estudiante) AS estudiantes_matriculados
FROM cursos c
LEFT JOIN profesores p ON c.id_profesor = p.id_profesor
LEFT JOIN matriculas m ON c.id_curso = m.id_curso AND m.estado = 'activo'
WHERE c.grado = '1°'
GROUP BY c.id_curso
ORDER BY c.nombre;

-- 19. Estadísticas generales del colegio
SELECT 
    (SELECT COUNT(*) FROM estudiantes) AS total_estudiantes,
    (SELECT COUNT(*) FROM profesores) AS total_profesores,
    (SELECT COUNT(*) FROM cursos) AS total_cursos,
    (SELECT COUNT(*) FROM matriculas WHERE año_escolar = 2024) AS matriculas_2024,
    (SELECT ROUND(AVG(calificacion_final), 2) FROM matriculas WHERE calificacion_final IS NOT NULL) AS promedio_general,
    (SELECT COUNT(*) FROM matriculas WHERE calificacion_final >= 11 AND estado = 'aprobado') AS estudiantes_aprobados,
    (SELECT COUNT(*) FROM matriculas WHERE calificacion_final < 11 AND estado = 'reprobado') AS estudiantes_reprobados;

-- 20. Estudiantes que cumplen años este mes
SELECT 
    CONCAT(nombre, ' ', apellido) AS estudiante,
    fecha_nacimiento,
    TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()) AS edad,
    telefono,
    email
FROM estudiantes
WHERE MONTH(fecha_nacimiento) = MONTH(CURDATE())
ORDER BY DAY(fecha_nacimiento);

-- ============================================
-- OPERACIONES DE MANTENIMIENTO
-- ============================================

-- 21. Matricular un nuevo estudiante en un curso
INSERT INTO matriculas (id_estudiante, id_curso, año_escolar, estado) 
VALUES (1, 3, 2024, 'activo');

-- 22. Actualizar calificación final de un estudiante
UPDATE matriculas 
SET calificacion_final = 18.0, 
    estado = 'aprobado'
WHERE id_estudiante = 1 AND id_curso = 3;

-- 23. Registrar una nueva calificación
INSERT INTO calificaciones (id_matricula, tipo_evaluacion, nota, observaciones) 
VALUES (1, 'parcial', 17.5, 'Buen desempeño en el examen');

-- 24. Dar de baja a un estudiante de un curso
UPDATE matriculas 
SET estado = 'retirado'
WHERE id_estudiante = 2 AND id_curso = 1;

-- 25. Agregar nuevo estudiante
INSERT INTO estudiantes (dni, nombre, apellido, fecha_nacimiento, direccion, telefono, email) 
VALUES ('12121212K', 'Miguel', 'Álvarez', '2010-09-14', 'Calle Nueva 456', '555-2011', 'miguel.alvarez@email.com');

-- 26. Agregar nuevo curso
INSERT INTO cursos (codigo, nombre, descripcion, id_profesor, grado, horario) 
VALUES ('ART-301', 'Arte y Dibujo', 'Introducción al dibujo y técnicas artísticas', 2, '3°', 'Viernes 14:00-16:00');

-- ============================================
-- VISTAS ÚTILES
-- ============================================

-- Vista: Resumen de estudiantes activos
CREATE VIEW vista_estudiantes_activos AS
SELECT 
    e.id_estudiante,
    CONCAT(e.nombre, ' ', e.apellido) AS estudiante,
    e.fecha_nacimiento,
    TIMESTAMPDIFF(YEAR, e.fecha_nacimiento, CURDATE()) AS edad,
    e.telefono,
    e.email,
    COUNT(DISTINCT m.id_curso) AS cursos_actuales
FROM estudiantes e
LEFT JOIN matriculas m ON e.id_estudiante = m.id_estudiante 
    AND m.estado = 'activo' 
    AND m.año_escolar = YEAR(CURDATE())
GROUP BY e.id_estudiante
ORDER BY e.apellido;

-- Vista: Reporte de calificaciones por curso
CREATE VIEW vista_reportes_cursos AS
SELECT 
    c.codigo,
    c.nombre AS curso,
    c.grado,
    CONCAT(p.nombre, ' ', p.apellido) AS profesor,
    COUNT(m.id_estudiante) AS total_estudiantes,
    ROUND(AVG(m.calificacion_final), 2) AS promedio_curso,
    SUM(CASE WHEN m.calificacion_final >= 11 THEN 1 ELSE 0 END) AS aprobados,
    SUM(CASE WHEN m.calificacion_final < 11 THEN 1 ELSE 0 END) AS reprobados
FROM cursos c
LEFT JOIN profesores p ON c.id_profesor = p.id_profesor
LEFT JOIN matriculas m ON c.id_curso = m.id_curso 
    AND m.año_escolar = YEAR(CURDATE())
GROUP BY c.id_curso;

-- ============================================
-- CONSULTAS CON LAS VISTAS
-- ============================================

-- Usar la vista de estudiantes activos
SELECT * FROM vista_estudiantes_activos;

-- Usar la vista de reportes de cursos
SELECT * FROM vista_reportes_cursos 
WHERE total_estudiantes > 0 
ORDER BY promedio_curso DESC;

-- ============================================
-- INFORMACIÓN DEL SISTEMA
-- ============================================

-- Mostrar todas las tablas
SHOW TABLES;

-- Mostrar estructura de tablas principales
DESCRIBE estudiantes;
DESCRIBE cursos;
DESCRIBE matriculas;

-- Mostrar número de registros
SELECT 
    'Estudiantes' AS tabla,
    COUNT(*) AS cantidad
FROM estudiantes
UNION
SELECT 
    'Profesores',
    COUNT(*)
FROM profesores
UNION
SELECT 
    'Cursos',
    COUNT(*)
FROM cursos
UNION
SELECT 
    'Matrículas',
    COUNT(*)
FROM matriculas
UNION
SELECT 
    'Calificaciones',
    COUNT(*)
FROM calificaciones;