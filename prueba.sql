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
nom_categoria VARCHAR(40) NOT NULL UNIQUE,
descrip_categoria VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE productos(
id_producto SERIAL PRIMARY KEY,
nom_producto VARCHAR(40) UNIQUE NOT NULL,
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
('instrumentos de percucion', 'categoria de instrumentos de percucion'),
('instrumentos de cuerda', 'categoria de instrumentos de cuerdas'),
('instrumentos de viento', 'categoria de instrumentos de viento')
;

INSERT INTO facturas(id_cliente, fecha, sub_total, iva, valor_total) VALUES
(1, '2021-01-25', 590000, 112100, 702100),
(4, '2021-01-25', 60000, 11400, 71400),
(2, '2021-01-25', 15000, 2850, 17850),
(1, '2021-01-25', 405000, 76950, 481950),
(4, '2021-01-25', 15000, 2850, 17850),
(3, '2021-01-25', 20000, 3800, 23800),
(2, '2021-01-25', 110000, 20900, 130900),
(4, '2021-01-25', 440000, 83600, 523600),
(2, '2021-01-25', 265000, 50350, 315350),
(4, '2021-01-25', 500000, 95000, 595000)

;

INSERT INTO productos(id_categoria, nom_producto, descrip_producto, valor_unitario) VALUES
(2, 'guitarra', 'guitarra acustica', 30000),
(1, 'bongo', 'bongo color negro', 90000),
(2, 'bajo ', 'bajo electrico', 70000),
(1, 'timbales', 'set de dos timbales', 60000),
(3, 'flauta', 'flauta dulce', 5000),
(2, 'ukelele', 'ukelele morado', 20000),
(1, 'bateria', 'bateria yamaha', 500000),
(3, 'acordeon', 'acordeon hohner', 200000)
;

-- Organizado segun el id de cliente
INSERT INTO lista_productos(num_factura, id_producto, cantidad) VALUES
(1,2,1), (1,7,1), (4,8,2), (4,5,1),
(3,5,3), (7,2,1), (7,6,1), (9,8,1), (9,5,1), (9,4,1),
(6,6,1),
(2,1,2), (5,3,3), (8,8,2), (8,6,2), (10,7,1)
;

-- Consultas 

-- Que cliente realizo la compra mas cara?

SELECT clientes.nom_cliente
FROM facturas 
INNER JOIN clientes 
ON clientes.id_cliente = facturas.id_cliente
ORDER BY facturas.valor_total DESC LIMIT 1
;

-- que cliente paso sobre 100 de monto

SELECT clientes.nom_cliente
FROM facturas 
INNER JOIN clientes 
ON clientes.id_cliente = facturas.id_cliente
WHERE facturas.valor_total > 100000
;

-- cuantos clientes han comprado el producto 6

SELECT COUNT(*)
FROM clientes 
INNER JOIN facturas
ON clientes.id_cliente = facturas.id_cliente
INNER JOIN lista_productos
ON lista_productos.num_factura = facturas.num_factura 
WHERE lista_productos.id_producto = 6
;
