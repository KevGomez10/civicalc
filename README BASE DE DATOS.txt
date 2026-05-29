# README - CiviCalc

## Requisitos

Instalar:

* Flutter SDK
* Visual Studio Code
* XAMPP
* PHP
* MySQL

---

## Configuración de XAMPP

Iniciar:

* Apache
* MySQL

---

## Creación de la Base de Datos

Abrir phpMyAdmin y ejecutar:

```sql
CREATE DATABASE civicalc_db;
USE civicalc_db;
```

---

## Crear Tabla Usuarios

```sql
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    empresa VARCHAR(100) NOT NULL,
    proyecto VARCHAR(100) NOT NULL,
    usuario VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);
```

---

## Crear Tabla Ensayos

```sql
CREATE TABLE ensayos_cono_arena (
    id INT AUTO_INCREMENT PRIMARY KEY,

    usuario_id INT NOT NULL,

    abscisa VARCHAR(50),
    capa VARCHAR(50),
    costado VARCHAR(50),

    peso_inicial DOUBLE,
    peso_final DOUBLE,

    constante_cono DOUBLE,
    densidad_arena DOUBLE,

    peso_humedo DOUBLE,
    humedad DOUBLE,

    arena_usada DOUBLE,
    arena_hueco DOUBLE,

    volumen DOUBLE,
    densidad DOUBLE,

    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (usuario_id)
    REFERENCES usuarios(id)
    ON DELETE CASCADE
);
```

---

## Si la Tabla ya Existía

Si alguien tiene una versión antigua del proyecto sin el campo `usuario_id`, ejecutar:

```sql
ALTER TABLE ensayos_cono_arena
ADD COLUMN usuario_id INT NOT NULL;
```

Luego crear la relación:

```sql
ALTER TABLE ensayos_cono_arena
ADD CONSTRAINT fk_usuario
FOREIGN KEY (usuario_id)
REFERENCES usuarios(id)
ON DELETE CASCADE;
```

---

## Verificación

Verificar que las tablas existen:

```sql
SHOW TABLES;
```

Consultar usuarios:

```sql
SELECT * FROM usuarios;
```

Consultar ensayos:

```sql
SELECT * FROM ensayos_cono_arena;
```

---

## Configuración de la API

Copiar la carpeta:

```text
civicalc_api
```

a:

```text
xampp/htdocs/civicalc_api
```

La estructura debe quedar:

```text
xampp
└── htdocs
    └── civicalc_api
```

Archivos requeridos:

* conexion.php
* login.php
* registrar_usuario.php
* guardar_ensayo.php
* listar_ensayos.php
* eliminar_ensayo.php

---

## Configuración de la Conexión

Revisar `conexion.php`:

```php
$host = "localhost";
$user = "root";
$password = "";
$database = "civicalc_db";
```

Modificar según la configuración del equipo.

---

## Ejecución

Instalar dependencias:

```bash
flutter pub get
```

Ejecutar:

```bash
flutter run
```

---

## Funcionalidades

* Registro de usuarios.
* Inicio de sesión.
* Cierre de sesión.
* Cálculo de ensayo de Cono de Arena.
* Guardado de resultados en MySQL.
* Historial independiente por usuario.
* Eliminación de ensayos.
* Modo oscuro.
* Diseño responsive.

---

## Notas Importantes

* Apache y MySQL deben estar activos antes de ejecutar la aplicación.
* La carpeta `civicalc_api` debe estar dentro de `htdocs`.
* Cada usuario solo puede visualizar sus propios ensayos.
* Si se cambia el nombre de la base de datos, debe modificarse `conexion.php`.
* Se recomienda probar el sistema con al menos dos usuarios diferentes para verificar la separación del historial.

```
```
