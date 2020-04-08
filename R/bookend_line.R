#' Internal function for formatting a line with characters on left and right sides.
#'
#' @param x character string.
#' @param linewidth Intended maximum number of characters per line.
#' @param type Two options:
#' \itemize{
#' \item{\code{basic}: Simple format with \code{#} box at the beginning.}
#' \item{\code{roxygen2}: Format consistent with package builder \code{roxygen2}.}}
#' @return Character string of length 80.
#' @export
#' @examples
#' bookend_line("abcde",linewidth = 10,type = "basic")
#' bookend_line("abcde",linewidth = 10,type = "roxygen2")
bookend_line <- function(x,linewidth = 80,type = c("basic","roxygen2")){
  n_chars <- nchar(x)
  if(n_chars>linewidth-2){
    stop("Line too large. Number of characters must not exceed linewidth-2.")
  }
  n_spaces <- linewidth - n_chars- 2
  if(type == "basic"){
    return(
      paste0("#",x,strrep(" ",n_spaces),"#\n")
    )}else{
      if(type == "roxygen2"){
        return(
          paste0("#' ",x,"\n")
        )}
    }
}
