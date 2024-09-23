# from https://github.com/r-lib/roxygen2/blob/9652d15221109917d46768e836eaf55e33c21633/R/utils.R#L52-L62
nice_name <- function(x) {
  # TODO: replace with Reduce()
  for (i in seq_len(nrow(subs()))) {
    x <- stri_replace_all_fixed(x, subs()[i, 1], subs()[i, 2])
  }

  # Clean up any remaining
  x <- str_replace_all(x, "[^A-Za-z0-9_.-]+", "-")
  x <- str_replace_all(x, "-+", "-")
  x <- str_replace_all(x, "^-|-$", "")
  x <- str_replace_all(x, "^\\.", "dot-")
  x
}

str_replace_all <- function(x, pattern, replacement) {
  gsub(pattern, replacement, x)
}

stri_replace_all_fixed <- function(x, pattern, replacement) {
  gsub(pattern, replacement, x, fixed = TRUE)
}

# from https://github.com/r-lib/roxygen2/blob/9652d15221109917d46768e836eaf55e33c21633/R/utils.R#L12-L50
subs <- function() {

  subs <- matrix(ncol = 2, byrow = T, c(
    # Common special function names
    '[<-', 'subset',
    '[', 'sub',
    '<-', 'set',

    # Infix verbs
    '!', 'not',
    '&', 'and',
    '|', 'or',
    '*', 'times',
    '+', 'plus',
    '^', 'pow',

    # Others
    '"', 'quote',
    '#', 'hash',
    '$', 'cash',
    '%', 'grapes',
    "'", 'single-quote',
    '(', 'open-paren',
    ')', 'close-paren',
    ':', 'colon',
    ';', 'semi-colon',
    '<', 'less-than',
    '==', 'equals',
    '=', 'equals',
    '>', 'greater-than',
    '?', 'help',
    '@', 'at',
    ']', 'close-brace',
    '\\', 'backslash',
    '/', 'slash',
    '`', 'tick',
    '{', 'open-curly',
    '}', 'close',
    '~', 'twiddle'
  ))
  subs[, 2] <- paste0("-", subs[, 2], "-")
  subs
}
