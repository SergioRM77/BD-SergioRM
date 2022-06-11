/*consultas a mi base de datos Sergio RM*/

/*Cuantas categorias de empleados existen*/
select count(organigramaempresa.categorias.Categoria)
from organigramaempresa.categorias;

/*cuantas personas trabajan con categoria de Comercial*/
select count(organigramaempresa.empleados.id_empleado) Comercial
from organigramaempresa.empleados
	right join organigramaempresa.contrato on organigramaempresa.empleados.id_empleado = organigramaempresa.contrato.NumEmpleado
    right join organigramaempresa.categorias on organigramaempresa.contrato.NumCategoria = organigramaempresa.categorias.id_categoria
where organigramaempresa.categorias.Categoria = "Comercial";

/*cuantas personas trabajan con categoria de Cajero*/
select count(organigramaempresa.empleados.id_empleado) Cajeros
from organigramaempresa.empleados
	right join organigramaempresa.contrato on organigramaempresa.empleados.id_empleado = organigramaempresa.contrato.NumEmpleado
    right join organigramaempresa.categorias on organigramaempresa.contrato.NumCategoria = organigramaempresa.categorias.id_categoria
where organigramaempresa.categorias.Categoria = "Cajero";

/*cuantas personas trabajan con categoria de Oficinista*/
select count(organigramaempresa.empleados.id_empleado) Oficinistas
from organigramaempresa.empleados
	right join organigramaempresa.contrato on organigramaempresa.empleados.id_empleado = organigramaempresa.contrato.NumEmpleado
    right join organigramaempresa.categorias on organigramaempresa.contrato.NumCategoria = organigramaempresa.categorias.id_categoria
where organigramaempresa.categorias.Categoria like "Ofic%";

/*cuantos trabajadores trabajan en departamento de Recursos Humanos*/
select count(organigramaempresa.empleados.id_empleado) RRHH
from organigramaempresa.empleados
	left join organigramaempresa.departamentos on organigramaempresa.empleados.Departamento = organigramaempresa.departamentos.id_departamento
where organigramaempresa.departamentos.Nombre = "RecUrSos hUManos";

/*cuantos trabajadores siguen trabajando a dia de hoy
// lo mismo para los que no trabajan con un 'not' */
select count(organigramaempresa.empleados.id_empleado) TrabajadoresActuales
from organigramaempresa.empleados
	right join organigramaempresa.contrato on organigramaempresa.contrato.NumEmpleado = organigramaempresa.empleados.id_empleado
where organigramaempresa.contrato.Fecha_fin is null;

/*cunatos trabajadores estubieron trabajando entre 2007-2016*/
select count(organigramaempresa.empleados.id_empleado) Desde2007Hasta2016
from organigramaempresa.empleados
	right join organigramaempresa.contrato on organigramaempresa.contrato.NumEmpleado = organigramaempresa.empleados.id_empleado
where organigramaempresa.contrato.Fecha_ini >= "2007-00-00" and organigramaempresa.contrato.Fecha_ini <= "2016-12-31";

/*cuantos empelados tiene cada departamento*/
select count(organigramaempresa.empleados.id_empleado) numEmpleados, organigramaempresa.departamentos.Nombre as Departamento
from organigramaempresa.empleados right join organigramaempresa.departamentos
	on organigramaempresa.empleados.departamento = organigramaempresa.departamentos.id_departamento
group by organigramaempresa.departamentos.Nombre;

/*cuantos empleados por cada categoria*/
select count(organigramaempresa.empleados.id_empleado) NumEmpleados, organigramaempresa.categorias.Categoria as Categoria
from organigramaempresa.empleados 
	right join organigramaempresa.contrato
		on organigramaempresa.empleados.id_empleado = organigramaempresa.contrato.NumEmpleado
	right join organigramaempresa.categorias
		on organigramaempresa.contrato.NumCategoria = organigramaempresa.categorias.id_categoria
group by Categoria
order by Categoria asc;

