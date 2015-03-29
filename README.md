# dev-sea-el — devtools CLI

`dv` is a command line tool for accessing some functionality (mainly checks,
builds, tests and packaging) from Hadley Wickham's terrific
[devtools](https://github.com/hadley/devtools) package.

Here's the basic functionality (so far):

    dv -h
    dv - command line devtools

    Usage:
      dv create <path> [--check --no-rstudio]
      dv test [<pkg>]
      dv install [<pkg>]
      dv build [<pkg>]
      dv check  [<pkg>] [--no-cran --no-cleanup --no-document]
      dv examples [<pkg>]
      dv check_doc  [<pkg>]
      dv -h | --help
      dv --version

    Options:
      -h --help           show this screen
      --version           show version
      -c, --check         automatically run check
      -C, --no-check      don't run check
      -R, --no-rstudio    don't create RStudio project file
      -R, --no-cran       don't use the same settings as CRAN during check
      -L, --no-cleanup    don't remove the check directory if successful
      -D, --no-document   don't update and check documentation

## Installation

You could install this to your `/usr/local/bin` (be sure to remove `.R`
extension and `chmod 755 dv`), or use aliases to the script as cloned from
Github. In my `~/.zshrc`, I have:

    alias dv="Rscript /Users/vinceb/Projects/dvtools/dv.R"

Please feel free to contribute! The License is GPL 2, following `devtools`.
Also, I intentionally didn't include `release()`, because I was concerned a bug
in `dv` may lead to packages being inappropriately sent to CRAN. My
handwriting is terrible, so I also can't provide Hadley's awesome
[guarantee](https://github.com/hadley/devtools/blob/master/man/release.Rd#L44).


