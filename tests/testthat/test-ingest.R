test_that("`ps_ingest()` works", {
  url <- 'https://planscore.s3.amazonaws.com/uploads/20221127T213653.168557156Z/index.json'
  out <- ps_ingest(url)
  expect_s3_class(out, "data.frame")
})
