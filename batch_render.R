crops <- c("Common bean", "Finger millet", "Wheat", "Soybean")

purrr::walk(
  crops,
  function(x) {
    rmarkdown::render(
      input = "report.Rmd",
      output_file = glue::glue("report-{x}.docx"),
      params = list(crop = x)
    )
  }
)
