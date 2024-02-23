# #' Capture PlanScore Graphs
# #'
# #' @param link plan_url output from `ps_upload()` functions
# #' @param path path to save copy of graphs in, likely ending in `.png`
# #'
# #' @return path to screenshot
# #' @export
# #'
# #' @concept results
# #'
# #' @examples
# #' \donttest{
# #' # often times out
# #' url <- 'https://planscore.org/plan.html?20221127T213653.168557156Z'
# #' tf <- tempfile(fileext = '.png')
# #' ps_capture(url, path = tf)
# #' }
# ps_capture <- function(link, path) {
#   if (missing(link)) {
#     cli::cli_abort('{.arg link} is required.')
#   }
#
#   if (is.list(link) && 'plan_url' %in% names(link)) {
#     link <- link[['plan_url']]
#   }
#
#   if (missing(path)) {
#     cli::cli_abort('{.arg path} is required.')
#   }
#
#   webshot2::webshot(url = link, file = path)
#   # must close the supervisor on non-windows, doesn't close by default
#   if (Sys.info()[["sysname"]] != "Windows") {
#     processx::supervisor_kill()
#   }
#   path
# }
