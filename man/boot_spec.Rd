\name{boot_spec}
\alias{boot_spec}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function that computes boostrapped confidence intervals for the sample periodogram.
}
\description{
The function resamples a time series object using phase scramble bootstrap and returns the average,lower and upper confidence bounds.
}
\usage{
boot_spec(series, replic = 5000, spansa = c(11, 21), 
plot = TRUE, de_trend = FALSE, alpha = 0.05)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{series}{
A time series object
}
  \item{replic}{
The amount of replications used in the bootstrap step
}
  \item{spansa}{
The spans for smoothing the spectrum
}
  \item{plot}{
TRUE,FALSE. Whether plotting is desired. Default is TRUE.
}
  \item{de_trend}{
TRUE,FALSE. Should de-trending be applied to the series.Default is FALSE
}
  \item{alpha}{
The alpha used in the construction of the CI. Default is 0.05
}
}
\value{
\item{average}{The average value for each frequency}
\item{upper}{The upper value for each frequency}
\item{lower}{The lower value for each frequency}
}

\author{
Francisco Juretig
}
\examples{

boot_spec(AirPassengers,replic=1000,alpha=0.05)

function (series, replic = 5000, spansa = c(11, 21), plot = TRUE, 
    de_trend = FALSE, alpha = 0.05) 
{
    if (is.ts(series) == TRUE) {
    	library(boot)
        kas = tsboot(series, redraw, p = spansa, detrend = de_trend, 
            replic, sim = "scramble")
        span1 = spansa[1]
        span2 = spansa[2]
        quantiles = matrix(0, length(kas$t[1, ]), 3)
        Xvalues = spec.pgram(series, spans = c(span1, span2), 
            plot = FALSE)
        for (i in 1:length(kas$t[1, ])) {
            cp = kas$t[, i]
            quantiles[i, 1] = quantile(cp, alpha)
            quantiles[i, 2] = quantile(cp, 1 - alpha/2)
            quantiles[i, 3] = mean(cp)
        }
        if (plot == TRUE) {
            maximus = max(quantiles[, 3])
            plot(Xvalues$freq, quantiles[, 1], type = "l", col = "blue", 
                ylim = c(0, maximus * 2), main = "Bootstraped Periodogram", 
                ylab = "periodogram", lwd = 1, xlab = "frequency")
            polygon(c(Xvalues$freq, rev(Xvalues$freq)), c(quantiles[, 
                1], rev(quantiles[, 2])), col = "skyblue")
            lines(Xvalues$freq, quantiles[, 3], type = "o", col = "black", 
                pch = 20)
        }
        lix = list(freq = Xvalues$freq, upper = quantiles[, 2], 
            lower = quantiles[, 1], mean = quantiles[, 3])
        return(lix)
    }
    else {
        return("Object is not a time-series")
    }
  }
}
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
