\name{redraw}
\alias{redraw}
\title{
Auxiliary function that computes the spectrum
}
\description{
Auxiliary function that computes the spectrum
}
\usage{
redraw(series, ...)
}
\arguments{
  \item{series}{
A time series object
}
  \item{\dots}{
optional arguments
}
}
\value{
\item{spec}{Periodogram}
}
\author{
Francisco Juretig
}
\examples{
function (series, ...) 
{
    args <- list(...)
    ws = spec.pgram(series, spans = args$p, plot = FALSE, detrend = args$detrend)
    return(ws$spec)
  }
}
\keyword{Periodogram}
