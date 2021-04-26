CREATE DATABASE VentasCompras;
USE VentasCompras;

CREATE TABLE Region(
	id_region INTEGER PRIMARY KEY NOT NULL,
	nombre VARCHAR(50),
	cantidad_tiendas INTEGER NOT NULL,
	comentarios VARCHAR(200)
);

CREATE TABLE Tienda(
	id_tienda INTEGER PRIMARY KEY NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	tiene_sitio_web BIT,
	URL_sitio_web VARCHAR(255),
	descripcion VARCHAR(200)
);

CREATE TABLE TiendaRegion(
	id_region INTEGER NOT NULL,
	id_tienda INTEGER NOT NULL,
	FOREIGN KEY (id_region) REFERENCES Region(id_region),
	FOREIGN KEY (id_tienda) REFERENCES Tienda(id_tienda),
	PRIMARY KEY(id_region,id_tienda)
);


CREATE TABLE Proveedor(
	id_proveedor INTEGER PRIMARY KEY NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	correo VARCHAR(50) NOT NULL,
	telefono VARCHAR(50) NOT NULL,
	direccion VARCHAR(50) NOT NULL,
	descripcion VARCHAR(200),
	comentarios VARCHAR(200)
);

CREATE TABLE TiendaProveedor(
	id_proveedor INTEGER NOT NULL,
	id_tienda INTEGER NOT NULL,
	FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor),
	FOREIGN KEY (id_tienda) REFERENCES Tienda(id_tienda),
	PRIMARY KEY(id_proveedor,id_tienda)
);

CREATE TABLE Categoria(
	id_categoria INTEGER PRIMARY KEY NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	id_tienda INTEGER NOT NULL,
	FOREIGN KEY (id_tienda) REFERENCES Tienda(id_tienda)
);

CREATE TABLE TipoProducto(
	id_tipo_producto INTEGER PRIMARY KEY NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	id_categoria INTEGER NOT NULL,
	FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

CREATE TABLE Producto(
	id_producto INTEGER PRIMARY KEY NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	cantidad_disponible INTEGER NOT NULL,
	precio_por_unidad DECIMAL(8,2),
	descripcion VARCHAR(200) NOT NULL,
	comentarios VARCHAR(200) NOT NULL,
	garantia VARCHAR(50),
	id_proveedor INTEGER NOT NULL,
	id_tipo_producto INTEGER NOT NULL,
	FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor),
	FOREIGN KEY (id_tipo_producto) REFERENCES TipoProducto(id_tipo_producto)
);

CREATE TABLE OrdenProveedor(
	id_proveedor INTEGER NOT NULL,
	id_producto INTEGER  NOT NULL,
	es_completado BIT NOT NULL,
	cantidad INTEGER NOT NULL,
	fecha_orden DATE NOT NULL,
	fecha_estimada_entrega DATE NOT NULL,
	FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor),
	FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
	PRIMARY KEY(id_proveedor,id_producto)
);

CREATE TABLE Paquete(
	id_paquete INTEGER PRIMARY KEY NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	precio DECIMAL(8,2) NOT NULL
);

CREATE TABLE ProductoPaquete(
	id_producto INTEGER NOT NULL,
	id_paquete INTEGER NOT NULL,
	FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
	FOREIGN KEY (id_paquete) REFERENCES Paquete(id_paquete),
	PRIMARY KEY(id_producto,id_paquete)
);


CREATE TABLE Remitente(
	id_remitente INTEGER PRIMARY KEY NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	telefono VARCHAR(15) NOT NULL,
	correo VARCHAR(100) NOT NULL,
	direccion VARCHAR(150) NOT NULL,
	descripcion VARCHAR(100) NOT NULL,
	comentarios VARCHAR(200) NOT NULL
);

CREATE TABLE TipoCuenta(
	id_tipo_cuenta INTEGER PRIMARY KEY NOT NULL,
	tipo VARCHAR(50) NOT NULL
);

CREATE TABLE Cliente(
	id_cliente INTEGER PRIMARY KEY NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	es_cliente_fijo BIT NOT NULL,
	numero_cuenta VARCHAR(25) NOT NULL,
	direccion VARCHAR(50) NOT NULL,
	telefono VARCHAR(15) NOT NULL,
	descripcion VARCHAR(50) NOT NULL,
	comentarios VARCHAR(150) NOT NULL,
	id_tipo_cuenta INTEGER NOT NULL,
	FOREIGN KEY (id_tipo_cuenta) REFERENCES TipoCuenta(id_tipo_cuenta)
);

CREATE TABLE Temporada(
	id_temporada INTEGER PRIMARY KEY NOT NULL,
	temporada VARCHAR(100) NOT NULL,
	descripcion VARCHAR(150) NOT NULL,
	comentarios VARCHAR(200) NOT NULL
);


CREATE TABLE Venta(
	id_venta INTEGER PRIMARY KEY NOT NULL,
	fecha DATE NOT NULL,
	cantidad INTEGER NOT NULL,
	subTotal DECIMAL(8,2) NOT NULL,
	descuento DECIMAL(8,2) NOT NULL,
	isv DECIMAL(8,2) NOT NULL,
	total DECIMAL(8,2) NOT NULL,
	id_producto INTEGER,
	id_cliente INTEGER,
	id_paquete INTEGER,
	id_remitente INTEGER NOT NULL,
	id_region INTEGER NOT NULL,
	id_temporada INTEGER NOT NULL,
	FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
	FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
	FOREIGN KEY (id_paquete) REFERENCES Paquete(id_paquete),
	FOREIGN KEY (id_remitente) REFERENCES Remitente(id_remitente),
	FOREIGN KEY (id_region) REFERENCES Region(id_region),
	FOREIGN KEY (id_temporada) REFERENCES Temporada(id_temporada)
);

