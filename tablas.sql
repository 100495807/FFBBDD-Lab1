CREATE TABLE producto (
    id          NUMBER(7) NOT NULL,
    nombre      VARCHAR2 (50),
    coffea      VARCHAR2 (50),
    varietal    VARCHAR2 (50),
    origen      VARCHAR2 (50),
    tostado     VARCHAR2 (50),
    cafeina     NUMBER (1), --si=1, no=0
    CONSTRAINT pk_producto PRIMARY KEY (id)
) ;

CREATE TABLE formato (
    id          NUMBER(7) NOT NULL,
    nombre      VARCHAR2(50),
    CONSTRAINT pk_formato PRIMARY KEY(id)
);

CREATE TABLE cantidad (
    id          NUMBER(7) NOT NULL,
    cantidad    NUMBER(7),
    magnitud    VARCHAR2(50),
    CONSTRAINT pk_cantidad PRIMARY KEY(id)
);

CREATE TABLE formatoProducto (
    idProducto     NUMBER(7),
    idFormato      NUMBER(7),
    idCantidad     NUMBER(7),
    CONSTRAINT fk_formatoProducto_idProducto FOREIGN KEY(idProducto) REFERENCES producto(id),
    CONSTRAINT fk_formatoProducto_idFormato FOREIGN KEY(idFormato) REFERENCES formato(id),
    CONSTRAINT fk_formatoProducto_idCantidad FOREIGN KEY(idCantidad) REFERENCES cantidad(id)
);

CREATE TABLE articulo (
    idCodigo    NUMBER(7) NOT NULL,
    cantidad    NUMBER(7),
    pvp         NUMBER(7),
    stock       NUMBER(7),
    producto    NUMBER(7),
    stockMin    NUMBER(2),
    stockMax    NUMBER(7),
    CONSTRAINT pk_articulo PRIMARY KEY(idCodigo),
    CONSTRAINT fk_articulo_cantidad FOREIGN KEY(cantidad) REFERENCES cantidad(id),
    CONSTRAINT fk_articulo_producto FOREIGN KEY(producto) REFERENCES producto(id)
);

CREATE TABLE proveedor (
    id              NUMBER(7) NOT NULL,
    cif             NUMBER(9),
    nombreComercio  VARCHAR2(50),
    correo          VARCHAR2(50),
    telefono        NUMBER(10),
    tarjetaBanco    -DUDA-(++++++++++++++),
    codPostal       NUMBER(6),
    pais            VARCHAR2(50),
    tiempoMedio     NUMBER(7),
    numPedido       NUMBER(7),
    CONSTRAINT pk_proveedor PRIMARY KEY(id),

);

CREATE TABLE pedidosProveedor (
    id                  NUMBER(7) NOT NULL,
    proveedor           VARCHAR2(50),
    cantidadUnidad      NUMBER(7),
    fecha               NUMBER(11),
    hora                NUMBER(5),
    estado              VARCHAR(20),
    articulo            NUMBER(7),
    costePedidoTotal    NUMBER(7),
    CONSTRAINT pk_pedidosProveedor PRIMARY KEY(id),
    CONSTRAINT fk_pedidosProveedor_proveedor FOREIGN KEY(proveedor) REFERENCES proveedor(id),
    CONSTRAINT fk_pedidosProveedor_articulo FOREIGN KEY(articulo) REFERENCES articulo(idCodigo)
);

CREATE TABLE proveedorArticulo (
    idArticulo      NUMBER(7),
    idProveedor     NUMBER(7),
    coste           NUMBER(7),
    CONSTRAINT fk_proveedorArticulo_idArticulo FOREIGN KEY(idArticulo) REFERENCES articulo(idCodigo),
    CONSTRAINT fk_proveedorArticulo_idProveedor FOREIGN KEY(idProveedor) REFERENCES proveedor(id),
);

CREATE TABLE cliente (
    id          NUMBER(7) NOT NULL,
    correo      VARCHAR2(50),
    telefono    NUMBER(10),
    nombre      VARCHAR2(50),
    apellido1   VARCHAR2(50),
    apellido2   VARCHAR2(50),
    CONSTRAINT pk_cliente PRIMARY KEY(id)
);

