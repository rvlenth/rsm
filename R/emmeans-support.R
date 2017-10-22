##############################################################################
#    Copyright (c) 2017 Russell V. Lenth                                     #
#                                                                            #
#    This file is part of the rsm package for R (*rsm*)                      #
#                                                                            #
#    *rsm* is free software: you can redistribute it and/or modify           #
#    it under the terms of the GNU General Public License as published by    #
#    the Free Software Foundation, either version 2 of the License, or       #
#    (at your option) any later version.                                     #
#                                                                            #
#    *rsm* is distributed in the hope that it will be useful,                #
#    but WITHOUT ANY WARRANTY; without even the implied warranty of          #
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           #
#    GNU General Public License for more details.                            #
#                                                                            #
#    A copy of the GNU General Public License is available at                #
#    <https://www.r-project.org/Licenses/>                                   #
##############################################################################

# emmeans support ...
# We'll support a 'mode' argument with 3 possibilities:
#    - "asis" - just passes throu like an lm model, no matter what
#    - "coded" - do not decode predictors, even if coding is present
#    - "decoded" - if coding is present, decode the predictors and
#       present results working on the decoded scale.

recover_data.rsm = function(object, data, mode = c("asis", "coded", "decoded"), ...) {
    mode = match.arg(mode)
    cod = codings(object)
    fcall = object$call
    if(is.null(data))
        data = emmeans::recover_data(fcall, delete.response(terms(object)), 
                                     object$na.action, ...)
    if (!is.null(cod) && (mode == "decoded")) {
        pred = cpred = attr(data, "predictors")
        trms = attr(data, "terms")
        data = decode.data(as.coded.data(data, formulas = cod))
        for (form in cod) {
            vn = all.vars(form)
            if (!is.na(idx <- grep(vn[1], pred))) {
                pred[idx] = vn[2]
                cpred = setdiff(cpred, vn[1])
            }
        }
        attr(data, "predictors") = pred
        new.trms = update(trms, reformulate(c("1", cpred)))   # excludes coded variables
        attr(new.trms, "orig") = trms       # save orig terms as an attribute
        attr(data, "terms") = new.trms
    }
    data
}

emm_basis.rsm = function(object, trms, xlev, grid, 
                         mode = c("asis", "coded", "decoded"), ...) {
    mode = match.arg(mode)
    cod = codings(object)
    if(!is.null(cod) && mode == "decoded") {
        grid = coded.data(grid, formulas = cod)
        trms = attr(trms, "orig")   # get back the original terms we saved
    }
    
    m = model.frame(trms, grid, na.action = na.pass, xlev = xlev)
    X = model.matrix(trms, m, contrasts.arg = object$contrasts)
    bhat = as.numeric(object$coefficients) 
    V = emmeans::.my.vcov(object, ...)
    
    if (sum(is.na(bhat)) > 0)
        nbasis = estimability::nonest.basis(object$qr)
    else
        nbasis = estimability::all.estble
    dfargs = list(df = object$df.residual)
    dffun = function(k, dfargs) dfargs$df

    list(X = X, bhat = bhat, nbasis = nbasis, V = V, 
         dffun = dffun, dfargs = dfargs, misc = list())
}


# ### For lsmeans
# recover.data.rsm = function (...)
#     recover_data.rsm (...)
# 
# lsm.basis.rsm = function (...)
#     emm_basis.rsm (...)