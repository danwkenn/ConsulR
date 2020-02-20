#' Create an R script file with preamble in either the basic or roxygen2 format.
#'
#' @param title Character string with title of script.
#' @param description Character string description of the script's function.
#' @param author Author's name
#' @param email Author's email address
#' @param date_created Date the script file was created. Defaults to today.
#' @param date_last_modified Date the script file was last modified. Defaults to today.
#' @param params A vector of strings detailing the parameters (most useful if script is a function.)
#' @param license A string detailing the license for the code.
#' @param output A string detailing the output of the script.
#' @param write_to_file File to create with preamble. If \code{NULL}, then outputted to the console.
#' @param linewidth Maximum number of characters per line.
#' @param right_margin Number of spaces between the end of text and the maximum linewidth.
#' @param left_margin Number of spaces before the beginning of text.
#' @param type Two options:
#' \itemize{
#' \item{\code{basic}: Simple format with \code{#} box at the beginning.}
#' \item{\code{roxygen2}: Format consistent with package builder \code{roxygen2}.}}
#' @return If file runs cleanly, then output is \code{TRUE}.
#' @export
#' @examples
#' create_r_script_title_box(
#'   title = "A script about nothing",
#'   author = "D. W. Kennedy",
#'   email = "not.my.email@gmail.com",
#'   license = "",
#'   description = "\nThe following code:\n - solves existential dread,\n - the problem of evil\n - the need for accountants.",
#'   type = "basic",
#'   params = c("blah a parameter which is not important.", "verbose Should progress messages be shown?")
#' )

create_r_script_title_box <- function(
  title,
  author,
  email,
  date_created = Sys.Date(),
  date_last_modified = Sys.Date(),
  description,
  params = NULL,
  output = NULL,
  license = "MIT",
  linewidth = 80,
  right_margin = 4,
  left_margin = 1,
  type = c("basic","roxygen2"),
  write_to_file = NULL
){

  if(!is.null(write_to_file)){
    sink(file = write_to_file)
  }

  if(type == "basic"){
    cat(strrep("#",linewidth))
    cat("\n")
    cat(format_line(paste0("TITLE: ",title),type = type))
    cat(format_line(paste0("AUTHOR: ",author),type = type))
    cat(format_line(paste0("EMAIL: ",email),type = type))
    cat(format_line(paste0("DATE CREATED: ",date_created),type = type))
    cat(format_line(paste0("DATE LAST MODIFIED: ",date_last_modified),type = type))
    cat(format_line(paste0("LICENSE: ",license),type = type))
    cat(format_line(paste0("DESCRIPTION: ",description),type = type))

    if(!is.null(params)){
      cat(format_line(paste0("INPUTS: "),type = type))
      for(i in 1:length(params)){
        cat(format_line(paste0(" ",params[[i]]),type = type))
      }
    }

    if(!is.null(output)){
      cat(format_line(paste0("OUTPUT: "),type = type))
    }


    cat(strrep("#",linewidth))
  }else{
    if(type == "roxygen2"){
      cat(format_line(paste0("@title: ",title),type = type))
      cat("#'\n")
      cat(format_line(paste0("@description: ",description),type = type))
      if(!is.null(params)){
        for(i in 1:length(params)){
          cat(format_line(paste0("@param ",params[[i]]),type = type))
        }
      }

      if(!is.null(output)){
        cat(format_line(paste0("@return ",output),type = type))
      }
    }
  }

  if(!is.null(write_to_file)){
    sink(file = NULL)
  }

  return(TRUE)
}
