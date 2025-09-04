function(resp) {
  resp |>
    # shorten url
    httptest2::gsub_response(pattern = 'api.planscore.org/', '') |>
    # redact key
    httptest2::gsub_response(pattern = planscorer::ps_get_key(), '')
}
