R package **rsm**: Response-surface methods and visualization
====

[![Build Status](https://travis-ci.org/rvlenth/rsm.svg?branch=master)](https://travis-ci.org/rvlenth/rsm)
[![cran version](http://www.r-pkg.org/badges/version/rsm)](https://cran.r-project.org/package=rsm)
[![downloads](http://cranlogs.r-pkg.org/badges/rsm)](http://cranlogs.r-pkg.org/badges/rsm)
[![total downloads](http://cranlogs.r-pkg.org/badges/grand-total/rsm)](http://cranlogs.r-pkg.org/badges/grand-total/rsm)
[![Research software impact](http://depsy.org/api/package/cran/rsm/badge.svg)](http://depsy.org/package/r/rsm)


## Features
* Response-surface methods have to do with conducting a series of small experiments to find the optimum operating conditions for a process. The **rsm** package provides tools for designing response-surface experiments, analyzing the results, finding promising new settings for future experiments, and visualization of fitted response surfaces.
* The package has three vignettes that will help orient the first-time user. Calling `vignette("article", package = "rsm")` brings up an updated rendering of the original *JSS* article that describes all of its functionality. A tutorial is available via `vignette("illus", package = "rsm")` -- it gives an illustration of how the package can be used. And one on **rsm**'s plotting capabilities is available via `vignette("plots", package = "rsm")`; it shows details for contour, image, or perspective plots.
* Includes support for a coded-data structure, important for expressing the design layout relative to a central location.
* Standard first- and second-order designs may be generated and appropriately randomized.
* Facilities are provided for augmenting a design -- for example, adding a foldover block or a set of axis points.
* The `rsm` function is a special extension of `lm` that facilitates fitting and evaluating first- and second-order models. Special functions `FO()`, `SO()`, `PQ()`, and `TWI()` are used to generate first-order, second-order, pure quadratic, and two-way-interaction predictors for a model.
* Functions such as `steepest()` allow for finding follow-up experiments in terms of coded or decoded predictors.
* Graphical tools are provided for creating contour and other plots -- not just for `rsm` objects, abut for any `lm` object with continuous predictors.

## Installation
* To install latest version from CRAN, run 
```
install.packages("rsm")
```
Release notes for the latest CRAN version are found at [http://cran.r-project.org/web/packages/rsm/NEWS](http://cran.r-project.org/web/packages/rsm/NEWS) -- or do `news(package = "rsm")` for notes on the version you have installed.

* To install the latest development version from Github, have the newest **devtools** package installed, then run
```
devtools::install_github("rvlenth/rsm", dependencies = TRUE)
```
For latest release notes on this development version, see the [NEWS file](https://github.com/rvlenth/rsm/blob/master/inst/NEWS)
