\name{codata}
\alias{codata}
\docType{data}
\title{Automobile emissions data}
\description{
This is a  replicated 3^2 experiment reported in Box, Hunter, and Hunter (2005), Table 10.17. 
}
\usage{codata}
\format{
  A data frame with 18 observations on the following 3 variables.
  \describe{
    \item{\code{x1}}{a numeric vector, coded design variable for ethanol concentration}
    \item{\code{x2}}{a numeric vector, coded design variable for air-to-fuel ratio}
    \item{\code{y}}{a numeric vector, the response (CO concentration, in micrograms per cubic meter)}
  }
}
\details{
This example, when fitted with a second-order response surface, is an example of a rising ridge. The dataset is duscussed again one chapter later in the source text; Figure 11.17 of BH^2 suggests the coding formulas used in the example below.
}
\source{
Box, GEP, Hunter, JS, and Hunter, WG (2005) \emph{Statistics for Experimenters} (2nd ed), Wiley.
}
\examples{
# Create a coded dataset based on info in BH^2 Fig 11.17
CO <- as.coded.data(codata,  x1 ~ (Ethanol - 0.2)/0.1,  x2 ~ A.F.ratio - 15)
names(CO)[3] <- "CO.conc"
}
\keyword{datasets}
\keyword{design}

