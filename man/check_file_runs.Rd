% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check_file_runs.R
\name{check_file_runs}
\alias{check_file_runs}
\title{Check to see if the file will run to completion without error:}
\usage{
check_file_runs(file, verbose = FALSE, line_selection = NULL)
}
\arguments{
\item{file}{R-script file to be checked.}

\item{verbose}{Print messages for checking progress?}

\item{line_selection}{Select the lines to be run if only a subset to be used. Default is for all lines to be run, and user should be very careful with this option, as subsequent code execution may be affected by changes to prior code.}
}
\description{
Function takes an R-script file as input and attempts to run the script in a new console R-session.
}
