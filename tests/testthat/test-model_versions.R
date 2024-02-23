with_mock_dir("t/mdlvrs", {
  test_that("`ps_model_versions()` works", {
    expect_s3_class(ps_model_versions(), "data.frame")
  })
})
