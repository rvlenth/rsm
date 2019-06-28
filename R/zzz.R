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


.onLoad = function(libname, pkgname) {
    if (requireNamespace("emmeans", quietly = TRUE))
        emmeans::.emm_register("rsm", pkgname)
}
