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