# nocov start

# not sure if even needed

#' @export
#' @importFrom roxygen2 roxy_tag_parse
roxy_tag_parse.roxy_tag_dev <- function(x) {
  roxygen2::tag_words_line(x)
}

#' @export
#' @importFrom roxygen2 roclet
dev_roclet <- function() {
  roclet("dev")
}

#' @export
#' @importFrom roxygen2 block_get_tags roclet_process
#' @method roclet_process roclet_dev
roclet_process.roclet_dev <- function(x, blocks, env, base_path) {
  blocks
}

#' @export
#' @importFrom roxygen2 block_get_tags roclet_output
roclet_output.roclet_dev <- function(x, results, base_path, ...) {
  blocks <- results
  dev_blocks <- Filter(block_has_dev, blocks)
  dev_topics <- sapply(dev_blocks, function(x) x$object$topic)
  dev_files <- if (length(dev_topics)) file.path("^man", paste0(dev_topics, "\\.Rd$"))
  ignored <- readLines(".Rbuildignore")
  ignored <- grep("^\\^man/.*\\.Rd\\$$", ignored, invert = TRUE, value = TRUE)
  writeLines(c(ignored, dev_files), ".Rbuildignore")
}

block_has_dev <- function(x) {
  "dev" %in% sapply(x$tags, function(x) x[["tag"]])
}

# nocov end
