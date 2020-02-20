#' Format line with space margins.
#'
#' Takes a string and formats it according the disired output type and considering line width and margin concerns. Where necessary, text will be broken up onto multiple lines, with line break escape characters respected.
#' @param x String.
#' @param linewidth Maximum number of characters per line.
#' @param right_margin Number of spaces between the end of text and the maximum linewidth.
#' @param left_margin Number of spaces before the beginning of text.
#' @param type Two options:
#' \itemize{
#' \item{\code{basic}: Simple format with \code{#} box at the beginning.}
#' \item{\code{roxygen2}: Format consistent with package builder \code{roxygen2}.}}
#' @return A formated string specifying one or more lines.
#' @export
format_line <- function(
  x,
  linewidth = 80,
  right_margin = 5,
  left_margin = 1,
  type = c("basic","roxygen2")
){

  lines <- list()

  effective_linewidth = linewidth - right_margin - left_margin

  while(nchar(x) > effective_linewidth){

    current_line <- substr(x,start = 1, stop = effective_linewidth+1)

    # If there is a line break:
    if(grepl(pattern = "(?:\n|(?:\r\n))",x = current_line)){
      lines[[length(lines)+1]] <- stringr::str_match(current_line,pattern = "^(.*)(?:\n|(?:\r\n))(.*)")[2]
      x <- substr(x,start = nchar(lines[[length(lines)]])+1,stop = nchar(x))
      breaker <- stringr::str_match(x,pattern = "(\n|\r\n)")[2]
      x <- substr(x,start = nchar(breaker)+1,stop = nchar(x))
    }else{
      #Peak to see if there is a space in the next character:
      if(substr(x,start = effective_linewidth+2, stop = effective_linewidth+2) == " "){
        # Last word is a full word, therefore, we can simply move to the next line:
        lines[length(lines)+1] <- current_line
        x <- substr(x,start = nchar(lines[[length(lines)]])+2,stop = nchar(x))
      }else{
        # We are mid-word, so we need to find the last " " character and move from there.
        last_space = max(which(strsplit(current_line,split = NULL)[[1]] == " "))
        lines[length(lines)+1] <- substr(x,start = 1,stop = last_space-1)
        x <-
          substr(x,start = last_space+1,nchar(x))
        #   lines[i] <- substr(lines[i],start = 1,stop = last_space)
      }
    }
  }

  lines[[length(lines)+1]] <- x
  lines <- lapply(lines, function(x) strsplit(x,"\n")[[1]])
  lines <- unlist(lines)

  # Add extra indent for subsequent lines:
  if(length(lines) > 1 & type == "roxygen2"){
    lines[2:length(lines)] <- paste0("  ",lines[2:length(lines)])
  }

  #lines <- strip_white_space(lines)
  lines <- sapply(FUN = bookend_line,X = lines,type = type)
  return(paste0(lines,collapse = ""))
}
