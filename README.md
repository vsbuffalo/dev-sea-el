# dev-sea-el — command line access to devtools

`dv` is a command line tool for accessing some functionality (mainly checks,
builds, tests and packaging) from Hadley Wickham's terrific
[devtools](https://github.com/hadley/devtools) package.

## Installation

You could install this to your `/usr/local/bin` (be sure to remove `.R`
extension and `chmod 755 dv`), or use aliases to the script as cloned from
Github. In my `~/.zshrc`, I have:

    alias dv="Rscript /Users/vinceb/Projects/dvtools/dv.R"

Please feel free to contribute!
