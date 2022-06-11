drop database if exists OrganigramaEmpresa;
create database OrganigramaEmpresa;
SET foreign_key_checks = 0;


create table OrganigramaEmpresa.Categorias (
	id_categoria int auto_increment primary key,
    Categoria varchar (30) not null
);
create table OrganigramaEmpresa.Departamentos (
	id_departamento int auto_increment primary key,
    Nombre varchar (30) not null,
    Id_coordinador int default null,
    
    constraint foreign key (Id_coordinador) references OrganigramaEmpresa.Empleados(id_empleado)
);


create table OrganigramaEmpresa.Empleados (
	id_empleado int auto_increment primary key,
	DNI varchar (20) not null,
    NSS varchar (20) not null,
    Nombre varchar (20) not null,
    Apellidos varchar (50) not null,
    Direccion varchar(50) not null,
    Telefono varchar (12) not null,
    isCoordinador boolean default false,
    Departamento int,
    
	constraint foreign key (Departamento) references OrganigramaEmpresa.Departamentos(id_departamento)
	
    
);


create table OrganigramaEmpresa.Contrato (
	id_contrato int auto_increment primary key,
    Fecha_ini date not null,
    Fecha_fin date default null,
    NumEmpleado int,
    NumCategoria int,
    
    constraint foreign key (NumEmpleado) references Empleados(id_empleado),
	constraint foreign key (NumCategoria) references Categorias(id_categoria)
);



create table OrganigramaEmpresa.Nominas (
	id_nomina  int auto_increment primary key,
    Sueldo float not null,
    Detalles varchar (50) default null,
    NumContrato int,
    
    constraint foreign key (NumContrato) references Contrato(id_contrato)
);

create table OrganigramaEmpresa.EXEmpleados (
	id_empleado int primary key,
	DNI varchar (20) not null,
    NSS varchar (20) not null,
    Nombre varchar (20) not null,
    Apellidos varchar (50) not null,
    Direccion varchar(50) not null,
    Telefono varchar (12) not null,
    isCoordinador boolean not null,
    Departamento int not null,
    FechaEliminacion datetime
    	
    
);
/*CREAMOS UN TRIGGER: es un disparador o script especial, que añade acciones a una operación ( INSERT, UPDATE y DELETE ), en este caso
a DELETE le digo--> crear un disparador 'eliminar trabajador' que despues de eliminar la de la tabla 'Empleados' me recorres la dila
y la metes en en tabla 'ExEmpleados' con los (nombres de columna) con (valores). OLD hace referencia a ese valor existente antes del DELETE*/
create trigger OrganigramaEmpresa.eliminarTrabajador after delete on OrganigramaEmpresa.Empleados for each row insert into OrganigramaEmpresa.EXEmpleados
(id_empleado, DNI, NSS, Nombre, Apellidos, Direccion, Telefono, isCoordinador, Departamento, FechaEliminacion)
values (old.id_empleado, old.DNI, old.NSS, old.Nombre, old.Apellidos, old.Direccion, old.Telefono, old.isCoordinador, old.Departamento, now());

/*AÑADIMOS CONTENIDO A LAS TABLAS*/
insert into OrganigramaEmpresa.Departamentos (Nombre, Id_coordinador) values ("Recursos Humanos", null);
insert into OrganigramaEmpresa.Departamentos (Nombre, Id_coordinador) values ("Almacén", 16);
insert into OrganigramaEmpresa.Departamentos (Nombre, Id_coordinador) values ("Zona Ventas", 15);
insert into OrganigramaEmpresa.Departamentos (Nombre, Id_coordinador) values ("Comerciales", null);
insert into OrganigramaEmpresa.Departamentos (Nombre, Id_coordinador) values ("Taller", null);
insert into OrganigramaEmpresa.Departamentos (Nombre, Id_coordinador) values ("Muelle", null);

insert into OrganigramaEmpresa.Categorias (Categoria) values ("Oficinista");
insert into OrganigramaEmpresa.Categorias (Categoria) values ("Mozo almacén");
insert into OrganigramaEmpresa.Categorias (Categoria) values ("Cajero");
insert into OrganigramaEmpresa.Categorias (Categoria) values ("Comercial");
insert into OrganigramaEmpresa.Categorias (Categoria) values ("Mantenimiento");
insert into OrganigramaEmpresa.Categorias (Categoria) values ("Mozo de Carga");

insert into OrganigramaEmpresa.Empleados (DNI ,NSS ,Nombre ,Apellidos ,Direccion ,Telefono ,isCoordinador ,Departamento) 
	values ("22554466F", "123456789-M", "Juan", "Cañas", "Calle La Tercia","66666666", false, 1);
insert into OrganigramaEmpresa.Empleados (DNI ,NSS ,Nombre ,Apellidos ,Direccion ,Telefono ,isCoordinador ,Departamento) 
	values ("32554466F", "023456789-M", "Felipe", "Castañas", "Calle La Pila","665214785", false, 2);
