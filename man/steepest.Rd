%    Copyright (c) 2008-2010, 2012-2025 Russell V. Lenth
\name{steepest}
\alias{steepest}
\alias{canonical.path}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Steepest-ascent methods for response surfaces}
\description{
  These functions provide the path of steepest ascent (or descent)
  for a fitted response surface produced by \code{\link{rsm}}.
}
\usage{
steepest (object, dist = seq(0, 5, by = .5), descent = FALSE)
canonical.path(object, which = ifelse(descent, length(object$b), 1),
               dist = seq(-5, 5, by = 0.5), descent = FALSE, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{\code{\link{rsm}} object to be analyzed.}
  \item{dist}{Vector of desired distances along the path of steepest ascent or descent.
  In \code{steepest}, these must all be non-negative; in \code{canonical.path},
  you may want both positive and negative values, which specify opposite directions from the stationary point.}
  \item{descent}{Set this to \code{TRUE} to obtain the path of steepest descent, or
    \code{FALSE} to obtain the path of steepest ascent.  This value is ignored in
    \code{canonical.path} if \code{which} is specified.}
  \item{which}{Which canonical direction (eigenvector) to use.}
  \item{...}{Optional arguments passed to \code{\link{canonical}}. 
    Currently this includes only \code{threshold}.}
}
\details{
  \code{steepest} returns the linear path of steepest ascent for first-order models, or a path obtained by ridge analysis (see Draper 1963) for second-order models.  In either case, the path begins at the origin.
  
  \code{canonical.path} applies only to second-order models (at least a \code{TWI} term present).  It determines a linear path along one of the canonical variables, originating at the stationary point (not the origin).  We need to specify which canonical variable to use.
  The eigenvalues obtained in the canaonical analysis are always in decreasing order, so the first canonical direction will be the path of steepest ascent (or slowest descent, if all eigenvalues are negative) from the stationary point, and the last one will be the path of steepest descent (or slowest ascent, if all eigenvalues are positive).  These are the defaults for \code{which} when \code{descent=FALSE} and \code{descent=TRUE} respectively. 
  
  All eigenvalues less (in absolute value than) \code{threshold} are taken to be zero. Increasing this threshold may bring the stationary point, and hence the canonical path, much closer to the design center, and thus less extrapolation.
  
  With either function, the path in uncoded units depends on how the data are coded.  Accordingly, it is important to code the predictor variables appropriately before fitting the response-surface model.  See \code{\link{coded.data}} and its relatives for more information.
}
\value{
  A \code{data.frame} of points along the path of steepest ascent (or descent).
  For \code{steepest}, this path originates from the center of the experiment; for \code{canonical.path}, 
  it starts at the stationary point.
  If coding information is available, the data frame also includes the uncoded values of the variables.
  
  For first-order response surfaces, only \code{steepest} may be used; the path is linear in that case.  
  For second-order surfaces, \code{steepest} uses ridge analysis, and the path may be curved.  
}
\references{
Draper, NR (1963), ``Ridge analysis of response surfaces'',
  \emph{Technometrics}, 5, 469--479.

Lenth RV (2009). ``Response-Surface Methods in R, Using rsm'', 
  \emph{Journal of Statistical Software}, 32(7), 1--17. 
  \doi{10.18637/jss.v032.i07}
}
\author{Russell V. Lenth}
\note{
  Take careful note of the fitted values along the outputted path (labeled \code{yhat}).  For example, if the stationary point is a maximum 
  (all eigenvalues negative), the fitted values from \code{steepest} will increase as far as the stationary point, then they will decrease as we proceed along what is now the path of slowest descent.
}
\seealso{\code{\link{rsm}}, \code{\link{coded.data}}}
\examples{
library(rsm)
heli.rsm = rsm (ave ~ block + SO(x1, x2, x3, x4), data = heli) 

steepest(heli.rsm)

canonical.path(heli.rsm)
}
\keyword{regression}
