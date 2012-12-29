\name{heli}
\alias{heli}
%%%\docType{data}
\title{Paper Helicopter Data}
\description{
  A central composite design with 4 factors in 2 blocks.  These data
  comprise a \code{\link{coded.data}} object.
}
\usage{heli}
\format{
  A data frame with 30 observations on the following 7 variables.
  Each observation reflects the results of 10 replicated flights under the 
  same experimental conditions.
  \describe{
    \item{\code{block}}{a factor with levels \code{1} \code{2}.
    Block 1 consists of 18 observations (a full factorial plus two center points).
    Block 2 consists of 12 observations -- 8 axis points and 4 center points.}
    \item{\code{x1}}{a numeric vector.  Coded wing area, \code{x1 ~ (A - 12.4)/.6}}
    \item{\code{x2}}{a numeric vector.  Coded length ratio, \code{x2 ~ (R - 2.52)/.26}}
    \item{\code{x3}}{a numeric vector.  Coded body width, \code{x3 ~ (W - 1.25)/.25}}
    \item{\code{x4}}{a numeric vector.  Coded body length, \code{x4 ~ (L - 2)/.5}}
    \item{\code{ave}}{a numeric vector.  Average flight time, in csec.}
    \item{\code{logSD}}{a numeric vector.  100*log(SD of times).}
  }
}
\source{
  Table 12.5 of Box, GEP, Hunter, JS, and Hunter, WG (2005)
  \emph{Statistics for Experimenters} (2nd ed.), Wiley.
}
\keyword{datasets}
