with_mock_dir("t/supsts", {
  test_that("`ps_supported_states()` works", {
    expect_s3_class(ps_supported_states(), "data.frame")
  })
})
