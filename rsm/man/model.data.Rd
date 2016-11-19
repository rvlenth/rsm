%    Copyright (c) 2008-2010, 2012-2016 Russell V. Lenth
\name{model.data}
\alias{model.data}
\title{Reconstruct data from a linear model}
\description{
  Create a data frame with just the variables in the formula in 
  a \code{lm} object.  
  This is comparable to \code{\link{model.matrix}} or \code{\link{model.frame}} except that factors,
  polynomials, transformations, etc. are not expanded.
}
\usage{
model.data(lmobj, lhs = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{lmobj}{An object returned by \code{\link{lm}} or one of its relatives.}
  \item{lhs}{Boolean indicator of whether or not to include the variable(s) 
  on the left-hand side of the model formula.}
}
\details{
  This is an easy-to-use substitute for \code{\link{get_all_vars}}.
  The \code{formula}, \code{data}, and \code{subset} arguments, if present in
  \code{lmobj}'s call, affect the result appropriately.
}
\value{
  A data frame containing each of the variables referenced in the model formula.
}
\references{
Lenth RV (2009) ``Response-Surface Methods in R, Using rsm'', 
  \emph{Journal of Statistical Software}, 32(7), 1--17. 
  \url{http://www.jstatsoft.org/v32/i07/.}
}
\author{ Russell V. Lenth }

\seealso{\code{\link{model.matrix}}, \code{\link{model.frame}}}
\examples{
library(rsm)
trees.lm <- lm(log(Volume) ~ poly(log(Girth),3), data = trees, subset = 1:20)
model.frame(trees.lm)
model.data(trees.lm)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ regression }
