-- crendo bd
CREATE DATABASE prueba;
-- entrando a la bd
\c prueba
-- creando tablas
CREATE TABLE clientes(
id_cliente SERIAL PRIMARY KEY,
nom_cliente VARCHAR(30) NOT NULL,
rut VARCHAR(10) UNIQUE NOT NULL,
direccion VARCHAR(60)
);

CREATE TABLE facturas(
num_factura SERIAL PRIMARY KEY,
id_cliente INT NOT NULL REFERENCES clientes(id_cliente),
fecha DATE NOT NULL,
sub_total INT NOT NULL,
iva INT NOT NULL,
valor_total INT NOT NULL
);

CREATE TABLE categorias(
id_categoria SERIAL PRIMARY KEY,
nom_categoria VARCHAR(20) NOT NULL UNIQUE,
descrip_categoria VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE productos(
id_producto SERIAL PRIMARY KEY,
nom_producto VARCHAR(20) UNIQUE NOT NULL,
descrip_producto VARCHAR(60) UNIQUE NOT NULL,
valor_unitario INT NOT NULL,
id_categoria INT NOT NULL REFERENCES categorias(id_categoria)
);

CREATE TABLE lista_productos(
num_factura INT NOT NULL REFERENCES facturas(num_factura),
id_producto INT NOT NULL REFERENCES productos(id_producto),
cantidad INT
);

-- Incertando datos en las tablas
INSERT INTO clientes(nom_cliente,rut,direccion) VALUES
('Maria', '15688334-5', 'calle uno 585'),
('Carlota', '36845394-k', 'calle dos 354'),
('Bruno', '68435219-7', 'calle tres 655'),
('Marcia', '36428757-4', 'calle cuatro 647'),
('Simon', '65835449-6', 'calle cinco 148')
;

INSERT INTO categorias(nom_categoria, descrip_categoria) VALUES
('Salado', 'descripcion de salado'),
('dulce', 'descripcion de dulce'),
('aderezos', 'descripcion de aderezos')
;

INSERT INTO facturas(id_cliente, fecha, sub_total, iva, valor_total) VALUES
(1, '2021-01-25', 1, 1, 3300),
(4, '2021-01-25', 6, 6, 3000),
(2, '2021-01-25', 2, 2, 2400),
(1, '2021-01-25', 3, 3, 3590),
(4, '2021-01-25', 9, 9, 2400),
(3, '2021-01-25', 4, 4, 500),
(2, '2021-01-25', 5, 5, 1800),
(4, '2021-01-25', 7, 7, 4580),
(2, '2021-01-25', 8, 8, 3790),
(4, '2021-01-25', 10, 10, 2000)
;

INSERT INTO productos(id_categoria, nom_producto, descrip_producto, valor_unitario) VALUES
(2, 'chocolate', 'chocolate 100g', 1000),
(1, 'cheetos', 'cheetos 250g', 1300),
(2, 'galletas', 'galletas 80g', 800),
(1, 'papas fritas', 'papasfritas 150g', 1500),
(3, 'mayonesa', 'mayonesa 500g', 990),
(2, 'gomitas', 'gomitas 50g', 500),
(1, 'doritos', 'doritos 1k', 2000),
(3, 'ketshup', 'ketshup 500g', 1300)
;

-- Organizado segun el id de cliente
INSERT INTO lista_productos(num_factura, id_producto, cantidad) VALUES
(1,2,1), (1,7,1), (4,8,2), (4,5,1),
(3,3,3), (7,2,1), (7,6,1), (9,8,1), (9,5,1), (9,4,1),
(6,6,1),
(2,4,2), (5,3,3), (8,8,2), (8,5,2), (10,7,1)
;
