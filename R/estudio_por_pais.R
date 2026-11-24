
#' Analiza los ensayos clínicos por país
#'
#' Calcula el número de ensayos clínicos realizados
#' en cada país, desglosados según su estado.
#'
#' @param con Conexión activa a la base de datos.
#'
#' @return Un data.frame con el país, el estado
#' de los ensayos y el número de estudios.
#'
#' @export

estudios_por_pais <- function(con) {

  consulta <- "
    SELECT
      l.country AS pais,
      s.overall_status AS estado,
      COUNT(DISTINCT s.nct_id) AS numero_estudios

    FROM ctgov.studies AS s

    INNER JOIN ctgov.locations AS l
      ON s.nct_id = l.nct_id

    GROUP BY
      l.country,
      s.overall_status

    ORDER BY
      numero_estudios DESC
  "

  resultado <- DBI::dbGetQuery(con, consulta)

  return(resultado)
}