CREATE TABLE registrado (
    id                  NUMBER(7),
    usuario             VARCHAR2(50),
    password            VARCHAR2(50),           --DUDAAAAAAAAAAAAAAAAAAAAAAA(numeros+letras?)
    fechaRegistro       NUMBER(7),
    horaRegistro        NUMBER(7),
    preferenciaContacto VARHCAR2(50),
    direccion           NUMBER(7),
    tarjeta             NUMBER(7),
    bonoDescuento       NUMBER(7),
    CONSTRAINT fk_registrado_id FOREIGN KEY(id) REFERENCES cliente(id),
    CONSTRAINT fk_registrado_direccion FOREIGN KEY(direccion) REFERENCES direccion(id),
    CONSTRAINT fk_registrado_tarjeta FOREIGN KEY(tarjeta) REFERENCES tarjetaCredito(numTarjeta),
    CONSTRAINT fk_registrado_bonoDescuento FOREIGN KEY(bonoDescuento) REFERENCES descuento(id)
);

CREATE TABLE pedidoCliente (
    id              NUMBER(7) NOT NULL,
    fecha           NUMBER(10),
    direccion       NUMBER(7),
    horaPago        NUMBER(5),
    fechaPago       NUMBER(10),
    tarjeta         NUMBER(10),
    fechaEntrega    NUMBER(10),
    precioTotal     NUMBER(7),
    CONSTRAINT pk_pedidoCliente PRIMARY KEY(id),
    CONSTRAINT fk_pedidoCliente_direccion FOREIGN KEY(direccion) REFERENCES direccion(id),
    CONSTRAINT fk_pedidoCliente_tarjeta FOREIGN KEY(tarjeta) REFERENCES tarjetaCredito(numTarjeta)
);

CREATE TABLE pedidoArticuloCliente (
    idPedido        NUMBER(7),
    idArticulo      NUMBER(7),
    idClienteReg    NUMBER(7),
    cantidad        NUMBER(7),
    CONSTRAINT fk_pedidoArticuloCliente_idPedido FOREIGN KEY(idPedido) REFERENCES pedidoCliente(id),
    CONSTRAINT fk_pedidoArticuloCliente_idArticulo FOREIGN KEY(idArticulo) REFERENCES articulo(idCodigo),
    CONSTRAINT fk_pedidoArticuloCliente_idClienteReg FOREIGN KEY(idClienteReg) REFERENCES cliente(id)
);

CREATE TABLE tarjetaCredito (
    numTarjeta      NUMBER(10) NOT NULL,
    titular         VARCHAR2(50),
    company        VARCHAR2(50),
    caducidad       NUMBER(50),
    CONSTRAINT pk_tarjetaCredito PRIMARY KEY(numTarjeta)
);

CREATE TABLE direccion (
    id              NUMBER(7) NOT NULL,
    tipoVia         VARCHAR2(50),
    nombreVia       VARCHAR2(50),
    numInmueble     NUMBER(3),
    numBloque       NUMBER(3),
    escalera        VARCHAR(50),
    piso            NUMBER(3),
    puerta          VARCHAR2(1),
    codigoPostal    NUMBER(5),
    ciudad          VARCHAR2(50),
    pais            VARCHAR2(50),
    CONSTRAINT pk_direccion PRIMARY KEY(id)
);

CREATE TABLE descuento (
    id          NUMBER(7) NOT NULL,
    porcentaje  NUMBER(4),
    fecha       NUMBER(10),
    CONSTRAINT pk_descuento PRIMARY KEY(id)
);

CREATE TABLE  review(
    id          NUMBER(7) NOT NULL,
    usuario     VARCHAR2(50),
    articulo    NUMBER(7),
    puntuacion  NUMBER(1),
    titulo      VARCHAR2(50),
    texto       VARCHAR2(500),
    like        NUMBER(10),
    refrena     VARCHAR2(50),
    CONSTRAINT pk_review PRIMARY KEY(id),
    CONSTRAINT fk_review_usuario FOREIGN KEY(usuario) REFERENCES registrado(usuario),
    CONSTRAINT fk_review_articulo FOREIGN KEY(articulo) REFERENCES articulo(idArticulo)
);
