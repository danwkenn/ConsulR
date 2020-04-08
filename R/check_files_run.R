#' Check to see if the file will run to completion without error:
#'
#' Function takes an R-script file as input and attempts to run the script in a new console R-session.
#' @param files character vector of R-script files to be checked by running in order.
#' @param verbose Print messages for checking progress?
#' @param line_selection Select the lines to be run if only a subset to be used. Default is for all lines to be run, and user should be very careful with this option, as subsequent code execution may be affected by changes to prior code.
#' @export

check_files_run <- function(files,verbose = FALSE,line_selection = NULL){

  template_location <- system.file("templates", package = "ConsulR")
  template_file <- paste0(template_location,"/template-check-run-multiple-files.R")
  temp_dir <- tempdir()
  temp_dir <- stringr::str_replace_all(temp_dir,pattern = "\\\\",replacement = "/")
  time = as.character(Sys.time())
  hash <- paste0(sample(c(LETTERS,letters),replace = TRUE,size = 10),collapse = "")
  result_name <- paste0(temp_dir,"/result-",hash,".txt")
  log_file <- paste0(temp_dir,"/log-",hash,".txt")
  file_list <- paste0(temp_dir,"/file-list-",hash,".txt")
  writeLines(text = files,con = file_list)
  template <- readChar(con = template_file,nchars= file.info(template_file)$size)
  test_file <- stringr::str_replace(template,"%FILELIST%",paste0("\\\"",file_list,"\\\""))
  test_file <- stringr::str_replace(test_file,"%TIME%",paste0("\\\"",time,"\\\""))
  test_file <- stringr::str_replace(test_file,"%RESULT%",paste0("\\\"",result_name,"\\\""))
  test_file <- stringr::str_replace(test_file,"%LOGFILE%",paste0("\\\"",log_file,"\\\""))

  sink(file = paste0(temp_dir,"/test_file.R"))
  cat(test_file)
  sink(file = NULL)

  if(verbose){
    message("Running file...")
  }
  system(paste0("Rscript \"",temp_dir,"/test_file.R\""))

  FILE_EXISTS <- file.exists(result_name)
  if(FILE_EXISTS){
    file_contents <- readLines(result_name)
    DATE_MATCH <- time == file_contents[[2]]
  }else{
    DATE_MATCH <- FALSE
  }

  if(FILE_EXISTS & DATE_MATCH){
    COMPLETED <- TRUE
  }else{
    COMPLETED <- FALSE
  }

  if(verbose){
    if(COMPLETED){
      message("File ran without break. Check $log for warnings.")
    }else{
      message("File failed. Check $log for warnings and error(s).")
    }

  }
  return(
    list(
      COMPLETED = COMPLETED,
      log = readChar(con = log_file,nchars= file.info(log_file)$size)
    )
  )
}
