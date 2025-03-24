%    Copyright (c) 2008-2010, 2012-2025 Russell V. Lenth
\name{ccd.pick}
\alias{ccd.pick}
\title{Find a good central-composite design}
\description{
This function looks at all combinations of specified design parameters
for central-composite designs, calculates other quantities such as
the \code{alpha} values for rotatability and orthogonal blocking, imposes 
specified restrictions, and outputs the best combinations in a specified order.
This serves as an aid in identifying good designs.  The design itself can 
then be generated using \code{\link{ccd}}, or in pieces using \code{\link{cube}}, \code{\link{star}}, etc.
}
\usage{
ccd.pick(k, n.c = 2^k, n0.c = 1:10, blks.c = 1, n0.s = 1:10, bbr.c = 1, 
         wbr.s = 1, bbr.s = 1, best = 10, sortby = c("agreement", "N"), 
         restrict)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{k}{Number of factors in the design}
  \item{n.c}{Number(s) of factorial points in each cube block}
  \item{n0.c}{Numbers(s) of center points in each cube block}
  \item{blks.c}{Number(s) of cube blocks that together comprise one rep of the cube portion}
  \item{n0.s}{Numbers(s) of center points in each star (axis-point) block}
  \item{bbr.c}{Number(s) of copies of each cube block}
  \item{wbr.s}{Number(s) of replications of each star poit within a block}
  \item{bbr.s}{Number(s) of copies of each star block}
  \item{best}{How many designs to list.  Use \code{best=NULL} to list them all}
  \item{sortby}{String(s) containing numeric expressions that are each evaluated and used as sorting key(s).
    Specify \code{sortby=NULL} if no sorting is desired.}
  \item{restrict}{Optional string(s) containing Boolean expressions that are each evaluated.  Only combinations where all
  expressions are \code{TRUE} are retained.}
}
\details{
  A grid is created with all combinations of \code{n.c}, \code{n0.c}, \dots, \code{bbr.s}.
  Then for each row of the grid, several additional variables 
  are computed:
  \describe{
  \item{\code{n.s}}{The total number of axis points in each star block}
  \item{\code{N}}{The total number of observations in the design}
  \item{\code{alpha.rot}}{The position of axis points that make the design rotatable.
    Rotatability is achieved when design moment [iiii] = 3[iijj] for i and j unequal.}
  \item{\code{alpha.orth}}{The position of axis points that make the blocks mutually orthogonal.
    This is achieved when design moments [ii] within each block are proprtional
    to the number of observations within the block.}
  \item{\code{agreement}}{The absolute value of the log of the ratio of 
    \code{alpha.rot} and \code{alpha.orth}.  This measures agreement between 
    the two \code{alpha}s.}
  }
  If \code{restrict} is provided, only the cases where the expressions are all \code{TRUE} are kept.  
  (Regardless of \code{restrict}, rows are eliminated where there are 
  insufficient degrees of freedom to estimate all needed effects for a 
  second-order model.)
  The rows are 
  sorted according to the expressions in \code{sortby}; the default is to sort
  by \code{agreement} and \code{N}, which is suitable for finding designs
  that are both rotatable and orthogonally blocked.
}
\value{
  A \code{data.frame} containing \code{best} or fewer rows, and variables
  \code{n.c}, \code{n0.c}, \code{blks.c}, \code{n.s}, \code{n0.s}, \code{bbr.c}, 
  \code{wbr.s}, \code{bbr.s},  \code{N}, \code{alpha.rot}, and \code{alpha.orth},
  as described above.
}
\references{
Lenth RV (2009) ``Response-Surface Methods in R, Using rsm'', 
  \emph{Journal of Statistical Software}, 32(7), 1--17. 
  \doi{10.18637/jss.v032.i07}

Myers, RH, Montgomery, DC, and Anderson-Cook, CM (2009)
\emph{Response Surface Methodology} (3rd ed.), Wiley.
}
\author{Russell V. Lenth}
\seealso{\code{\link{ccd}}}
\examples{
library(rsm)

### List CCDs in 3 factors with between 10 and 14 runs per block
ccd.pick(3, n0.c=2:6, n0.s=2:8)
# (Generate the design that is listed first:) 
# ccd(3, n0=c(6,4))

### Find designs in 5 factors containing 1, 2, or 4 cube blocks
### of 8 or 16 runs, 1 or 2 reps of each axis point,
### and no more than 70 runs altogether
ccd.pick(5, n.c=c(8,16), blks.c=c(1,2,4), wbr.s=1:2, restrict="N<=70")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{design}
