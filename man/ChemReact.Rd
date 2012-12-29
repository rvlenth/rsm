\name{ChemReact}
\alias{ChemReact}
\alias{ChemReact1}
\alias{ChemReact2}
%%%\docType{data}
\title{Chemical Reaction Data}
\description{
  These data are from a central composite design with 2 factors in 2 blocks.
  The design variables are in actual, not coded, form.
}
\usage{
ChemReact
ChemReact1
ChemReact2
}
\format{
  A data frame with 14 observations on the following 4 variables.
  \describe{
    \item{\code{Time}}{a numeric vector; design variable with settings of 80, 85, and 90.}
    \item{\code{Temp}}{a numeric vector; design variable with settings of 170, 175, and 180.}
    \item{\code{Block}}{a factor with levels \code{B1} \code{B2}.
    Block \code{B1} is a first-order design with 3 center points.  
    Block \code{B2} consists of axis points and 3 more center points.}
    \item{\code{Yield}}{a numeric vector; response variable: yield of the chemical process.}
  }
  \code{ChemReact1} and \code{ChemReact2} are the separate blocks.   
  Each has 7 runs and three variables (\code{Block} is excluded from these).
}

\source{
  Table 7.6 of Myers, RH, Montgomery, DC, and Anderson-Cook, CM (2009), 
\emph{Response Surface Methodology} (3rd ed.), Wiley.

}
\keyword{datasets}
