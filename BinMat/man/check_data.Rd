% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check_data.R
\name{check_data}
\alias{check_data}
\title{Checks binary matrix for unwanted characters.}
\usage{
check_data(x)
}
\arguments{
\item{x}{A CSV file containing replicate pairs of binary data.}
}
\value{
Index positions where unwanted values occur.
}
\description{
Checks for unwanted values.
}
\examples{
data(BinMatInput_reps)
mat = BinMatInput_reps
check_data(mat)

}
