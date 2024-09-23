
<!-- README.md is generated from README.Rmd. Please edit that file -->

# devtag

{devtag} allows you to use `@dev` tags in your roxygen2 headers so
you’ll generate help files for unexported objects, that you will enjoy
during development but won’t be accessible for users that install your
package.

This is done by adding the relevant help files to “.Rbuildignore” when
documenting the package with {roxygen2} (usually through
`devtools::document()`)

These files are not git ignored so they are version-controlled and
shared with contributors of your repo.

## Installation

Install with

``` r
pak::pak("moodymudskipper/devtag")
```

## How to use

To use {devtag} :

1)  Use “@dev” for unexported functions where you would have used
    “@export” for exported functions. Do not use “@rdname”.

2)  Run `devtag::use_devtag()` in your package folder. This will amend
    the `DESCRIPTION` to activate devtag usage.

3)  That’s it! Note that to check that it works you’ll need to use
    `devtools::install()`, clicking the *Install* button in the build
    pane will still install the build ignored help files with the
    package (not really a bad thing on your machine anyway).

## Example package

We set up the package {devtag.example} as an example. You can check the
code at <https://github.com/moodymudskipper/devtag.example>

If you install it you won’t be able to see the help file for the
`subtract()` function, but if you clone it and use a {devtools} workflow
you will had access to it.

## Comparison to `@noRd` and `@keywords internal`

- `@noRd` doesn’t produce help files, it basically makes your roxygen2
  blocks regular comments that look like regular documentation
- `@keywords internal` removes help files from the index but they are
  still accessible by users
