\name{boot_autocov}
\alias{boot_autocov}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
A function that computes the bootstrapped autocovariances for a time series object. The computations are done via phase scrambling bootstrap 
}
\description{
The function resamples the time series object and returns the average , upper, and lower bounds for the autocovariances for each lag.
}
\usage{
boot_autocov(series, replic = 5000, plot = TRUE, alpha = 0.05)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{series}{
A time series object
}
  \item{replic}{
The amount of boostrap replicates
}
  \item{plot}{
TRUE,FALSE indicating whether the plot is desired
}
  \item{alpha}{
the alpha needed for the intervals
}
}
\value{

\item{average}{The average ACF for each lag}
\item{lower}{The ACF lower quantile  for each lag}
\item{upper}{The ACF upper quantile for each lag}

}
\author{
Francisco Juretig
}

\examples{

boot_autocov(AirPassengers,replic=1000,alpha=0.05)


function (series, replic = 5000, plot = TRUE, alpha = 0.05) 
{
    if (is.ts(series) == TRUE) {
        library(boot)
        kas = tsboot(series, statistic, R = replic, sim = "scramble")
        quantiles = matrix(0, length(kas$t[1, ]), 3)
        for (i in 2:length(kas$t[1, ])) {
            cp = kas$t[, i]
            quantiles[i, 1] = quantile(cp, alpha)
            quantiles[i, 2] = quantile(cp, 1 - alpha/2)
            quantiles[i, 3] = mean(cp)
        }
        quantiles = quantiles[-1, ]
        if (plot == TRUE) {
            par(mfrow = c(1, 2))
            x = seq(1, length(quantiles[, 1]), 1)/frequency(series)
            plot(x, quantiles[, 1], type = "l", col = "blue", 
                main = "Bootstraped Correlogram", ylab = "value", 
                lwd = 1, xlab = "lag")
            polygon(c(x, rev(x)), c(quantiles[, 1], rev(quantiles[, 
                2])), col = "skyblue")
            lines(x, quantiles[, 3], type = "o", col = "black", 
                pch = 20)
            abline(a = 0, b = 0)
            plot(acf(series, plot = FALSE), main = "Asymptotic Correlogram", 
                ylim = c(-1, 1))
        }
        lista = list(average = quantiles[, 1], upper = quantiles[, 
            2], lower = quantiles[, 3])
        return(lista)
    }
    else {
        return("Object is not a time-series")
    }
  }
}
\keyword{bootstrap}
\keyword{time series}
\keyword{ACF}