insert into OrganigramaEmpresa.Empleados (DNI ,NSS ,Nombre ,Apellidos ,Direccion ,Telefono ,isCoordinador ,Departamento) 
	values ("2250006L", "123456700-M", "Maria", "Mayo", "Calle Triana","231147520", false, 6);
insert into OrganigramaEmpresa.Empleados (DNI ,NSS ,Nombre ,Apellidos ,Direccion ,Telefono ,isCoordinador ,Departamento) 
	values ("11478520V", "177756789-M", "Oscar", "Diaz", "Avenida la Paz","102030124", false, 4);
insert into OrganigramaEmpresa.Empleados (DNI ,NSS ,Nombre ,Apellidos ,Direccion ,Telefono ,isCoordinador ,Departamento) 
	values ("00100200Q", "11211311-M", "Juan", "Pancetas", "Pol, Plaza","88554466", false, 2);
insert into OrganigramaEmpresa.Empleados (DNI ,NSS ,Nombre ,Apellidos ,Direccion ,Telefono ,isCoordinador ,Departamento) 
	values ("00200300W", "777456789-M", "Kiko", "Rivera", "Calle Vago","45561230", false, 5);
insert into OrganigramaEmpresa.Empleados (DNI ,NSS ,Nombre ,Apellidos ,Direccion ,Telefono ,isCoordinador ,Departamento) 
	values ("00400550D", "30523230-T", "Belen", "Esteban", "Calle Andrea Mato","66666600", false, 3);
insert into OrganigramaEmpresa.Empleados (DNI ,NSS ,Nombre ,Apellidos ,Direccion ,Telefono ,isCoordinador ,Departamento) 
	values ("22554466H", "123456799-F", "Falete", "Falsete", "Calle Cantante","66664586", false, 4);
insert into OrganigramaEmpresa.Empleados (DNI ,NSS ,Nombre ,Apellidos ,Direccion ,Telefono ,isCoordinador ,Departamento) 
	values ("20054466F", "100456789-M", "Concha", "Velasco", "Calle Loncha Velasco","702547789", false, 2);
insert into OrganigramaEmpresa.Empleados (DNI ,NSS ,Nombre ,Apellidos ,Direccion ,Telefono ,isCoordinador ,Departamento) 
	values ("44454466F", "123456789-L", "Picolo", "Junior", "Calle La Namek","99999901", false, 1);
insert into OrganigramaEmpresa.Empleados (DNI ,NSS ,Nombre ,Apellidos ,Direccion ,Telefono ,isCoordinador ,Departamento) 
	values ("22554406G", "123701789-G", "Matias", "Cañas", "Calle Fisrt Dates","745841666", false, 2);
insert into OrganigramaEmpresa.Empleados (DNI ,NSS ,Nombre ,Apellidos ,Direccion ,Telefono ,isCoordinador ,Departamento) 
	values ("258134785C", "14785420-J", "King", "Kong", "Calle Estrellado","00000000", false, 1);
insert into OrganigramaEmpresa.Empleados (DNI ,NSS ,Nombre ,Apellidos ,Direccion ,Telefono ,isCoordinador ,Departamento) 
	values ("35801296S", "12391234-M", "Fantasma", "Casper", "Casa Embrujada","666999666", false, 5);
insert into OrganigramaEmpresa.Empleados (DNI ,NSS ,Nombre ,Apellidos ,Direccion ,Telefono ,isCoordinador ,Departamento) 
	values ("87788711Y", "32101234-O", "Canijo", "De Jerez", "Aire de la Calle","790124458", false, 3);
insert into OrganigramaEmpresa.Empleados (DNI ,NSS ,Nombre ,Apellidos ,Direccion ,Telefono ,isCoordinador ,Departamento) 
	values ("58852545Ñ", "01001001-U", "Jagger", "Meister", "Calle Alcoholica","00666666", true, 1);
insert into OrganigramaEmpresa.Empleados (DNI ,NSS ,Nombre ,Apellidos ,Direccion ,Telefono ,isCoordinador ,Departamento) 
	values ("25937804G", "14587166-M", "Tomas", "Cañas", "Calle Carrera","11666666", true, 1);
    
insert into OrganigramaEmpresa.Contrato (Fecha_ini, Fecha_fin, NumEmpleado, NumCategoria) 
	values ("2007-05-11", null, 1, 1);
insert into OrganigramaEmpresa.Contrato (Fecha_ini, Fecha_fin, NumEmpleado, NumCategoria) 
	values ("2014-07-01", "2022-01-11", 2, 1);
insert into OrganigramaEmpresa.Contrato (Fecha_ini, Fecha_fin, NumEmpleado, NumCategoria) 
	values ("2016-11-21", "2021-01-11", 3, 2);
insert into OrganigramaEmpresa.Contrato (Fecha_ini, Fecha_fin, NumEmpleado, NumCategoria) 
	values ("2017-06-11", null, 4, 4);
insert into OrganigramaEmpresa.Contrato (Fecha_ini, Fecha_fin, NumEmpleado, NumCategoria) 
	values ("2018-05-11", null, 5, 4);
insert into OrganigramaEmpresa.Contrato (Fecha_ini, Fecha_fin, NumEmpleado, NumCategoria) 
	values ("2020-12-20", "2022-03-11", 6, 5);
