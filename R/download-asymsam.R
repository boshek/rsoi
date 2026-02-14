#' @export
#' @title Download Asymmetric and Symmetric SAM indices
#'
#' @description
#' \strong{Deprecated.} The upstream API for the Asymmetric and Symmetric SAM
#' indices is no longer available. These functions now return \code{NULL} with a
#' warning.
#'
#' @inheritParams download_oni
#' @return \code{NULL} (invisibly). A warning is issued.
#'
#' @examples
#' \dontrun{
#' asymsam <- download_asymsam_monthly()
#' }
#'
#' @references Campitelli, E., Diaz, L. B., & Vera, C. (2022). Assessment of zonally symmetric and asymmetric components of the Southern Annular Mode using a novel approach. Climate Dynamics, 58(1), 161-178. \url{https://doi.org/10.1007/s00382-021-05896-5}
download_asymsam_monthly <- function(use_cache = FALSE, file = NULL) {
  warning("`download_asymsam_monthly()` is deprecated. The upstream API (https://www.cima.fcen.uba.ar/~elio.campitelli/asymsam/) is no longer available.",
          call. = FALSE)
  invisible(NULL)
}

#' @export
#' @rdname download_asymsam_monthly
download_asymsam_daily <- function(levels = 700, use_cache = FALSE, file = NULL) {
  warning("`download_asymsam_daily()` is deprecated. The upstream API (https://www.cima.fcen.uba.ar/~elio.campitelli/asymsam/) is no longer available.",
          call. = FALSE)
  invisible(NULL)
}
