%    Copyright (c) 2008-2010, 2012-2016 Russell V. Lenth
\name{ccd}

\alias{cube}
\alias{star}
\alias{dupe}
\alias{foldover}
\alias{ccd}
\title{Generate central-composite designs and associated building blocks}
\description{
These functions generate central-composite designs, or building blocks thereof.
They allow for flexible choices of replications, aliasing of predictors and fractional blocks, and choices of axis or \sQuote{star} points.
}
\usage{
cube(basis, generators, n0 = 4, reps = 1, coding, randomize = TRUE, 
    blockgen, bid = 1, inscribed = FALSE)
star(basis, n0 = 4, alpha = "orthogonal", reps = 1, randomize = TRUE)
dupe(design, randomize = TRUE, coding)
foldover(basis, variables, bid, randomize = TRUE)
ccd(basis, generators, blocks = "Block", n0 = 4, alpha = "orthogonal", 
    wbreps = 1, bbreps = 1, randomize = TRUE, inscribed = FALSE, 
    coding, oneblock = FALSE)
}
\arguments{
\item{basis}{In \code{cube} and \code{ccd}, a formula, or an integer giving the number of variables.  If the formula has a left-hand side, the variables named there are appended to the design and initialized to \code{NA}. 
In \code{star}, \code{dupe}, and \code{foldover}, \code{basis} is a \code{coded.data} object to use as a reference.}
\item{generators}{Optional formula or list of formulas to generate aliased variables}
\item{n0}{Integer giving the number of center points. In \code{ccd}, this can be a vector of     
  two numbers for the numbers of center points in the cube blocks and the star blocks, 
  respectively.}
\item{reps}{Integer number of replications of the cube or the star. (This does \emph{not} create replicate blocks; use \code{\link{djoin}} to do that.)}
  \item{coding}{List of coding formulas for the design variables (those in \code{basis} and \code{generators}).  In \code{dupe}, \code{coding} may be used to change the coding formulas, e.g. in a situation where we want to use the same design as before but center it elsewhere.}
  \item{randomize}{Logical value determining whether or not to randomize the design.  In \code{ccd}, each block is randomized separately.}
\item{blockgen}{A formula, string, or list thereof. Each element is evaluated, and the distinct combinations define fractional blocks for the design. Unlike \code{ccd}, \code{cube} returns only one of these blocks.}
\item{bid}{(For block ID.) An integer index (from 1 to number of blocks) of the fractional block to return. The indexes are defined by the standard ordering of the block generators; e.g. if \code{blockgen} is of length 2, the \code{bid} values of (1, 2, 3, 4) correspond to generated levels of \code{(--, +-, -+, ++)} respectively.}
\item{inscribed}{Logical value; if \code{FALSE}, the cube points are at +/- 1 in each variable.  If \code{TRUE}, the entire desgn is scaled down so that the axis points are at +/- 1 and the cube points are at interior positions.  In \code{cube} only, \code{inscribed} may be given a numeric value: use the value of \code{alpha} anticipated when axis points are added; or use \samp{inscribed = TRUE} to scale in anticipation of \samp{alpha = "spherical"}.}
\item{alpha}{If numeric, the position of the \sQuote{star} points.  May also be a character string that matches or partially matches one of these:
\describe{
  \item{\code{"orthogonal"}}{the star points are positioned to block the design orthogonally}
  \item{\code{"rotatable"}}{the star points are chosen to make the design rotatable}
  \item{\code{"spherical"}}{the star points are the same distance as the corners of the design cube (alpha is the square root of the number of design factors)}
  \item{\code{"faces"}}{the star points are face-centered (same as \samp{alpha = 1})}
}
The user may specify a vector value of \code{alpha} if it is desired to vary them on different axes. The values are rotated cyclically as needed.
}
\item{design}{A \code{coded.data} object to be duplicated.}
  \item{blocks}{A string or a formula.  If a character string, it is the name of the blocking factor; if a formula, the left-hand side is used as the name of the blocking factor. The formula(s) on the right-hand side are used to generate separate fractional blocks.}
\item{variables}{Character vector of names of variables to fold over.}  
  \item{wbreps}{Number(s) of within-block replications.  If this is a vector of length 2, then separate numbers are used for the \sQuote{cube} and the \sQuote{star} blocks respectively.}
  \item{bbreps}{Number(s) of between-block replications (i.e., number of repeats of each block).  If this is a vector of length 2, then separate numbers are used for the \sQuote{cube} and the \sQuote{star} blocks respectively.}
  \item{oneblock}{Logical. If \code{TRUE}, the blocking factor is removed and the whole design is randomized as a single block. Note that the default number of center points may be larger than you anticipated because they are combined.}
}
\details{
Central-composite designs (CCDs) are popular designs for use in response-surface exploration.  They are blocked designs consisting of at least one \sQuote{cube} block (two-level factorial or fractional factorial, plus center points), and at least one \sQuote{star} block (points along each axis at positions \code{-alpha} and \code{+alpha}), plus center points.  Everything is put on a coded scale, where the cube portion of the design has values of -1 and 1 for each variable, and the center points are 0.

The \code{ccd} function creates an entire CCD design; however, in practice, we often start with just the cube portion and build from there. Therefore, the functions \code{cube}, \code{star}, \code{dupe}, and \code{foldover} are provided, and one may use \code{\link{djoin}} to combine them.

In \code{cube} and \code{ccd}, the \code{basis} argument determines a basic design used to create cube blocks.  
For example, \samp{cube(basis = ~ A + B + C)} would generate a basic design of 8 factorial points plus center points. 
Use \code{generators} if you want additional variables in a fractional design; for example, \samp{generators = c(D ~ -A*B, E ~ B*C)} added to the above would generate a 5-factor design with defining relation \code{I = -ABD = BCE = -ACDE}.  For convenience, \code{basis} may be an integer instead of a formula, in which case default variable names of \code{x1, x2, \dots} are used; for example, \samp{cube(3, ~ -x1*x2*x3)} generates a 1/2 fraction design with added center points.

If you want the cube points divided into fractional blocks, give the formula(s) in the \code{blockgen} argument of \code{cube}, or the \code{blocks} argument of \code{ccd}.  For instance, suppose we call \samp{cube(basis = A+B+C+D+E}, \samp{generators = F~-A*C*D)}.
This design has 32 runs; but adding the argument \samp{blockgen = c("A*B*C","C*D*E")} will
create a fractional block of 32/4 = 8 runs. (\code{cube} is flexible; we could have used a
formula instead, either \samp{blockgen = ~ c(A*B*C, C*D*E)} or 
\samp{blockgen = c(~A*B*C, ~C*D*E)}.) Center points are added to each block as specified. 
In a call to \code{ccd} with the same \code{basis} and \code{generators}, adding 
\samp{blocks = Day ~ c(A*B*C, C*D*E)} would do the same thing, only all 4 blocks will be
included, and a factor named \code{Day} distinguishes the blocks.

The functions \code{star}, \code{dupe}, and \code{foldover} provide for creating new design blocks based on an existing design.  They also provide for delayed evaluation: if the \code{basis} argument is missing, these functions simply return the call, \code{\link{djoin}} will fill-in \samp{basis = design1} and evaluate it. 

\code{dupe} simply makes a copy of the design, and re-randomizes it. Therefore it is also a convenient way to re-randomize a design. If \code{coding} is provided, the coding formulas are replaced as well -- for example, to re-center the design.

Use \code{star} to generate star (axis) points, which consist of center points plus points at \code{+/- alpha} on each coordinate axis.  You may specify the \code{alpha} you want, or a character argument to specify a certain criterion be met.  For example, using delayed evaluation, \samp{ccd1 = djoin(cube1, star(alpha="sph"))} will return a CCD with \code{cube1} as the cube block, and with axis points at the same distance as the corners of the cube. Conditions for the criteria on \code{alpha} are described in detail in references such as Myers \emph{et al.} (2009). 

In \code{star}, determinations of orthogonality and rotatability are based on computed design moments of \code{basis}, rather than any assumptions about the structure of the design being augmented. Thus, it may be possible to augment an unusual design to obtain a rotatable design. Also, if an orthogonal star block is requested, the value of \code{alpha} may vary from axis to axis if that is required to satisfy the condition.

\code{foldover} reverses the levels of one or more  design variables (i.e., those that are coded). By default, it reverses them all. However, if the \code{bid} argument is supplied, it instead returns the \code{bid}th fractional block that \code{cube} would have generated. That is, \samp{foldover(des, bid=3)} is equivalent to \samp{cube(<arguments that created des>, bid=3)} -- only it does so much more efficiently by folding on the appropriate factors.

In cases where there are constraints on the region of operability, you may want to specify \code{inscribed = TRUE}.  This will scale-down the design so that no coded value exceeds 1. If using a building-block approach starting with a first-order design from \code{cube}, call \code{cube}  with \code{inscribed} set to the anticipated value of \code{alpha}, or use \samp{inscribed = TRUE}, and then use \samp{alpha = "spherical"} in the subsequent call to \code{star}.

\code{ccd} generates an entire CCD. In practice, the building-block approach with \code{cube}, \code{star}, etc. is usually preferable, but \code{ccd} exists for convenience and backward compatibility with pre-2.00 versions of \pkg{rsm}. Many of the arguments are the same as those in \code{cube}; however, \code{n0}, \code{wbreps}, \code{bbreps} may be single values or vectors; if vectors, the first element is for the cube portions and the second element is for the star portions. In \code{ccd}, specifying \code{wbreps} is equivalent to specifying \code{reps} in a call to \code{cube} or \code{star}. \code{bbreps} refers to replicate blocks in the experiment, so that \samp{bbreps = c(2,3)} specifies that we join two cube blocks and three blocks of star points.

If \code{coding} is not specified in a new design, default identity codings are created, e.g. \samp{x1 ~ x1.as.is}.
}