/*subconsulta de empleados en un departamento Almacén*/
select subConsultaEmpleados.numEmpleados
from 
(
	select count(organigramaempresa.empleados.id_empleado) numEmpleados, organigramaempresa.departamentos.Nombre as Departamento
	from organigramaempresa.empleados right join organigramaempresa.departamentos
		on organigramaempresa.empleados.departamento = organigramaempresa.departamentos.id_departamento
	group by organigramaempresa.departamentos.Nombre
) subConsultaEmpleados

where subConsultaEmpleados.Departamento = "Almacén";


/****************/
/*Dame los trabajadores que estan a cargo del responsable de Almacén*/
	/*uso el ejecutable set para que me devuelva un único valor y asi poder usarlo 
	 *directamente por el nombre en la consulta siguiente */
	
    set @CodIDDepartamento := (
		select organigramaempresa.departamentos.Id_coordinador
		from organigramaempresa.departamentos
		where organigramaempresa.departamentos.Nombre = "Almacén"
	);

select concat(organigramaempresa.empleados.Nombre, ", ", organigramaempresa.empleados.Apellidos) Empleado, organigramaempresa.departamentos.Nombre
	from organigramaempresa.empleados right join organigramaempresa.departamentos
		on organigramaempresa.empleados.Departamento = organigramaempresa.departamentos.id_departamento
where organigramaempresa.departamentos.Id_coordinador = @CodIDDepartamento ;
/***********************/


/*dame todos los trabajadores que su apellido tenga 6 letras o menos*/
select  concat(organigramaempresa.empleados.Nombre, ", ", organigramaempresa.empleados.Apellidos) Empleados, length(organigramaempresa.empleados.Apellidos) numLetrasApellios
from organigramaempresa.empleados
where length(organigramaempresa.empleados.Apellidos)  <= 6;

/*dame los trabajadores que su numero de SS no empiece por 1 y que termine en M*/
select * from organigramaempresa.empleados
where organigramaempresa.empleados.NSS regexp "(.)+?M" and organigramaempresa.empleados.NSS not like "1%";

/*dame los trabajadores que su DNI tenga un 45 o 46*/
select * from organigramaempresa.empleados
where organigramaempresa.empleados.DNI regexp "(.)45(.)" or organigramaempresa.empleados.DNI regexp "(.)45(.)";


/*dame el total y media de sueldo de Toda la Plantilla*/
select sum(organigramaempresa.nominas.Sueldo) total,  avg(organigramaempresa.nominas.Sueldo) mediaTotal
from organigramaempresa.nominas;

/*media de cada empleado al mes (como cada registro es de un año divido entre 12)*/
select concat(organigramaempresa.empleados.Nombre, ", ", organigramaempresa.empleados.Apellidos) Empleados, truncate(avg(organigramaempresa.nominas.Sueldo)/12, 3) mediaMes,
	substring(organigramaempresa.contrato.Fecha_ini,1,4) DesdeAnnio, substring(organigramaempresa.contrato.Fecha_fin,1,4) HastaAnnio
from organigramaempresa.empleados 
	left join organigramaempresa.contrato on organigramaempresa.empleados.id_empleado = organigramaempresa.contrato.NumEmpleado
    left join organigramaempresa.nominas on organigramaempresa.contrato.id_contrato = organigramaempresa.nominas.NumContrato
group by Empleados
order by DesdeAnnio asc;

/*empleados que cobran por encima de la media general*/
select concat(organigramaempresa.empleados.Nombre, ", ", organigramaempresa.empleados.Apellidos) Empleados,  truncate(avg(organigramaempresa.nominas.Sueldo), 3) media
from organigramaempresa.empleados 
	left join organigramaempresa.contrato on organigramaempresa.empleados.id_empleado = organigramaempresa.contrato.NumEmpleado
    left join organigramaempresa.nominas on organigramaempresa.contrato.id_contrato = organigramaempresa.nominas.NumContrato
group by Empleados
having media > (
	select  avg(organigramaempresa.nominas.Sueldo) mediaTotal
	from organigramaempresa.nominas
)
order by Empleados asc;

/*empleados por debajo de la media general en categoria de Cajero*/
/************/
	set @mediaGeneral := (
    select avg(organigramaempresa.nominas.Sueldo) as Media
    from organigramaempresa.nominas
    );
