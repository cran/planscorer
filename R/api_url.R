api_url <- function(temporary = TRUE) {
  if (temporary) {
    'https://api.planscore.org/upload/temporary'
  } else {
    'https://api.planscore.org/upload'
  }
}
