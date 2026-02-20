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

  if (length(dev_topics) == 0) {
    return(invisible())
  }

  # .Rbuildignore
  current_ignored <- readLines(file.path(base_path, ".Rbuildignore"))
  dev_files <- unique(file.path(
    "^man",
    paste0(nice_name(dev_topics), "\\.Rd$")
  ))
  ignored <- grep(
    "^\\^man/.*\\.Rd\\$$",
    current_ignored,
    invert = TRUE,
    value = TRUE
  )
  if (length(ignored) == 0) {
    writeLines(c(ignored, dev_files), file.path(base_path, ".Rbuildignore"))
  }

  ## \keyword{internal}
  lapply(dev_topics, add_keyword_internal, base_path = base_path)
}

block_has_dev <- function(x) {
  "dev" %in% sapply(x$tags, function(x) x[["tag"]])
}

add_keyword_internal <- function(topic, base_path) {
  path <- file.path(base_path, "man", paste0(nice_name(topic), ".Rd"))
  lines <- readLines(path)
  lines <- c(lines, "\\keyword{internal}")
  writeLines(lines, path)
}

# nocov end
