% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/format_line.R
\name{format_line}
\alias{format_line}
\title{Format line with space margins.}
\usage{
format_line(
  x,
  linewidth = 80,
  right_margin = 5,
  left_margin = 1,
  type = c("basic", "roxygen2")
)
}
\arguments{
\item{x}{String.}

\item{linewidth}{Maximum number of characters per line.}

\item{right_margin}{Number of spaces between the end of text and the maximum linewidth.}

\item{left_margin}{Number of spaces before the beginning of text.}

\item{type}{Two options:
\itemize{
\item{\code{basic}: Simple format with \code{#} box at the beginning.}
\item{\code{roxygen2}: Format consistent with package builder \code{roxygen2}.}}}
}
\value{
A formated string specifying one or more lines.
}
\description{
Takes a string and formats it according the disired output type and considering line width and margin concerns. Where necessary, text will be broken up onto multiple lines, with line break escape characters respected.
}
