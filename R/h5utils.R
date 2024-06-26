#' Read data from an HDF5 file "with caution"
#'
#' @description
#' This is a simple wrapper to [rhdf5::h5read()] which returns a default value
#' if the "data element" (specified by `name`) does not exists within `file`.
#' We use this file to read from ARCHS4 hdf5 files when we want to provide a
#' little insurance to the evolving nature of their data formats.
#'
#' For instance this function is used when we try to read something like
#' `"meta/reads_aligned"` because this information was not provided in earlier
#' versions of these datasets, however `"meta/genes"` may use [rhdf5::h5read()]
#' directly because this has been around since "the beginning"
#'
#' @importFrom rhdf5 h5read
#' @param default_value the default value to return if the entry isn't found,
#'   (Default: `NA`).
#' @param default_dim number of dimensions the result is expected to have,
#'   (Default: `1`).
.h5read <- function(file, name, index = NULL, start = NULL, stride = NULL,
                    block = NULL, count = NULL, compoundAsDataFrame = TRUE,
                    callGeneric = TRUE, read.attributes = FALSE, drop = FALSE,
                    ..., native = FALSE, s3 = FALSE, s3credentials = NULL,
                    default_value = NA, default_dim = 1L) {
  out <- try({
    rhdf5::h5read(file = file, name = name, index = index, start = start,
                  stride = stride, block = block, count = count,
                  compoundAsDataFrame = compoundAsDataFrame,
                  callGeneric = callGeneric, read.attributes = read.attributes,
                  drop = drop, ..., native = native, s3 = s3,
                  s3credentials = s3credentials)
  }, silent = TRUE)
  if (is(out, "try-error")) {
    ndim <- length(default_dim)
    if (ndim == 1L) {
      out <- rep(default_value, default_dim)
    } else {
      out <- array(default_value, default_dim)
    }
  }

  if (is.null(dim(out)) || length(dim(out)) == 1L) {
    na.it <- out %in% c("na", "NA", "null", "NULL")
    out[na.it] <- NA
  }

  out
}
