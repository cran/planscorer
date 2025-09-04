test_that("`ps_save()` works", {
  url <- 'https://planscore.s3.amazonaws.com/uploads/20221127T213653.168557156Z/index.json'
  tf <- tempfile(fileext = '.json')

  out <- NULL
  try({ # relies on internet resource
    out <- ps_save(url, tf)
  })

  testthat::skip_if(is.null(out), "ps_save() internet resource failed.")
  expect_true(file.exists(tf))
})
