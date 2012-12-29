\name{varfcn}
\alias{varfcn}
\title{
    Display the scaled variance function for a design
}
\description{
    This function computes the scaled variance function for a design, based on a 
    specified model. Options include plotting separate curves for each of several 
    directions from the center, or a contour plot for two of the design factors.
}
\usage{
varfcn(design, formula, dist = seq(0, 2, by = 0.1), vectors, contour = FALSE, 
       plot = TRUE, main, ...)
}
\arguments{
  \item{design}{A \code{data.frame} or \code{coded.data} object}
  \item{formula}{The model formula for which to compute the variance function}
  \item{dist}{Vector of distances from the origin at which to compute the scaled variance}
  \item{vectors}{A \code{data.frame} of design variables. Each nonzero row specifies a direction in which to calculate the scaled variance.}
  \item{contour}{A logical variable. If \code{TRUE}, a contour plot is produced; if \code{FALSE}, curves are plotted for each direction in \code{vectors}.}
  \item{plot}{A logical variable. If \code{TRUE}, a plot is produced.}
  \item{main}{Title for the plot. The default is constructed based on the name of \code{design} and \code{formula}.}
  \item{\dots}{Other arguments passed to the \code{\link{plot}} or \code{\link{contour}} functions.}
}
\details{
The scaled prediction variance at a particular design point is the variance of the predicted value, multiplied by the sample size \emph{N}, and divided by the error variance. (See, for example, Montgomery \emph{et al.}, Section 8.2.1). It depends on the design point, but for a symmetric design, it depends only on the distance from the origin and the direction. This function provides a simple way to examine the variance function directly. (There are other more sophisticated methods available that integrate-out the direction, for example \code{\link[Vdgraph]{Vdgraph}} in the \code{Vdgraph} package.) 

If \code{vectors} is not specified and \code{contour==FALSE}, the function generates default directions along one axis, and on a diagonal through a corner in each dimension. For example, with four design variables, the default directions are (1,0,0,0), (1,1,0,0), (1,1,1,0), and (1,1,1,1). The graph produced shows how the scaled variance changes along each of these vectors, for the distances provided. In a rotatable design, these curves will all be the same. 

When \code{countour==TRUE}, only the ordering of columns in \code{vectors} matters. A grid is constructed over the distance range for the first two variables in \code{vectors}. The design points are also plotted for reference, with different symbol sizes depending on replications. When there are more than two response-surface predictors, the contour plot may be misleading, as it does not display what happens as one simultaneously varies three or more variables.
}

\value{The function invisibly returns a \code{data.frame} containing the data that was (or would have been) plotted.}

\references{
Myers, RH Montgomery DC, and Anderson-Cook CM (2009)
\emph{Response Surface Methodology} (3rd ed.), Wiley.}
\author{Russell V. Lenth}

%\note{}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{\code{\link[Vdgraph]{Vdgraph}}}

\examples{
  des = ccd(~ x1 + x2 + x3, alpha = 1.5, block = Phase ~ x1*x2*x3, randomize=FALSE)
  varfcn(des, ~ Phase + SO(x1, x2, x3))
  varfcn(des, ~ Phase + SO(x1, x2, x3), contour=TRUE)
  
  # 10 random directions
  dirs = data.frame(x3=rnorm(10), x2=rnorm(10), x1=rnorm(10))
  varfcn(des, ~ Phase + SO(x1, x2, x3), vectors = dirs)

  # exclude some points to make it more interesting
  lost = c(1,2,3,5,8,13,21)
  varfcn(des[-lost, ], ~ Phase + SO(x1, x2, x3), contour=TRUE)
  
  # different plot due to order of columns
  varfcn(des[-lost, ], ~ Phase + SO(x1, x2, x3), vectors = dirs, contour=TRUE)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ design }
