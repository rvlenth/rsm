%    Copyright (c) 2008-2010, 2012-2016 Russell V. Lenth
\name{rsm-package}
\alias{rsm-package}
\docType{package}
\title{
Response-surface analysis
}
\description{
The \code{rsm} package provides functions useful for designing and analyzing
experiments that are done sequentially in hopes of optimizing a response surface.

The function \code{\link{ccd}} can generate (and randomize) a central-composite 
design; it allows the user to specify an aliasing or fractional blocking structure.
The function \code{\link{bbd}} generates and randomizes a Box-Behnken design.  
The function \code{\link{ccd.pick}} is useful for identifying good parameter choices
in central-composite designs. Functions \code{cube}, \code{star}, \code{foldover}, \code{dupe}, and \code{djoin} are also provided to build-up designs from individual blocks. The function \code{varfcn} allows the experimenter to examine the predictive capabilities of a design before collecting data.

The function \code{\link{rsm}} is an enhancement of \code{\link{lm}} that provides 
for additional analyses peculiar to response surfaces.  It requires a model formula 
that contains a call to \code{\link{FO}} or \code{\link{SO}} to specify a first- or 
second-order model.  Once the model is fitted, the \code{\link{steepest}} 
function may be used to obtain the direction of steepest ascent (or descent).  
\code{\link{canonical.path}} is an alternative to \code{steepest} for second-order 
response surfaces.

In RSM methods, appropriate coding of data is
important not only for numerical stability, but for proper scaling
of results; the function \code{\link{coded.data}} and its relatives facilitate
this coding requirement.  

Finally, a few more functions are provided that may be useful beyond response-surface applications.  
\code{\link{contour.lm}}, \code{\link{persp.lm}}, and \code{\link{image.lm}} aids in visualizing a response surface, 
or of any other \code{lm} object where a surface is fitted.  \code{\link{model.data}}
recovers the data used in a \code{lm} call, but unlike \code{model.frame}, no
polynomials, factors, etc. are expanded.

For more information and examples, use \samp{vignette("rsm")} and \samp{vignette("rs-illus")}.  
Additionally, \samp{vignette("rsm-plots")} provides some illustrations 
of the graphics functions.
}
\author{
Russell V. Lenth

Maintainer: Russell V. Lenth <russell-lenth@uiowa.edu>
}
\references{
Box, GEP, Hunter, JS, and Hunter, WG (2005) 
\emph{Statistics for Experimenters} (2nd ed.), Wiley-Interscience.

Lenth RV (2009) ``Response-Surface Methods in R, Using rsm'', 
  \emph{Journal of Statistical Software}, 32(7), 1--17. 
  \url{https://www.jstatsoft.org/v32/i07/.}

Myers, RH, Montgomery, DC, and Anderson-Cook, CM (2009), 
\emph{Response Surface Methodology} (3rd ed.), Wiley.
}
\keyword{ package }
\keyword{ regression }

