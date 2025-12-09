CREATE DATABASE IF NOT EXISTS ventas;
create database ventas;
USE ventas;

-- 2. Crear tabla clientes (simple)
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telefono VARCHAR(20),
    fecha_registro DATE DEFAULT (CURRENT_DATE)
);

-- 3. Crear tabla productos (simple)
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0
);

-- 4. Crear tabla facturas (simple)
CREATE TABLE facturas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    fecha DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

INSERT INTO clientes (nombre, email, telefono) VALUES
('Juan Pérez', 'juan@email.com', '555-1234'),
('María García', 'maria@email.com', '555-5678'),
('Carlos López', 'carlos@email.com', '555-9012'),
('Ana Martínez', 'ana@email.com', '555-3456');

-- Insertar productos
INSERT INTO productos (nombre, precio, stock) VALUES
('Laptop', 1200.00, 10),
('Mouse', 25.50, 50),
('Teclado', 45.00, 30),
('Monitor', 300.00, 15),
('USB 32GB', 20.00, 100),
('Audífonos', 80.00, 25);

-- Insertar facturas
INSERT INTO facturas (cliente_id, fecha, total) VALUES
(1, '2024-01-10', 1225.50),
(2, '2024-01-11', 345.00),
(3, '2024-01-12', 1600.00),
(1, '2024-01-13', 80.00),
(4, '2024-01-14', 65.50);

-- Insertar detalles de factura
INSERT INTO detalles_factura (factura_id, producto_id, cantidad, precio) VALUES
(1, 1, 1, 1200.00),  -- Factura 1: Laptop
(1, 2, 1, 25.50),    -- Factura 1: Mouse
(2, 3, 2, 45.00),    -- Factura 2: 2 Teclados
(2, 4, 1, 300.00),   -- Factura 2: Monitor
(3, 1, 1, 1200.00),  -- Factura 3: Laptop
(3, 4, 1, 300.00),   -- Factura 3: Monitor
(3, 6, 1, 80.00),    -- Factura 3: Audífonos
(4, 6, 1, 80.00),    -- Factura 4: Audífonos
(5, 2, 2, 25.50),    -- Factura 5: 2 Mouses
(5, 5, 1, 20.00);    -- Factura 5: USB

-- ============================================
-- CONSULTAS BÁSICAS
-- ============================================

-- 1. Ver todos los clientes
SELECT * FROM clientes;

