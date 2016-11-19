%    Copyright (c) 2008-2010, 2012-2016 Russell V. Lenth
\name{FO}
\alias{FO}
\alias{TWI}
\alias{PQ}
\alias{SO}
\alias{PE}
\title{Response-surface model components}
\description{
  Use of one of these functions in a model is how you specify the portion of the model
  that is to be regarded as a response-surface component.
}
\usage{
FO (...)
TWI (..., formula)
PQ (...)
SO (...)
PE (...)
}
\arguments{
  \item{\dots}{The numerical predictors for the response surface, 
  separated by commas.}
  \item{formula}{Alternative way to specify two-way interactions. Use \code{formula} or \code{\dots}, never both.}
}
\details{
  Use \code{FO()} in the model formula in \code{\link{rsm}}
  to specify a first-order response surface (i.e., a linear function) 
  in its arguments.  Use \code{TWI()} to generate two-way interactions, and \code{PQ()} to generate
  pure quadratic terms (squares of the \code{FO()} terms).  A call to
  \code{SO()} creates all terms in \code{FO()}, \code{TWI()}, and \code{PQ()} (in that order) for those
  variables.  However, specifying \code{SO()} in a model formula in \code{rsm} will be replaced 
  by the explicit sum of model terms, so that the \code{anova} table shows separate sums of squares.
  Other variables (such as blocks or factors) may be included in the model
  but should never be included in the arguments to \code{FO} or \code{SO}.
  
  \code{PE} is used for fitting pure-error models.  It should not be used in
  response-surface models.  This function exists primarily for use
  by \code{\link{loftest}}, but could be useful in other linear-model
  contexts for fitting a model that interpolates the means at each distinct
  combination of argument values.
  
  The \code{formula} argument in \code{TWI} can simplify specifying models where only certain interactions are included. For example, \samp{TWI(formula = ~x1:(x2+x3))} is equivalent to \samp{TWI(x1,x2) + TWI(x1,x3)}. The formula is expanded using \code{\link{terms}}, and then only the second-order terms are retained. If this results in only one term, an error condition is raised. This is necessary to prevent \code{\link{rsm}} from getting confused in identifying second-order terms.
}
\value{
  The functions \code{FO}, \code{TWI}, \code{PQ}, and \code{SO} return a matrix whose
  columns are the required predictors.
  
  \code{PE} returns a \code{factor} whose levels are all the distinct combinations of
  arguments provided to the function.
}
\examples{
  ### See 'rsm' help for examples of FO, TWI, etc
  
  library(rsm)
  ### Test LOF for a regression model
  ChemReact.lm <- lm(Yield ~ Time*Temp, data = ChemReact1)
  PureError.lm <- update (ChemReact.lm, . ~ PE(Time,Temp))
  anova (ChemReact.lm, PureError.lm)
}
\references{
Lenth RV (2009) ``Response-Surface Methods in R, Using rsm'', 
  \emph{Journal of Statistical Software}, 32(7), 1--17. 
  \url{http://www.jstatsoft.org/v32/i07/.}
}
\author{Russell V. Lenth}
\seealso{\code{\link{rsm}}}
\keyword{regression}
