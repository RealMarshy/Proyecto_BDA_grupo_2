Sistema de Gestión Administrativa para Taller de Reparación de Celulares
========================================================================

Versión: 1.0.0.0  
Lenguaje: C#  
Base de Datos: MySQL 8.0+  
Entorno de desarrollo: Visual Studio 2022  
Framework: .NET 6.0 Desktop

OBJETIVO
--------
Este sistema tiene como finalidad optimizar y automatizar los procesos de un taller de reparación de celulares, brindando funcionalidades clave como:

- Gestión de órdenes de reparación.
- Seguimiento de dispositivos ingresados.
- Administración de clientes.
- Emisión y control de facturación.

REQUISITOS DEL SISTEMA
-----------------------
REQUISITOS MÍNIMOS DEL EQUIPO:
- Sistema Operativo: Windows 10
- Procesador: Intel Core Celeron o superior
- Memoria RAM: 4 GB
- Espacio en disco: 2.2 GB a 5.5 GB

SOFTWARE NECESARIO INSTALADO:
- Visual Studio 2022
- Extensión: Desarrollo de escritorio con .NET
- Extensión: Desarrollo de la interfaz de usuario de aplicaciones (Visual Studio)
- .NET 6.0 Desktop Runtime (v6.0.36)
- MySQL 8.0 o superior
- HeidiSQL (Cliente gráfico para MySQL)

ARQUITECTURA Y COMPONENTES DEL SISTEMA
--------------------------------------
- Modelo: Clases que representan las entidades del sistema (Cliente, Orden, Factura, etc.)
- Vista: Formularios Windows Forms para interacción con el usuario.
- Controlador: Encargado de manejar la lógica de negocio y el flujo del sistema.

FUNCIONALIDADES DESTACADAS
--------------------------
- Login seguro mediante credenciales.
- Registro de órdenes con seguimiento detallado.
- Visualización y edición de datos de clientes.
- Generación automática de facturas.
- Reportes de órdenes y ventas.

CÓMO EJECUTAR EL SISTEMA
-------------------------
1. Clonar el repositorio o descargar el código fuente.
2. Abrir el proyecto en Visual Studio 2022.
3. Asegurarse de tener las extensiones requeridas instaladas.
4. Configurar la cadena de conexión a la base de datos en el archivo de configuración.
5. Ejecutar la migración o importar el archivo SQL de la base de datos.
6. Compilar y ejecutar el sistema.