insert into OrganigramaEmpresa.Contrato (Fecha_ini, Fecha_fin, NumEmpleado, NumCategoria) 
	values ("2019-05-17", null, 7, 3);
insert into OrganigramaEmpresa.Contrato (Fecha_ini, Fecha_fin, NumEmpleado, NumCategoria) 
	values ("2020-05-11", "2022-01-29", 8, 3);
insert into OrganigramaEmpresa.Contrato (Fecha_ini, Fecha_fin, NumEmpleado, NumCategoria) 
	values ("2021-05-20", null, 9, 3);
insert into OrganigramaEmpresa.Contrato (Fecha_ini, Fecha_fin, NumEmpleado, NumCategoria) 
	values ("2018-05-21", null, 10, 5);
insert into OrganigramaEmpresa.Contrato (Fecha_ini, Fecha_fin, NumEmpleado, NumCategoria) 
	values ("2019-09-11", null, 11, 6);
insert into OrganigramaEmpresa.Contrato (Fecha_ini, Fecha_fin, NumEmpleado, NumCategoria) 
	values ("2017-05-11", "2020-01-11", 12, 6);
insert into OrganigramaEmpresa.Contrato (Fecha_ini, Fecha_fin, NumEmpleado, NumCategoria) 
	values ("2019-10-11", null, 13, 1);
insert into OrganigramaEmpresa.Contrato (Fecha_ini, Fecha_fin, NumEmpleado, NumCategoria) 
	values ("2010-05-11", "2013-08-13", 14, 4);
insert into OrganigramaEmpresa.Contrato (Fecha_ini, Fecha_fin, NumEmpleado, NumCategoria) 
	values ("2020-05-11", null, 15, 3);
insert into OrganigramaEmpresa.Contrato (Fecha_ini, Fecha_fin, NumEmpleado, NumCategoria) 
	values ("2017-05-11", null, 16, 3);


insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (12000, "empleado 1 desde 2007", 1);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (10011, "empleado 2 desde 2014", 2);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (10011, "empleado 2 desde 2014", 2);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (10011, "empleado 2 desde 2014", 2);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (10011, "empleado 2 desde 2014", 2);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (10011, "empleado 2 desde 2014", 2);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (10011, "empleado 2 desde 2014", 2);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (10011, "empleado 2 desde 2014", 2);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (3000, "empleado 2 desde 2014", 2);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (14025, "empleado 3 desde 2016", 3);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (14025, "empleado 3 desde 2016", 3);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (14025, "empleado 3 desde 2016", 3);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (14025, "empleado 3 desde 2016", 3);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (14025, "empleado 3 desde 2016", 3);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (2570, "empleado 3 desde 2016", 3);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (21005, "empleado 4 desde 2017", 4);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (21005, "empleado 4 desde 2017", 4);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (21005, "empleado 4 desde 2017", 4);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (21005, "empleado 4 desde 2017", 4);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (21005, "empleado 4 desde 2017", 4);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (10114, "empleado 5 desde 2018", 5);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (10114, "empleado 5 desde 2018", 5);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (10114, "empleado 5 desde 2018", 5);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (70504, "empleado 5 desde 2018", 5);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (13150, "empleado 6 desde 2020", 6);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (13150, "empleado 6 desde 2020", 6);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (1058, "empleado 6 desde 2020", 6);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (16150, "empleado 7 desde 2019", 7);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (16150, "empleado 7 desde 2019", 7);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (9050, "empleado 7 desde 2019", 7);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (16000, "empleado 8 desde 2020", 8);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (16000, "empleado 8 desde 2020", 8);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (17400, "empleado 9 desde 2021", 9);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (5120, "empleado 9 desde 2021", 9);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (13003, "empleado 10 desde 2018", 10);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (13003, "empleado 10 desde 2018", 10);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (13003, "empleado 10 desde 2018", 10);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (2000, "empleado 10 desde 2018", 10);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (15003, "empleado 11 desde 2019", 11);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (15003, "empleado 11 desde 2019", 11);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (2050, "empleado 11 desde 2019", 11);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (7800, "empleado 12 desde 2017", 12);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (1200, "empleado 12 desde 2017", 12);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (9899, "empleado 13 desde 2019", 13);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (9899, "empleado 13 desde 2019", 13);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (1033, "empleado 13 desde 2019", 13);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (10111, "empleado 14 desde 2010", 14);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (10111, "empleado 14 desde 2010", 14);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (14000, "empleado 14 desde 2010", 14);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (16111, "empleado 15 desde 2020", 15);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (16111, "empleado 15 desde 2020", 15);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (103, "empleado 15 desde 2020", 15);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (13010, "empleado 16 desde 2017", 16);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (13010, "empleado 16 desde 2017", 16);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (13010, "empleado 16 desde 2017", 16);
insert into OrganigramaEmpresa.Nominas (Sueldo, Detalles, NumContrato) 
	values (10102, "empleado 16 desde 2017", 16);
SET foreign_key_checks = 1;







