#' List Currently Supported States
#'
#' @return tibble of supported states
#' @export
#'
#' @concept info
#'
#' @examples
#' ps_supported_states()
ps_supported_states <- function() {
  httr2::request('https://api.planscore.org/states') |>
    httr2::req_perform() |>
    httr2::resp_body_json() |>
    lapply(function(y) dplyr::bind_cols(y, .name_repair = ~ c('state', 'type'))) |>
    dplyr::bind_rows()
}
