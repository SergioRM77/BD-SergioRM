drop database if exists organigramaempresa;
create database organigramaempresa;
SET foreign_key_checks = 0;


create table organigramaempresa.categorias (
	id_categoria int auto_increment primary key,
    categoria varchar (30) not null
);
create table organigramaempresa.departamentos (
	id_departamento int auto_increment primary key,
    nombre varchar (30) not null,
    id_coordinador int default null,
    
    constraint foreign key (id_coordinador) references organigramaempresa.empleados(id_empleado)
);


create table organigramaempresa.empleados (
	id_empleado int auto_increment primary key,
	dni varchar (20) not null,
    nss varchar (20) not null,
    nombre varchar (20) not null,
    apellidos varchar (50) not null,
    direccion varchar(50) not null,
    telefono varchar (12) not null,
    isCoordinador boolean default false,
    departamento int,
    
	constraint foreign key (departamento) references organigramaempresa.departamentos(id_departamento)
	
    
);


create table organigramaempresa.contrato (
	id_contrato int auto_increment primary key,
    fecha_ini date not null,
    fecha_fin date default null,
    numempleado int,
    numcategoria int,
    
    constraint foreign key (numempleado) references empleados(id_empleado),
	constraint foreign key (numcategoria) references categorias(id_categoria)
);



create table organigramaempresa.nominas (
	id_nomina  int auto_increment primary key,
    sueldo float not null,
    detalles varchar (50) default null,
    numcontrato int,
    
    constraint foreign key (numcontrato) references contrato(id_contrato)
);

create table organigramaempresa.exempleados (
	id_empleado int primary key,
	dni varchar (20) not null,
    nss varchar (20) not null,
    nombre varchar (20) not null,
    apellidos varchar (50) not null,
    direccion varchar(50) not null,
    telefono varchar (12) not null,
    isCoordinador boolean not null,
    departamento int not null,
    fechaeliminacion datetime
    	
    
);
/*CREAMOS UN TRIGGER: es un disparador o script especial, que añade acciones a una operación ( INSERT, UPDATE y DELETE ), en este caso
a DELETE le digo--> crear un disparador 'eliminar trabajador' que despues de eliminar la de la tabla 'empleados' me recorres la dila
y la metes en en tabla 'exempleados' con los (nombres de columna) con (valores). OLD hace referencia a ese valor existente antes del DELETE*/
create trigger organigramaempresa.eliminarTrabajador after delete on organigramaempresa.empleados for each row insert into organigramaempresa.exempleados
(id_empleado, dni, nss, nombre, apellidos, direccion, telefono, isCoordinador, departamento, fechaeliminacion)
values (old.id_empleado, old.dni, old.nss, old.nombre, old.apellidos, old.direccion, old.telefono, old.isCoordinador, old.departamento, now());

/*AÑADIMOS CONTENIDO A LAS TABLAS*/
insert into organigramaempresa.departamentos (nombre, id_coordinador) values ("Recursos Humanos", null);
insert into organigramaempresa.departamentos (nombre, id_coordinador) values ("Almacén", 16);
insert into organigramaempresa.departamentos (nombre, id_coordinador) values ("Zona Ventas", 15);
insert into organigramaempresa.departamentos (nombre, id_coordinador) values ("Comerciales", null);
insert into organigramaempresa.departamentos (nombre, id_coordinador) values ("Taller", null);
insert into organigramaempresa.departamentos (nombre, id_coordinador) values ("Muelle", null);

insert into organigramaempresa.categorias (categoria) values ("Oficinista");
insert into organigramaempresa.categorias (categoria) values ("Mozo almacén");
insert into organigramaempresa.categorias (categoria) values ("Cajero");
insert into organigramaempresa.categorias (categoria) values ("Comercial");
insert into organigramaempresa.categorias (categoria) values ("Mantenimiento");
insert into organigramaempresa.categorias (categoria) values ("Mozo de Carga");

insert into organigramaempresa.empleados (dni ,nss ,nombre ,apellidos ,direccion ,telefono ,isCoordinador ,departamento) 
	values ("22554466F", "123456789-M", "Juan", "Cañas", "Calle La Tercia","66666666", false, 1);
insert into organigramaempresa.empleados (dni ,nss ,nombre ,apellidos ,direccion ,telefono ,isCoordinador ,departamento) 
	values ("32554466F", "023456789-M", "Felipe", "Castañas", "Calle La Pila","665214785", false, 2);
insert into organigramaempresa.empleados (dni ,nss ,nombre ,apellidos ,direccion ,telefono ,isCoordinador ,departamento) 
	values ("2250006L", "123456700-M", "Maria", "Mayo", "Calle Triana","231147520", false, 6);
