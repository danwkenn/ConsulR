#' Remove leading and trailing white spaces.
#'
#' @param x String.
#' @return string with no leading or trailing white space.
#' @export
#' @examples
#' strip_white_space("  sdfs adf ")
strip_white_space <- function(x){
  sapply(stringr::str_match_all(string = x,pattern = "^\\s*(.*)\\s*$"),function(x) x[,2])
}
