#' Function to uncomment all commented-out lines.
#'
#' Sometimes commands which work on the client side do not work or are detrimental on your side. (Think install.packages lines, or file system commands.)
#' This function takes an .R script file and uncomments any lines previously marked for uncommenting. Lines can be added to your version with a pattern e.g. \code{##UNCOMMENT##}, and then removed when the code is shipped back to the client.
#'
#' @param file character string with file path to .R file.
#' @param new_file_name character string with file path (and name) for the output .R file.
#' @param uncomment_pattern Regular expression for finding uncomment marker. Any lines containing this pattern are uncommented.
#' @return If file runs cleanly, then output is \code{TRUE}.
#'
#' @export
uncomment_marked_lines <- function(
  file,
  new_file_name,
  uncomment_pattern = "##UNCOMMENT##$"
){

  # Read in:
  text <- readChar(con = file,nchars= file.info(file)$size)

  # Break into lines:
  lines <- strsplit(text,
                    split = "((\r\n)|\n)")[[1]]

  # Identify lines to uncomment:
  uncomment_lines <- grepl(lines,pattern = uncomment_pattern)

  # uncomment lines and remove tag:
  lines[uncomment_lines] <- stringr::str_match(
    string = lines[uncomment_lines],
    pattern = paste0("^#\\s{0,1}(.*?)\\s*",uncomment_pattern))[,2]

  # Paste lines back together:
  lines <- paste0(lines,collapse = "\n")

  # Save:
  sink(file = new_file_name)
  cat(lines)
  sink(file = NULL)

  return(TRUE)
}
