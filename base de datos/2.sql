CREATE DATABASE IF NOT EXISTS biblioteca;
USE biblioteca;

-- 2. Crear tabla autores
CREATE TABLE personas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    pais VARCHAR(50),
    fecha_nacimiento DATE
);

-- 4. Insertar datos en autores
INSERT INTO personas (nombre, apellido, pais, fecha_nacimiento) VALUES
('Gabriel', 'García Márquez', 'Colombia', '1927-03-06'),
('Mario', 'Vargas Llosa', 'Perú', '1936-03-28'),
('Isabel', 'Allende', 'Chile', '1942-08-02'),
('Julio', 'Cortázar', 'Argentina', '1914-08-26'),
('Jorge Luis', 'Borges', 'Argentina', '1899-08-24'),
('Laura', 'Esquivel', 'México', '1950-09-30');

CREATE TABLE librospersonas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    autor_id INT NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    año_publicacion INT,
    genero VARCHAR(50),
    paginas INT,
    disponible BOOLEAN DEFAULT TRUE
    );
    
INSERT INTO librospersonas (titulo, autor_id, isbn, año_publicacion, genero, paginas, disponible) VALUES
('Cien años de soledad', 1, '978-0307474728', 1967, 'Realismo mágico', 417, TRUE),
('El amor en los tiempos del cólera', 1, '978-0307389732', 1985, 'Novela', 348, FALSE),
('La ciudad y los perros', 2, '978-8420471836', 1963, 'Novela', 446, TRUE),
('La casa de los espíritus', 3, '978-9500716496', 1982, 'Novela', 433, TRUE),
('Rayuela', 4, '978-8420421121', 1963, 'Novela experimental', 736, TRUE),
('Ficciones', 5, '978-8420672058', 1944, 'Cuentos', 224, TRUE),
('Como agua para chocolate', 6, '978-0385721233', 1989, 'Novela', 245, FALSE),
('Crónica de una muerte anunciada', 1, '978-0307475336', 1981, 'Novela', 120, TRUE),
('El otoño del patriarca', 1, '978-8437604942', 1975, 'Novela', 285, TRUE),
('La tía Julia y el escribidor', 2, '978-8420471843', 1977, 'Novela', 448, TRUE);