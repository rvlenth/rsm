##############################################################################
#    Copyright (c) 2018 Russell V. Lenth                                     #
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

### Dynamic registration of S3 methods
# Code borrowed from hms pkg. I omitted some type checks etc. because
# this is only for internal use and I solemnly promise to behave myself.
register_s3_method = function(pkg, generic, class) {
    fun = get(paste0(generic, ".", class), envir = parent.frame())
    if (isNamespaceLoaded(pkg)) {
        registerS3method(generic, class, fun, envir = asNamespace(pkg))
    }
    # Register hook in case package is later unloaded & reloaded
    setHook(
        packageEvent(pkg, "onLoad"),
        function(...) {
            registerS3method(generic, class, fun, envir = asNamespace(pkg))
        }
    )
}

.onLoad = function(libname, pkgname) {
    if (requireNamespace("emmeans", quietly = TRUE)) {
        register_s3_method("emmeans", "recover_data", "rsm")
        register_s3_method("emmeans", "emm_basis", "rsm")
    }
}