\value{
A \code{\link{coded.data}} object with the generated design, with additional variables \code{run.order} and \code{std.order}. If a multi-block design, the generated blocking variable will be a \code{\link{factor}}; all other variables will be numeric. The designs are sorted by blocks and \code{run.order} within blocks; and (unlike pre-1.41 versions of \pkg{rsm}) the \code{row.names} will be integers corresponding to this ordering. The user may sort by block and \code{std.order} within block to display the designs in their pre-randomized order.
}
\references{
Lenth RV (2009) ``Response-Surface Methods in R, Using rsm'', 
  \emph{Journal of Statistical Software}, 32(7), 1--17. 
  \url{http://www.jstatsoft.org/v32/i07/.}

Myers, RH, Montgomery, DC, and Anderson-Cook, CM (2009) 
\emph{Response Surface Methodology} (3rd ed.), Wiley.
}
\author{Russell V. Lenth}
\note{
  Poor choices of \code{generators} and/or \code{blocks} can alias or partially alias some effects needed to estimate a second-order response surface.  It is a good idea to run \code{\link{varfcn}} before collecting data to examine the prediction capabilities of the design and to ensure that the desired model can be fitted.
  
  The function \code{\link{ccd.pick}} is available to help determine good choices for arguments to \code{cube}, \code{star}, and \code{ccd}.
  
  An alternative to a CCD when you want to go straight to second-order modeling is a Box-Behnken design, generated by \code{\link{bbd}}.  These designs are not as various or flexible as CCDs, but they can require fewer runs.
  
  The non-exported function \code{rsm:::.ccd.1.41} is provided in case it is needed by other packages for compatibility with old versions of \pkg{rsm} (version 1.41 or earlier). Given the same seed, it will also reproduce the randomization as a previously generated design from an old version.
}
\seealso{\code{\link{ccd.pick}}, \code{\link{coded.data}}, \code{\link{varfcn}}, \code{\link{bbd}}}
\examples{
library(rsm)

### Generate a standard 3-variable first-order design with 8 corner points and 4 center points
( FOdes <- cube (3, n0 = 4, coding = list (
                x1 ~ (Temp - 150)/10, x2 ~ (Pres - 50)/5, x3 ~ Feedrate - 4)) )
                                    
### Add an orthodonal star block with 12 runs to create a second-order CCD
( SOdes <- djoin(FOdes, star(n0=6)) )

### Same as above, except make the whole CCD at once; and make it rotatable
### and inscribed so that no coded value exceeds 1
SOdes2 <- ccd (3, n0 = c(4,6), alpha = "rotatable", inscribed = TRUE, coding = list (
                x1 ~ (Temp - 150)/10, x2 ~ (Pres - 50)/5, x3 ~ Feedrate - 4))

### Make two replicate blocks of FOdes (2nd one randomized differently)
djoin(FOdes, dupe(FOdes))

### Fractional blocking illustration (with no center points)
# Basic design (bid = 1 ---> block generators b1 = -1, b2 = -1)
block1 <- cube (~ x1 + x2 + x3 + x4,  generators = x5 ~ x1 * x2 * x3 * x4,
                n0 = 0, blockgen = ~ c(x1 * x2, x1 * x3), bid = 1)
block1                

# The foldover (on all variables) of block1, in the same order
foldover(block1, randomize=FALSE)

# The 4th fractional block:
( block4 <- foldover(block1, bid = 4) )

}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{design}
