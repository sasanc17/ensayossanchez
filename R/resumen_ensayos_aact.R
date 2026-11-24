
#' Resumen de ensayos clínicos por fase en AACT (ClinicalTrials.gov)
#'
#' Conecta de forma remota al servidor PostgreSQL de AACT usando las
#' credenciales almacenadas en .Renviron, filtra los ensayos por patología
#' y devuelve el número de estudios y el reclutamiento medio por fase.
#'
#' @param patologia Texto de búsqueda de la enfermedad (ej. "Melanoma").
#'
#' @return Un data.frame con el número de ensayos y tamaño muestral medio.
#' @export
#'
#' @examples
#' \dontrun{
#' resumen_ensayos_aact("Melanoma")
#' }
resumen_ensayos_aact <- function(patologia = "Melanoma") {

  usuario <- Sys.getenv("AACT_USER")
  clave <- Sys.getenv("AACT_PASSWORD")

  if (usuario == "" || clave == "") {
    stop("Configura AACT_USER y AACT_PASSWORD en tu archivo .Renviron.")
  }

  con <- DBI::dbConnect(
    RPostgres::Postgres(),
    dbname = "aact",
    host = "aact-db.ctti-clinicaltrials.org",
    port = 5432,
    user = usuario,
    password = clave
  )

  on.exit(DBI::dbDisconnect(con), add = TRUE)

  consulta_sql <- "
    SELECT
      COALESCE(s.phase, 'No especificada') AS fase_clinica,
      COUNT(DISTINCT s.nct_id) AS num_ensayos,
      ROUND(AVG(s.enrollment), 1) AS reclutamiento_medio
    FROM ctgov.studies s
    INNER JOIN ctgov.conditions c
      ON s.nct_id = c.nct_id
    WHERE LOWER(c.name) LIKE LOWER($1)
      AND s.enrollment IS NOT NULL
    GROUP BY s.phase
    ORDER BY num_ensayos DESC;
  "

  DBI::dbGetQuery(
    con,
    consulta_sql,
    params = list(paste0("%", patologia, "%"))
  )
}
