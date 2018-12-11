%    Copyright (c) 2008-2010, 2012-2016 Russell V. Lenth
\name{contour.lm}
\alias{contour.lm}
\alias{image.lm}
\alias{persp.lm}
\title{Surface plot(s) of a fitted linear model}
\description{
  \code{contour}, \code{image}, and \code{persp} methods that display the fitted surface for an \code{lm} object 
  involving two or more numerical predictors.
}
\usage{
\method{contour}{lm}(x, form, at, bounds, zlim, xlabs, hook, 
    plot.it = TRUE, atpos = 1, decode = TRUE, image = FALSE, 
    img.col = terrain.colors(50), ...)

\method{image}{lm}(x, form, at, bounds, zlim, xlabs, hook, 
    atpos = 1, decode = TRUE, ...)

\method{persp}{lm}(x, form, at, bounds, zlim, zlab, xlabs, 
    col = "white", contours = NULL, hook, atpos = 3, decode = TRUE, 
    theta = -25, phi = 20, r = 4, border = NULL, box = TRUE, 
    ticktype = "detailed", ...) 
}
\arguments{
  \item{x}{A \code{lm} object.}
  \item{form}{A formula, or a list of formulas.}
  \item{at}{Optional \emph{named} list of fixed values to use for surface slices.
    For example, if the predictor variables are \code{x1}, \code{x2}, and \code{x3}, the contour plot of \code{x2} versus \code{x1} would be
    based on the fitted surface sliced at the \code{x3} value specified in \code{at}; the contour plot of \code{x3} versus \code{x1} would be sliced at the \code{at} value for \code{x2}; etc.
    If not provided, \code{at} defaults to the mean value of each numeric variable.}
  \item{bounds}{Optional \emph{named} list of bounds or grid values to use for
    the variables having the same names.  See details.}
  \item{zlim}{\code{zlim} setting passed to parent methods \code{\link{contour}}, \code{\link{image}}, or \code{\link{persp}}. The same \code{zlim} is used in all plots when several are produced.
    If not provided, the range of values across all plotted surfaces is used.}
  \item{zlab}{Optional label for the vertical axis.}
  \item{xlabs}{Alternate labels for predictor axes (see Details).}
  \item{hook}{Optional list that can contain functions \code{pre.plot} and \code{post.plot}.  
    May be used to add annotations or to re-route the graphs to separate files (see Details).}
  \item{atpos}{Determines where \code{at} values are displayed.  A value of 1 (or 2) displays it as part of the \emph{x} (or \emph{y}) axis label.
    A value of 3 displays it as a subtitle below the plot.  A value of 0 suppresses it.
    Any other nonzero value will cause the label to be generated but not displayed; it can be accessed via a \code{hook} function.}
  \item{decode}{This has an effect only if \code{x} is an \code{\link{rsm}} object or other model object that supports \code{\link{coded.data}}. In such cases, if \code{decode} is \code{TRUE}, the coordinate axes are transformed to their decoded values.}
  \item{image}{Set to \code{TRUE} if you want an image plot overlaid by contours.}
  \item{img.col}{Color map to use when \code{image=TRUE}.}
  \item{plot.it}{If \code{TRUE}, no plot is produced, just the return value.}
  \item{col}{Color or colors used for facets in the perspective plot (see details).}
  \item{contours}{If non-\code{NULL}, specifications for added contour lines in perspective plot.}
  \item{theta, phi}{Viewing angles passed to \code{\link{persp}} (different defaults).}
  \item{r}{Viewing distance passed to \code{\link{persp}} (different default).}
  \item{border, box}{Options passed to \code{\link{persp}}.}
  \item{ticktype}{Option passed to \code{\link{persp}} (different default).}
  \item{\dots}{Additional arguments passed to \code{\link{contour}}, \code{\link{image}}, or \code{\link{persp}}. Note, however, that a \code{ylab} is ignored, with a message to Use \code{xlabs} instead.}
}
\details{
  \code{form} may be a single formula or a list of formulas.  A simple formula like
  \code{x2 ~ x1} will produce a contour plot of the fitted regression surface
  for combinations of \code{x2} (vertical axis) and \code{x1} (horizontal axis).
  A list of several such simple formulas will produce a contour plot for each formula.
  A two-sided formula produces contour plots for each left-hand variable versus each
  right-hand variable (except when they are the same); for example, 
  \code{x1+x3 ~ x2+x3} is equivalent to 
  \code{list(x1~x2, x3~x2, x1~x3)}.  
  A one-sided formula produces contour plots for each pair of variables.  For example,
  \code{~ x1+x2+x3} is equivalent to 
  \code{list(x2~x1, x3~x1, x3~x2)}. 
  
  For any variables not in the \code{bounds} argument, a grid of 26 equally-spaced 
  values in the observed range of that variable is used.  If you specify a vector of 
  length 2, it is interpreted as the desired range for that variable and a grid of 26
  equally-spaced points is generated.  If it is a vector of length 3, the first two elements are used
  as the range, and the third as the number of grid points.
  If it is a vector of length 4 or more, those
  values are used directly as the grid values.
  
  The results are based on the predicted values of the linear model over the specified grid. If there are \code{factor}s among the predictors, the predictions are made over all levels (or combinations of levels) of those factors, and then averaged together. (However, the user may include factors in \code{at} to restrict this behavior.)
  
  By default, the predictor axes are labeled using the variable names in \code{form},
  unless \code{x} is an \code{\link{rsm}} or other object that supports \code{\link{coded.data}}, in which case either the decoded variable names or the variable-coding formulas are used to generate axis labels, depending on whether \code{decode} is \code{TRUE} or \code{FALSE}.
  These axis labels are replaced by the entries in \code{xlabs} if provided.  One must be careful using this
  to make sure that the names are mapped correctly.  The entries in \code{xlabs}
  should match the respective unique variable names in \code{form}, \emph{after sorting them in 
  (case-insensitive) alphabetical order} (not necessarily in order of appearance).  Note that if \code{form} is changed, it may also
  be necessary to change \code{xlabs}.
  
  Please note that with models fitted to coded data, coded values should be used in \code{at} or \code{bounds}, regardless of whether \code{decode} is \code{TRUE} or \code{FALSE}. However, any elements that are added afterward via \code{\link{points}}, \code{\link{lines}}, etc., must be specified in terms of whatever coordinate system is present in the plots.
  
  In \code{persp}, contour lines may be added via the \code{contours} argument.  It may be a boolean or character value, or a \code{list}.
  If boolean and \code{TRUE}, default black contour lines are added to the bottom surface of the box.  Character values of \code{"top"}, \code{"bottom"}
  add black contour lines to the specified surface of the box.  \code{contours = "colors"} puts contour lines on the bottom using the same colors as those 
  at the same height on the surface.  Other character values of \code{contours} are taken to be the desired color of the contour lines, plotted at the bottom.
  If \code{contours} is a named \code{list}, its elements (all are optional) are used as follows:
  \describe{
    \item{\code{z}}{Height where the contour lines are plotted.  May be \code{"bottom"} (default), \code{"top"}, or a numeric value.}
    \item{\code{col}}{Color of the lines.  If not specified, they will be black.  
      May be integer color values, color names, or \code{"colors"} to match the surface colors.}
    \item{\code{lwd}}{Line width; default is 1.}
  }
  
  Since these functions often produce several plots, the \code{hook} argument is provided if special setups or annotations are needed for each plot.  It
  should be a list that defines one or both of the functions \code{pre.plot} and \code{post.plot}.  Both of these functions have one argument, the character 
  vector \code{labs} for that plot (see Value documentation).
  
  Additional examples and discussion of these plotting functions is available via \code{vignette("rsm-plots")}.
}
\value{
  A \code{list} containing information that is plotted.  
  Each list item is itself a \code{list} with the following components:
  \item{x, y}{The values used for the x and y axes}
  \item{z}{The matrix of fitted response values}
  \item{labs}{Character vector of length 5: Elements 1 and 2 are the x and y axis labels, 
    elements 3 and 4 are their original variable names,
    and element 5 is the slice label (empty if \code{atpos} is 0)}
  \item{zlim}{The computed or provided \code{zlim} values}
  \item{transf}{(\code{persp} only) The 3D transformation for \code{\link{trans3d}}}
}
\references{
Lenth RV (2009) ``Response-Surface Methods in R, Using rsm'', 
  \emph{Journal of Statistical Software}, 32(7), 1--17. 
  \url{http://www.jstatsoft.org/v32/i07/.}
}
\author{Russell V. Lenth}
\seealso{\code{\link{contour}}}
\examples{
### Basic example with a linear model:
mpg.lm <- lm(mpg ~ poly(hp, disp, degree = 3), data = mtcars)
contour(mpg.lm, hp ~ disp, image = TRUE)

### Extended example with an rsm model...
heli.rsm <- rsm (ave ~ block + SO(x1, x2, x3, x4), data = heli)

# Plain contour plots
par (mfrow = c(2,3))
contour (heli.rsm, ~x1+x2+x3+x4, at = xs(heli.rsm))

# Same but with image overlay, slices at origin and block 2,
# and no slice labeling
contour (heli.rsm, ~x1+x2+x3+x4, at = list(block="2"), 
    atpos = 0, image = TRUE)

# Default perspective views
persp (heli.rsm, ~x1+x2+x3+x4, at = xs(heli.rsm))

# Same plots, souped-up with facet coloring and axis labeling
persp (heli.rsm, ~x1+x2+x3+x4, at = xs(heli.rsm),
    contours = "col", col = rainbow(40), zlab = "Flight time",
  xlabs = c("Wing area", "Wing length", "Body width", "Body length"))
  
\dontrun{
### Hints for creating graphics files for use in publications...

# Save perspective plots in one PDF file (will be six pages long)
pdf(file = "heli-plots.pdf")
persp (heli.rsm, ~x1+x2+x3+x4, at = xs(heli.rsm))
dev.off()

# Save perspective plots in six separate PNG files
png.hook = list(
    pre.plot = function(lab) 
        png(file = paste(lab[3], lab[4], ".png", sep = "")),
    post.plot = function(lab)
        dev.off())
persp (heli.rsm, ~x1+x2+x3+x4, at = xs(heli.rsm), hook = png.hook)
} %--- end of dontrun
}
\keyword{ regression }
\keyword{ hplot }