insert into organigramaempresa.empleados (dni ,nss ,nombre ,apellidos ,direccion ,telefono ,isCoordinador ,departamento) 
	values ("11478520V", "177756789-M", "Oscar", "Diaz", "Avenida la Paz","102030124", false, 4);
insert into organigramaempresa.empleados (dni ,nss ,nombre ,apellidos ,direccion ,telefono ,isCoordinador ,departamento) 
	values ("00100200Q", "11211311-M", "Juan", "Pancetas", "Pol, Plaza","88554466", false, 2);
insert into organigramaempresa.empleados (dni ,nss ,nombre ,apellidos ,direccion ,telefono ,isCoordinador ,departamento) 
	values ("00200300W", "777456789-M", "Kiko", "Rivera", "Calle Vago","45561230", false, 5);
insert into organigramaempresa.empleados (dni ,nss ,nombre ,apellidos ,direccion ,telefono ,isCoordinador ,departamento) 
	values ("00400550D", "30523230-T", "Belen", "Esteban", "Calle Andrea Mato","66666600", false, 3);
insert into organigramaempresa.empleados (dni ,nss ,nombre ,apellidos ,direccion ,telefono ,isCoordinador ,departamento) 
	values ("22554466H", "123456799-F", "Falete", "Falsete", "Calle Cantante","66664586", false, 4);
insert into organigramaempresa.empleados (dni ,nss ,nombre ,apellidos ,direccion ,telefono ,isCoordinador ,departamento) 
	values ("20054466F", "100456789-M", "Concha", "Velasco", "Calle Loncha Velasco","702547789", false, 2);
insert into organigramaempresa.empleados (dni ,nss ,nombre ,apellidos ,direccion ,telefono ,isCoordinador ,departamento) 
	values ("44454466F", "123456789-L", "Picolo", "Junior", "Calle La Namek","99999901", false, 1);
insert into organigramaempresa.empleados (dni ,nss ,nombre ,apellidos ,direccion ,telefono ,isCoordinador ,departamento) 
	values ("22554406G", "123701789-G", "Matias", "Cañas", "Calle Fisrt Dates","745841666", false, 2);
insert into organigramaempresa.empleados (dni ,nss ,nombre ,apellidos ,direccion ,telefono ,isCoordinador ,departamento) 
	values ("258134785C", "14785420-J", "King", "Kong", "Calle Estrellado","00000000", false, 1);
insert into organigramaempresa.empleados (dni ,nss ,nombre ,apellidos ,direccion ,telefono ,isCoordinador ,departamento) 
	values ("35801296S", "12391234-M", "Fantasma", "Casper", "Casa Embrujada","666999666", false, 5);
insert into organigramaempresa.empleados (dni ,nss ,nombre ,apellidos ,direccion ,telefono ,isCoordinador ,departamento) 
	values ("87788711Y", "32101234-O", "Canijo", "De Jerez", "Aire de la Calle","790124458", false, 3);
insert into organigramaempresa.empleados (dni ,nss ,nombre ,apellidos ,direccion ,telefono ,isCoordinador ,departamento) 
	values ("58852545Ñ", "01001001-U", "Jagger", "Meister", "Calle Alcoholica","00666666", true, 1);
insert into organigramaempresa.empleados (dni ,nss ,nombre ,apellidos ,direccion ,telefono ,isCoordinador ,departamento) 
	values ("25937804G", "14587166-M", "Tomas", "Cañas", "Calle Carrera","11666666", true, 1);
    
insert into organigramaempresa.contrato (fecha_ini, fecha_fin, numempleado, numcategoria) 
	values ("2007-05-11", null, 1, 1);
insert into organigramaempresa.contrato (fecha_ini, fecha_fin, numempleado, numcategoria) 
	values ("2014-07-01", "2022-01-11", 2, 1);
insert into organigramaempresa.contrato (fecha_ini, fecha_fin, numempleado, numcategoria) 
	values ("2016-11-21", "2021-01-11", 3, 2);
insert into organigramaempresa.contrato (fecha_ini, fecha_fin, numempleado, numcategoria) 
	values ("2017-06-11", null, 4, 4);
insert into organigramaempresa.contrato (fecha_ini, fecha_fin, numempleado, numcategoria) 
	values ("2018-05-11", null, 5, 4);
insert into organigramaempresa.contrato (fecha_ini, fecha_fin, numempleado, numcategoria) 
	values ("2020-12-20", "2022-03-11", 6, 5);
