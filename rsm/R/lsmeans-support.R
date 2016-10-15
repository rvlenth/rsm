# lsmeans support ...
# We'll support a 'mode' argument with 3 possibilities:
#    - "asis" - just passes throu like an lm model, no matter what
#    - "coded" - do not decode predictors, even if coding is present
#    - "decoded" - if coding is present, decode the predictors and
#       present results working on the decoded scale.

recover.data.rsm = function(object, data, mode = c("asis", "coded", "decoded"), ...) {
    mode = match.arg(mode)
    cod = codings(object)
    fcall = object$call
    if(is.null(data))
        data = lsmeans::recover.data(fcall, delete.response(terms(object)), object$na.action, ...)
    if (!is.null(cod) && (mode == "decoded")) {
        pred = cpred = attr(data, "predictors")
        trms = attr(data, "terms")
        pnms = all.vars(delete.response(trms))
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

lsm.basis.rsm = function(object, trms, xlev, grid, 
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
    V = lsmeans::.my.vcov(object, ...)
    
    if (sum(is.na(bhat)) > 0)
        nbasis = estimability::nonest.basis(object$qr)
    else
        nbasis = estimability::all.estble
    dfargs = list(df = object$df.residual)
    dffun = function(k, dfargs) dfargs$df

    list(X = X, bhat = bhat, nbasis = nbasis, V = V, 
         dffun = dffun, dfargs = dfargs, misc = list())
}

