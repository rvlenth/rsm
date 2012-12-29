\name{rsm}
\alias{rsm}
\alias{summary.rsm}
\alias{print.summary.rsm}
\alias{loftest}
\alias{codings.rsm}
\alias{canonical}
\alias{xs}
\title{Response-surface regression}
\description{
  Fit a linear model with a response-surface component,
  and produce appropriate analyses and summaries.
}
\usage{
rsm (formula, data, ...)

\method{summary}{rsm}(object, ...)
\method{print}{summary.rsm}(x, ...)

loftest (object)

canonical (object, threshold = 1e-04)
xs (object, ...)

\method{codings}{rsm}(object)
}
\arguments{
  \item{formula}{Formula to pass to \code{\link{lm}}. 
  The model must include at least one \code{FO()}, \code{SO()}, \code{TWI()}, or \code{PQ()} term to
  define the response-surface portion of the model.
  }
  \item{data}{\code{data} argument to pass to \code{\link{lm}}.}
  \item{\dots}{In \code{rsm}, arguments that are passed to \code{\link{lm}}, 
    \code{\link{summary.lm}}, or \code{canonical}, as appropriate.
  In \code{summary}, and \code{print}, additional arguments 
  are passed to their generic methods.}

  \item{object}{An object of class \code{rsm}}
  \item{threshold}{Threshold for canonical analysis -- see Value}
  \item{x}{An object produced by \code{summary}}
}
\details{
  In \code{rsm}, the model formula must contain at least an \code{FO} term; optionally, you can add
  one or more \code{TWI()} terms and/or a \code{PQ()} term. All variables that appear
  in \code{TWI} or \code{PQ} \emph{must} be included in \code{FO}.
  For convenience, specifying \code{SO()} is the same as including \code{FO()}, \code{TWI()}, and \code{PQ()},
  and is the safe, preferred way of specifying a full second-order model.
  
  The variables in \code{FO} comprise the variables to consider in response-surface methods. They need not all appear in \code{TWI} and \code{PQ} terms; and more than one \code{TWI} term is allowed. For example, the following two model formulas are equivalent:
\preformatted{
resp ~ Oper + FO(x1,x2,x3,x4) + TWI(x1,x2,x3) + TWI(x2,x3,x4) + PQ(x1,x3,x4)
resp ~ Oper + FO(x1,x2,x3,x4) + TWI(formula = ~x1*x2*x3 + x2*x3*x4) + PQ(x1,x3,x4)
}
The first version, however, creates duplicate \code{x2:x3} terms -- which \code{rsm} can handle but there may be warning messages if it is subsequently used for predictions or plotted in \code{\link{contour.lm}}.
  
  In \code{summary.rsm}, any \code{\dots} arguments are passed to \code{summary.lm}, except for \code{threshold}, which is passed to \code{canonical}.
}
\value{
  \code{rsm} returns an \code{rsm} object, which is a \code{\link{lm}} object with 
  additional members as follows:
    \item{order}{The order of the model: 1 for first-order, 1.5 for first-order plus interactions, 
     or 2 for a model that contains square terms.}
    \item{\bold{b}}{The first-order response-surface coefficients.}
    \item{\bold{B}}{The matrix of second-order response-surface coefficients, if present.}
    \item{labels}{Labels for the response-surface terms.  These make the summary much more readable.}
    \item{coding}{Coding formulas, if provided in the \code{codings} argument or
      if the \code{data} argument passed to \code{\link{lm}} is a \code{\link{coded.data}} object.}
  \code{summary} 
  is the summary method for \code{rsm} objects.  It returns an object of class
  \code{\link{summary.rsm}}, which is an extension of the \code{summary.lm}
  class with these additional list elements:
    \item{sa}{Unit-length vector of the path of steepest ascent
      (first-order models only).}
    \item{canonical}{Canonical analysis (second-order models only) from \code{canonical}}
    \item{lof}{ANOVA table including lack-of-fit test.}
    \item{coding}{Coding formulas in parent \code{rsm} object.}
  Its \code{print} method shows the regression summary,
  followed by an ANOVA and lack-of-fit test.  For first-order models, it shows the direction of 
  steepest ascent, and for second-order models, it shows the canonical analysis of the
  response surface.  
  
  \code{loftest} returns an \code{\link{anova}} object that tests the fitted model against a model 
  that interpolates the means of the response-surface-variable combinations.
  
  \code{canonical} returns a list with elements \code{xs}, the stationary point, and \code{eigen}, the eigenanalysis of the matrix \bold{B} of second-order coefficients. Any eigenvalues less than \code{threshold} are taken to be zero, thus modeling stationary ridges or valleys in their corresponding canonical directions. Setting a larger \code{threshold} may improve the numerical conditioning and bring the stationary point much closer to the design center, thus avoiding as much extrapolation. See \samp{vignette("rsm")} for more details.
  
  \code{xs} returns just the stationary point.
  
  \code{codings} returns a \code{list} of coding formulas if the model was fitted to 
  \code{\link{coded.data}}, or \code{NULL} otherwise.
}
\references{
Lenth RV (2009) ``Response-Surface Methods in R, Using rsm'', 
  \emph{Journal of Statistical Software}, 32(7), 1--17. 
  \url{http://www.jstatsoft.org/v32/i07/.}
}
\author{Russell V. Lenth}
\seealso{\code{\link{FO}}, \code{\link{SO}},
  \code{\link{lm}}, \code{\link[=lm-class]{summary}}, \code{\link{coded.data}}}
\examples{
library(rsm)
CR <- coded.data (ChemReact, x1~(Time-85)/5, x2~(Temp-175)/5)

### 1st-order model, using only the first block
CR.rs1 <- rsm (Yield ~ FO(x1,x2), data=CR, subset=1:7) 
summary(CR.rs1)

### 2nd-order model, using both blocks
CR.rs2 <- rsm (Yield ~ Block + SO(x1,x2), data=CR) 
summary(CR.rs2)

### Example of a rising-ridge situation from Montgomery et al, Table 6.2
RRex <- ccd(Response~A+B, n0=c(0,3), alpha="face", randomize=FALSE, oneblock=TRUE)
RRex$Response <- c(52.3,5.3,46.7,44.2,58.5,33.5,32.8,49.2,49.3,50.2,51.6)
RRex.rsm <- rsm(Response ~ SO(A,B), data = RRex)
canonical(RRex.rsm)
canonical(RRex.rsm, threshold = 1)  # xs is MUCH closer to the experiment
}
\keyword{regression}
