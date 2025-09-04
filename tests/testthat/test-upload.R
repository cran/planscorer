with_mock_dir("t/upload_f", {
  test_that("`ps_upload_file()` works", {
    file <- system.file('extdata/null-plan-incumbency.geojson', package = 'planscorer')
    out <- ps_upload_file(file)
    expect_length(out, 2)
    expect_equal(class(out), 'list')
    expect_in(names(out), c('index_url', 'plan_url'))
  })
})