/************/
select  tablaMedias.Empleados,   tablaMedias.media, organigramaempresa.categorias.Categoria categoria
    from (
			select concat(organigramaempresa.empleados.Nombre, ", ", organigramaempresa.empleados.Apellidos) Empleados,  truncate(avg(organigramaempresa.nominas.Sueldo), 3) media, organigramaempresa.empleados
			.id_empleado NumIDEmpleado
			from organigramaempresa.empleados 
				left join organigramaempresa.contrato on organigramaempresa.empleados.id_empleado = organigramaempresa.contrato.NumEmpleado
				left join organigramaempresa.nominas on organigramaempresa.contrato.id_contrato = organigramaempresa.nominas.NumContrato
			group by Empleados
			having media < @mediaGeneral
        ) tablaMedias right join organigramaempresa.contrato
				on tablaMedias.NumIDEmpleado = organigramaempresa.contrato.NumEmpleado
            right join organigramaempresa.categorias
				on  organigramaempresa.categorias.id_categoria = organigramaempresa.contrato.NumCategoria
		group by tablaMedias.Empleados
        having organigramaempresa.categorias.Categoria = "Cajero";
        

/*muestrame los trabajadores que estan a cargo del responsable de Almacén, que sigan trabajando a dia de hoy, con sueldo de media entre 50% y 100% de MediaGeneral*/
/************/
	set @mediaGeneral := (
    select avg(organigramaempresa.nominas.Sueldo) as Media
    from organigramaempresa.nominas
    );
/************/
select Plantilla.Empleados, Plantilla.Responsable, Plantilla.Departamento, Plantilla.SueldoMedia
from (
		select
			concat(organigramaempresa.empleados.Nombre, ", ", organigramaempresa.empleados.Apellidos) Empleados, 
			(
					select concat(organigramaempresa.empleados.Nombre, ", ", organigramaempresa.empleados.Apellidos) Nombre
					from organigramaempresa.empleados right join organigramaempresa.departamentos
						on organigramaempresa.empleados.id_empleado = organigramaempresa.departamentos.Id_coordinador
					where organigramaempresa.departamentos.Nombre = "Almacén"
            ) Responsable,
			organigramaempresa.empleados.id_empleado as CodEmpleado,
			organigramaempresa.departamentos.Nombre as Departamento,
			organigramaempresa.contrato.Fecha_ini as FechaIni,
			organigramaempresa.contrato.Fecha_fin as FechaFin,
            avg(organigramaempresa.nominas.Sueldo) as SueldoMedia
        from organigramaempresa.departamentos right join organigramaempresa.empleados
				on organigramaempresa.departamentos.id_departamento = organigramaempresa.empleados.Departamento
			right join organigramaempresa.contrato
				on organigramaempresa.contrato.NumEmpleado = organigramaempresa.empleados.id_empleado
			left join organigramaempresa.nominas
				on organigramaempresa.contrato.id_contrato = organigramaempresa.nominas.NumContrato
		where organigramaempresa.departamentos.Nombre = "Almacén"
		group by Empleados
) Plantilla
where Plantilla.FechaFin is not null /*en total 4 pero los otros ya no estan contratados*/
	and Plantilla.SueldoMedia between (@mediaGeneral/2) and  @mediaGeneral;/*con esta condición uno de los empleados se quedaría fuera del rango*/


/*ANTES DE BORRAR UN REGISTRO*/
SELECT * FROM organigramaempresa.exempleados; 
/*************DELETE CON TRIGGER***************/
/*Con esto borramos el empleado nº1 y lleva sus datos a tabla de ExEmpleados*/
/*Primero deshabilitamos la comprobación de claves foraneas porque la restriccion nos lo prohibe, despues ejecutamos y por último activamos la restriccion de claves*/
SET foreign_key_checks = 0;
delete from organigramaempresa.empleados where organigramaempresa.empleados.id_empleado = 1;
SET foreign_key_checks = 1;

/*ver tabla de ExEmpleados ahora*/
SELECT * FROM organigramaempresa.exempleados;


		
    
