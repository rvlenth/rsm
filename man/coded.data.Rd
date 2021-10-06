%    Copyright (c) 2008-2010, 2012-2016 Russell V. Lenth
\name{coded.data}
\alias{coded.data}
\alias{as.coded.data}
\alias{decode.data}
\alias{recode.data}
\alias{is.coded.data}
\alias{val2code}
\alias{code2val}
\alias{print.coded.data}
\alias{[.coded.data}
%%%\alias{.parse.coding}
\alias{codings}
\alias{codings.coded.data}
\alias{codings<-}
\alias{names<-.coded.data}
\alias{truenames}
\alias{truenames.coded.data}
\alias{truenames<-}
\alias{truenames<-.coded.data}


\title{Functions for coded data}
\description{
  These functions facilitate the use of coded data in response-surface analysis.
}
\usage{
coded.data(data, \dots, formulas = list(\dots), block = "block")
as.coded.data(data, \dots, formulas = list(\dots), block = "block")
decode.data(data)
recode.data(data, \dots, formulas = list(\dots))

val2code(X, codings)
code2val(X, codings)

\method{print}{coded.data}(x, \dots, decode = TRUE)

### --- Methods for managing coded data ---
is.coded.data(x)

\method{[}{coded.data}(x, \dots)

codings(object)
\method{codings}{coded.data}(object)
codings(object) <- value

\method{names}{coded.data}(x) <- value

## Generic method for true variable names (i.e. decoded names)
truenames(x)
\method{truenames}{coded.data}(x)
## Generic replacement method for truenames
truenames(x) <- value
\method{truenames}{coded.data}(x) <- value
}
\arguments{
  \item{data}{A \code{data.frame}}
  \item{formulas}{List of coding formulas; see details}
  \item{block}{Name(s) of blocking variable(s). It is \code{pmatch}ed (case insensitively) with names in \code{data} to identify blocking factorss}
  \item{X}{A vector, matrix, or data.frame to be coded or decoded.}
  \item{codings}{A list of formulas; see Details}
  \item{decode}{Logical. If \code{TRUE}, the decoded values are displayed; if \code{FALSE}, the codings are displayed.}
  \item{object}{A \code{coded.data} object}
  \item{x}{A \code{coded.data} object}
  \item{value}{Replacement value for \code{<-} methods}
  \item{\dots}{In \code{coded.data}, \code{as.coded.data}, and \code{recode.data}, \code{\dots} allows specifying formulas as arguments rather than as a list. In other functions, \code{\dots} is passed to the parent methods.}
}
\details{
  Typically, coding formulas are of the form \code{x ~ (var - center) / halfwd} 
  where \code{x} and \code{var} are variable names, and \code{center} and 
  \code{halfwd} are numbers.  
  The left-hand side gives the name of the coded variable, and the right-hand side 
  should be a linear expression in the uncoded variable (linearity is \emph{not} explicitly 
  checked, but nonlinear expressions will not decode correctly.) If \code{coded.data} is called without formulas, automatic codings are created (along with a warning message). Automatic codings are based on transforming all non-block variables having five or fewer unique values to the interval [-1,1]. If no formulas are provided in \code{as.coded.data}, default coding formulas like those for \code{\link{cube}} are created all numeric variables with mean zero -- again with a warning message.
    
  An S3 \code{print} method is provided for the \code{coded.data} class; 
  it displays the data.frame in either coded or 
  decoded form, along with the coding formulas. Some users may prefer \code{print.data.frame} 
  or \code{as.data.frame} in lieu of \code{print} with \samp{decode=FALSE}; they produce the 
  same output without displaying the coding formulas.
  
  Use \code{coded.data} to convert a \code{data.frame} in which the variables
  are on their original scales.  The variables named in the formulas are 
  coded and replaced with their coded versions (and also renamed).
  
  In contrast, \code{as.coded.data} does not modify any of the data; it assumes the variables
  are already coded, and the coding information is simply added. In addition, if \code{data} is 
  already a \code{coded.data} object from a pre-1.41 version of \pkg{rsm}, 
  it is converted to 
  be compatible with new capabilities such as \code{\link{djoin}} (no \code{formulas} argument 
  is needed in this case). Any blocking factors should be specified in the \code{blocks} 
  argument.
  
  \code{decode.data} converts a dataset of class \code{coded.data} and 
  returns a \code{data.frame} containing the original variables.
  
  \code{recode.data} is used to convert a \code{coded.data} object to new codings. 
  Important: this \emph{changes} the coded values to match the new coding formulas. If you want to keep the coded values the same, but change the levels they represent, use \samp{codings(object) <- \dots} or \code{\link{dupe}}.
  
  \code{code2val} converts coded values to the original scale using the codings provided, 
  and returns an object of the same class as \code{X}.  
  \code{val2code} converts the other direction.  When using these functions, it is 
  essential that the names (or column names in the case of matrices) match those of the 
  corresponding coded or uncoded variables.
    
  \code{codings} is a generic function for accessing codings.  It
  returns the list of coding formulas from a \code{coded.data} object.  One may use an 
  expression like \samp{codings(object) <- list(\dots)} to change the codings (without changing 
  the coded values themselves).   See also \code{\link{codings.rsm}}.
  
  \code{is.coded.data(x)} returns \code{TRUE} if \code{x} inherits from \code{coded.data}, and \code{FALSE otherwise.}
  
  The extraction function \code{x[\dots]} and the naming functions \code{names<-}, 
  \code{truenames}, and \code{truenames<-} are provided to preserve the integrity of 
  codings. For example, if \code{x[, 1:3]} excludes any coded columns, their coding formulas 
  are also excluded. If all coded columns are excluded, the return value is unclassed 
  from \code{coded.data}. When variable names are changed using \code{names(x) <- \dots}, the coding 
  formulas are updated accordingly. The \code{truenames} function returns the names of the 
  variables in the decoded dataset. We can change the decoded names using 
  \code{truenames(x) <- \dots}, and the coding formulas are updated. Note that \code{truenames}
  and \code{truenames<-} work the same as \code{names} and \code{names<-} for 
  unencoded variables in the object.
  
  Another convenient way to copy and change the coding formulas a coded dataset (and optionally re-randomize it) is to use the \code{\link{dupe}} function with a \code{coding} argument.
  
  When a design is created in another package, some of the variables may be \code{factor}s, in which case they are converted using \code{as.numeric} (values of 1, 2, ...). These levels may be regarded as a yet different coding of the variables, and so it may take two steps to get it in the desired form: one to convert the supplied levels to the desired range (often -1 to 1), and the other to replace the coding formulas to correspond to the real values of the variables to be used. See the examples.
}
\value{
  \code{coded.data}, \code{as.coded.data}, and \code{recode.data} return an object of class  
  \code{coded.data},  which inherits from \code{\link{data.frame}}. A \code{coded.data} 
  object is stored in coded form, and its \code{names} attribute contains the coded names, 
  where they apply. Thus, when fitting models in \code{\link{rsm}} or \code{\link{lm}} with 
  coded data as the \code{data} argument, the model formula should be given in terms of the 
  coded variables.
}

\note{Starting with \pkg{rsm} version 2.00, the \code{coded.data} class involves additional attributes to serve broader needs in design-generation. Because of this, old \code{coded.data} objects may need to be updated using \code{as.coded.data} if they are to be used with the newer functions such as \code{\link{djoin}}.}


\seealso{\code{\link{data.frame}}, \code{\link{djoin}}, \code{\link{dupe}}, \code{\link{rsm}}}
\references{
Lenth RV (2009). ``Response-Surface Methods in R, Using rsm'', 
  \emph{Journal of Statistical Software}, 32(7), 1--17. 
  \doi{10.18637/jss.v032.i07}
}
\author{Russell V. Lenth}
\examples{
library(rsm)

### Existing dataset with variables on actual scale
CR <- coded.data (ChemReact, x1 ~ (Time - 85)/5, x2 ~ (Temp - 175)/5)
CR                            # same as print(CR, decode = TRUE)
print(CR, decode = FALSE)     # similar to as.data.frame(CR)
code2val (c(x1=.5, x2=-1), codings = codings(CR))

### Existing dataset, already in coded form
CO <- as.coded.data(codata, x1 ~ (Ethanol - 0.2)/0.1, x2 ~ A.F.ratio - 15)
truenames(CO)
names(CO)

# revert x2 to an uncoded variable
codings(CO)[2] <- NULL
truenames(CO)

### Import a design that is coded in a different way

if (require(conf.design)) { # ----- This example requires conf.design -----

# First, generate a 3^3 in blocks and import it via coded.data
    des3 <- coded.data(conf.design(p=3, G=c(1,1,2)))
    # NOTE: This returns a warning message but does the right thing --
    # It generates these names and coding formulas automatically:
    #   x1 ~ (T1 - 2)/1
    #   x2 ~ (T2 - 2)/1
    #   x3 ~ (T3 - 2)/1
# Now randomize and change the codings and variable names for the real situation:
    mydes <- dupe(des3, coding = c(x1 ~ (Dose - 20)/5,  x2 ~ (Conc - 40)/10,  
                                x3 ~ (Time - 60)/15))
                                
} # ----- end of example requiring package conf.design -----

}
\keyword{regression}
\keyword{design}
