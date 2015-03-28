#!/usr/bin/Rscript
## dv.R -- command line devtools wrapper
VERSION <- "0.01"
quiet <- suppressPackageStartupMessages
quiet(library(docopt))


# there's two ways we could go about mapping arugments/options to devtools:
# actually parsing the function formals and converting these automatically to
# arguments (e.g. based on default value type) or manually. I chose manually
# here, as only a few of devtools functions' arguments make sense from CL
# perspective.
#
# docopt has no subcommand/option hierarchy, which makes things a bit less
# safe...  but so far, these are only logical args (and package), so that makes
# it easier.

"dv - command line devtools

Usage:
  dv create <pkg> [--check --no-rstudio]
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
" -> doc

#' Processing named arguments list, handling logicals e.g. turn
#' --no-check-version into negated check_version
process_args <- function(fun, args) {
  # remove --[no-]?
  fmls <- formals(fun)
  #fmls <- fmls[sapply(fmls, is.logical)] # only handle logical
  # formals 'form' with TRUE value have argumen --no-form, so look for that
  sargs <- Map(function(n, v) {
    if (!is.logical(v)) return(v) # don't process non-logicals here
    argname <- if (v) paste0("--no-", n) else paste0("--", n)
    # don't mess with any arguments not set
    if (!(argname %in% names(args))) return(NULL)
    arg_val <- args[[argname]] 
    if (is.null(arg_val)) return(NULL)
    val <- if (v) !arg_val else arg_val
    val
  }, names(fmls), fmls)
  # drop ... from args
  nodots <- sargs[setdiff(names(sargs), "...")]
  nodots[!sapply(nodots, is.null)] # drop all nulls (revert to fun default)
}

build_call <- function(args) {
  quiet(library(devtools))
  # currently supported sub commands
  dv_funs <- list(create=create,
                  test=test,
                  install=install,
                  build=build,
                  check=check,
                  examples=run_examples,
                  check_doc=check_doc)

  fun_i <- which(unlist(args[names(dv_funs)]))
  fun <- dv_funs[[fun_i]]
  do.call(fun, process_args(fun, args))
}

main <- function(args) {
  if (args[['--version']]) {
    cat("version: %s\n\n", VERSION)
  } else {
    build_call(args)
  }
}

if (!interactive())
  main(docopt(doc))






