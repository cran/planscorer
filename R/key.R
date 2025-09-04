#' Check or Get PlanScore API Key
#'
#' @return logical if `has`, key invisibly if `get`
#' @export
#'
#' @name key
#'
#' @concept key
#'
#' @examples
#' ps_has_key()
ps_has_key <- function() {
  Sys.getenv('PLANSCORE_KEY') != ''
}

#' @rdname key
#' @export
ps_get_key <- function() {
  key <- Sys.getenv('PLANSCORE_KEY')

  # if (key == '') {
  #   cli::cli_abort('Must set a key as {.val PLANSCORE_KEY}.')
  # }
  invisible(key)
}

#' Add Entry to Renviron
#'
#' Adds PlanScore API key to .Renviron.
#'
#' @param key Character. API key to add to add.
#' @param overwrite Defaults to FALSE. Boolean. Should existing `PLANSCORE_KEY` in Renviron be overwritten?
#' @param install Defaults to FALSE. Boolean. Should this be added '~/.Renviron' file?
#'
#' @concept key
#'
#' @return key, invisibly
#' @export
#'
#' @examples
#' \dontrun{
#' set_planscore_key('1234')
#' }
#'
ps_set_key <- function(key, overwrite = FALSE, install = FALSE) {
  if (missing(key)) {
    cli::cli_abort('Input {.arg key} cannot be missing.')
  }
  name <- 'PLANSCORE_KEY'

  key <- list(key)
  names(key) <- name

  if (install) {
    r_env <- file.path(Sys.getenv('HOME'), '.Renviron')

    if (!file.exists(r_env)) {
      file.create(r_env)
    }

    lines <- readLines(r_env)
    newline <- paste0(name, "='", key, "'")

    exists <- stringr::str_detect(lines, paste0(name, '='))

    if (any(exists)) {
      if (sum(exists) > 1) {
        cli::cli_abort(c('Multiple entries in .Renviron found.',
          'i' = 'Edit manually with {.fn usethis::edit_r_environ}.'
        ))
      }

      if (overwrite) {
        lines[exists] <- newline
        writeLines(lines, r_env)
        do.call(Sys.setenv, key)
      } else {
        cli::cli_inform('{.arg PLANSCORE_KEY} already exists in .Renviron.',
          'i' = 'Edit manually with {.fn usethis::edit_r_environ} or set {.code overwrite = TRUE}.'
        )
      }
    } else {
      lines[length(lines) + 1] <- newline
      writeLines(lines, r_env)
      do.call(Sys.setenv, key)
    }
  } else {
    do.call(Sys.setenv, key)
  }

  invisible(key)
}