insert into organigramaempresa.contrato (fecha_ini, fecha_fin, numempleado, numcategoria) 
	values ("2019-05-17", null, 7, 3);
insert into organigramaempresa.contrato (fecha_ini, fecha_fin, numempleado, numcategoria) 
	values ("2020-05-11", "2022-01-29", 8, 3);
insert into organigramaempresa.contrato (fecha_ini, fecha_fin, numempleado, numcategoria) 
	values ("2021-05-20", null, 9, 3);
insert into organigramaempresa.contrato (fecha_ini, fecha_fin, numempleado, numcategoria) 
	values ("2018-05-21", null, 10, 5);
insert into organigramaempresa.contrato (fecha_ini, fecha_fin, numempleado, numcategoria) 
	values ("2019-09-11", null, 11, 6);
insert into organigramaempresa.contrato (fecha_ini, fecha_fin, numempleado, numcategoria) 
	values ("2017-05-11", "2020-01-11", 12, 6);
insert into organigramaempresa.contrato (fecha_ini, fecha_fin, numempleado, numcategoria) 
	values ("2019-10-11", null, 13, 1);
insert into organigramaempresa.contrato (fecha_ini, fecha_fin, numempleado, numcategoria) 
	values ("2010-05-11", "2013-08-13", 14, 4);
insert into organigramaempresa.contrato (fecha_ini, fecha_fin, numempleado, numcategoria) 
	values ("2020-05-11", null, 15, 3);
insert into organigramaempresa.contrato (fecha_ini, fecha_fin, numempleado, numcategoria) 
	values ("2017-05-11", null, 16, 3);


insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (10011, "empleado 2 desde 2014", 2);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (10011, "empleado 2 desde 2014", 2);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (10011, "empleado 2 desde 2014", 2);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (10011, "empleado 2 desde 2014", 2);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (10011, "empleado 2 desde 2014", 2);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (10011, "empleado 2 desde 2014", 2);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (10011, "empleado 2 desde 2014", 2);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (3000, "empleado 2 desde 2014", 2);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (14025, "empleado 3 desde 2016", 3);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (14025, "empleado 3 desde 2016", 3);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (14025, "empleado 3 desde 2016", 3);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (14025, "empleado 3 desde 2016", 3);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (14025, "empleado 3 desde 2016", 3);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (2570, "empleado 3 desde 2016", 3);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (21005, "empleado 4 desde 2017", 4);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (21005, "empleado 4 desde 2017", 4);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (21005, "empleado 4 desde 2017", 4);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (21005, "empleado 4 desde 2017", 4);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (21005, "empleado 4 desde 2017", 4);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (10114, "empleado 5 desde 2018", 5);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (10114, "empleado 5 desde 2018", 5);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (10114, "empleado 5 desde 2018", 5);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (70504, "empleado 5 desde 2018", 5);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (13150, "empleado 6 desde 2020", 6);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (13150, "empleado 6 desde 2020", 6);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (1058, "empleado 6 desde 2020", 6);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (16150, "empleado 7 desde 2019", 7);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (16150, "empleado 7 desde 2019", 7);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (9050, "empleado 7 desde 2019", 7);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (16000, "empleado 8 desde 2020", 8);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (16000, "empleado 8 desde 2020", 8);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (17400, "empleado 9 desde 2021", 9);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (5120, "empleado 9 desde 2021", 9);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (13003, "empleado 10 desde 2018", 10);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (13003, "empleado 10 desde 2018", 10);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (13003, "empleado 10 desde 2018", 10);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (2000, "empleado 10 desde 2018", 10);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (15003, "empleado 11 desde 2019", 11);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (15003, "empleado 11 desde 2019", 11);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (2050, "empleado 11 desde 2019", 11);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (7800, "empleado 12 desde 2017", 12);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (1200, "empleado 12 desde 2017", 12);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (9899, "empleado 13 desde 2019", 13);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (9899, "empleado 13 desde 2019", 13);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (1033, "empleado 13 desde 2019", 13);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (10111, "empleado 14 desde 2010", 14);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (10111, "empleado 14 desde 2010", 14);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (14000, "empleado 14 desde 2010", 14);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (16111, "empleado 15 desde 2020", 15);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (16111, "empleado 15 desde 2020", 15);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (103, "empleado 15 desde 2020", 15);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (13010, "empleado 16 desde 2017", 16);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (13010, "empleado 16 desde 2017", 16);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (13010, "empleado 16 desde 2017", 16);
insert into organigramaempresa.nominas (sueldo, detalles, numcontrato) 
	values (10102, "empleado 16 desde 2017", 16);
SET foreign_key_checks = 1;







