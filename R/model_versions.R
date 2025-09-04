#' List Model Versions
#'
#' @return tibble of model versions
#' @export
#'
#' @concept info
#'
#' @examples
#' ps_model_versions()
ps_model_versions <- function() {
  httr2::request('https://api.planscore.org/model_versions') |>
    httr2::req_perform() |>
    httr2::resp_body_json() |>
    lapply(function(y) dplyr::bind_cols(y, .name_repair = ~ c('id', 'description'))) |>
    dplyr::bind_rows()
}
