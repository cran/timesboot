\name{statistic}
\alias{statistic}
\title{
Auxiliary function that returns the sample acf values
}
\description{
Auxiliary function that returns the sample acf values
}
\usage{
statistic(ts)
}
\arguments{
  \item{ts}{
A time series object
}
}
\value{
\item{acf}{acf values}
}
\author{
Francisco Juretig
}
\examples{
function (ts) 
{
    cm = acf(ts, plot = FALSE)
    return(cm$acf)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
