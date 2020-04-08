#' Update the title box's "date last modified" field.
#'
#' Useful function to automatically update the last modified field when changes are made to a script.
#' This is a simple implementation of version control, and a modern system such as 'git' would be recommended instead.
#' @param file Path to .R script file to be updated.
#' @param new_date The date to be given as the last modification date. Default is today.
#' @return If file runs cleanly, then output is \code{TRUE}.
#' @export

update_r_script_title_box <- function(file,new_date = Sys.Date()){
  text = readChar(con = file,nchars = file.info(file)$size)

  # Clean up carriage returns:
  text = stringr::str_replace_all(text,pattern = "\r\r",replacement = "\r")
  text = stringr::str_replace_all(text,pattern =
                           "\r",replacement = "")

  text = stringr::str_replace(string = text,pattern = "#DATE LAST MODIFIED: \\d{4}-\\d{2}-\\d{2}",replacement = paste0("#DATE LAST MODIFIED: ",new_date))
  sink(file = file)
  cat(text)
  sink(file = NULL)
  return(TRUE)
}
