#' Function to safely load Rdata files.
#'
#' The \code{load()} function loads the objects stored in the Rdata file directly into the environment, which can write over existing objects. This function allows the objects to be assigned to a list variable. Since Rdata files are now largely replaced by the safer RDS format, this is essentially a back-compatibility mechanism.
#' @param file string file path to .Rdata object.
#' @return a list containing all objects contained in Rdata file.
#' @export

load_Rdata <- function(file){
  env <- new.env()
  nm <- load(file, env)
  output <- list()
  for(i in 1:length(nm)){
    output[[nm[i]]] <- env[[nm[i]]]
  }
  output
}
