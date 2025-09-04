#' Ingest PlanScore Output
#'
#' @param link index url output from `ps_upload()` functions
#'
#' @return `tibble` with district and plan level data
#' @export
#'
#' @concept results
#'
#' @examples
#' url <- 'https://planscore.s3.amazonaws.com/uploads/20221127T213653.168557156Z/index.json'
#' ps_ingest(url)
ps_ingest <- function(link) {
  if (missing(link)) {
    cli::cli_abort('{.arg link} is required.')
  }

  if (is.list(link) && 'index_url' %in% names(link)) {
    link <- link[['index_url']]
  }

  if (fs::path_ext(link) == 'json') {
    j <- jsonlite::read_json(link)

    totals <- lapply(j$districts, \(x) purrr::pluck(x, 'totals')) |>
      dplyr::bind_rows(.id = 'district') |>
      dplyr::rename_with(
        .fn = function(x) {
          x |>
            stringr::str_to_lower() |>
            stringr::str_replace_all(' ', '_') |>
            stringr::str_replace_all('\\+|,|\\-|\\)|\\(|\'', '') |>
            stringr::str_replace_all('__', '_')
        }
      )

    compactness <- lapply(j$districts, \(x) purrr::pluck(x, 'compactness')) |>
      dplyr::bind_rows(.id = 'district') |>
      dplyr::rename_with(
        .fn = function(x) {
          x |>
            stringr::str_to_lower() |>
            stringr::str_replace_all('-', '_')
        }
      )


    incumbents <- tibble::tibble(incumbents = unlist(j$incumbents)) |>
      dplyr::mutate(district = dplyr::row_number(), .before = 'incumbents')

    summ <- j$summary |>
      tibble::enframe() |>
      tidyr::unnest('value') |>
      tidyr::pivot_wider() |>
      dplyr::rename_with(
        .fn = function(x) {
          x |>
            stringr::str_to_lower() |>
            stringr::str_replace_all(' ', '_') |>
            stringr::str_replace_all('\\+', '') |>
            stringr::str_replace_all('-', '_')
        }
      )

    details <- Filter(function(x) length(x) == 1, j) |>
      tibble::as_tibble()

    dplyr::left_join(totals, compactness, by = 'district') |>
      dplyr::bind_cols(
        summ, details
      )
  } else {
    readr::read_tsv(link) |>
      suppressMessages() |>
      dplyr::rename_with(
        .fn = function(x) {
          x |>
            stringr::str_to_lower() |>
            stringr::str_replace_all(' ', '_') |>
            stringr::str_replace_all('\\+', '') |>
            stringr::str_replace_all('-', '_') |>
            stringr::str_replace_all(' ', '_') |>
            stringr::str_replace_all('\\+|,|\\-|\\)|\\(|\'', '') |>
            stringr::str_replace_all('___', '_') |>
            stringr::str_replace_all('__', '_')
        }
      )
  }
}
