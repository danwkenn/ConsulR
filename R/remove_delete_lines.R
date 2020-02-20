#' Remove lines marked for deletion

#' Simple function to take an .R script file and remove any lines previously marked for deletion. This is useful when your computer requires additional lines for the client's code to work. Lines can be added to your version with a pattern e.g. \code{##DELETE##}, and then removed when the code is shipped back to the client.
#' It should be noted that this is not an ideal solution, and if possible, the use of an R Project file, or compilation of code into an R package should be used to ensure code can be used on multiple machines.
#' Another use might be to add comments to your version of the code that the client does not need to read.
#' @param file character string with file path to .R file.
#' @param new_file_name character string with file path (and name) for the output .R file.
#' @param delete_pattern Regular expression for finding delete marker. Any lines containing this pattern are removed.
#' @return If file runs cleanly, then output is \code{TRUE}.
#'
#' @export
remove_delete_lines <- function(
  file,
  new_file_name,
  delete_pattern = "##DELETE##$"
){

  # Read in:
  text <- readChar(con = file,nchars= file.info(file)$size)

  # Break into lines:
  lines <- strsplit(text,
                   split = "((\r\n)|\n)")[[1]]

  # Identify errant lines:
  delete_lines <- grepl(lines,pattern = delete_pattern)

  # Remove errant lines:
  lines <- lines[!delete_lines]

  # Paste lines back together:
  lines <- paste0(lines,collapse = "\n")

  # Save:
  sink(file = new_file_name)
    cat(lines)
  sink(file = NULL)

  return(TRUE)
}
