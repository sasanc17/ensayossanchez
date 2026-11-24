

# ensayossanchez

## Descripción

Este paquete permite consultar y analizar información de ensayos clínicos
procedente de la base de datos AACT (ClinicalTrials.gov), utilizando
consultas SQL sobre PostgreSQL.

Entre sus funcionalidades se encuentra el análisis del número de ensayos
clínicos por patología, su fase clínica y el reclutamiento medio.

## Instalación

Para instalar el paquete desde GitHub:

```r
# Instalar devtools si todavía no está instalado
install.packages("devtools")

# Instalar el paquete desde GitHub
devtools::install_github("sasanc17/ensayossanchez")
```

Sustituye `TU_USUARIO` por tu nombre de usuario de GitHub.

## Configuración de las credenciales AACT

Para utilizar las funciones que consultan AACT es necesario disponer
de una cuenta y configurar las credenciales de acceso a PostgreSQL.

Las credenciales deben almacenarse en el archivo `.Renviron`,
utilizando las siguientes variables de entorno:

```r
AACT_USER=tu_usuario
AACT_PASSWORD=tu_contraseña
```

El archivo `.Renviron` se puede abrir desde R mediante:

```r
usethis::edit_r_environ()
```

Después de introducir las credenciales, guarda el archivo y reinicia
la sesión de R para que las variables estén disponibles.

**Importante:** no se deben publicar las credenciales en GitHub
ni incluirlas directamente en el código del paquete.

## Bases de datos y tablas consultadas

El paquete utiliza la base de datos AACT, alojada en PostgreSQL,
y consulta las siguientes tablas del esquema `ctgov`:

- `ctgov.studies`: contiene información general de los ensayos clínicos,
  como su identificador, fase, estado y tamaño de reclutamiento.
- `ctgov.conditions`: contiene las patologías o condiciones médicas
  asociadas a cada ensayo clínico.

Ambas tablas se relacionan mediante el identificador `nct_id`.

## Funciones disponibles

### resumen_ensayos_aact()

Permite consultar los ensayos clínicos asociados a una patología
y obtener un resumen según su fase clínica.

Devuelve:

- Fase clínica.
- Número de ensayos.
- Reclutamiento medio.

Ejemplo de uso:

```r
resultado <- resumen_ensayos_aact("Melanoma")
```

## Autoría

Paquete desarrollado como parte de una práctica académica.
