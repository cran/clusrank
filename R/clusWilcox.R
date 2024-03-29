##
## clusrank: Wilcoxon Rank Tests for Clustered Data
##
## Copyright (C) 2015-2024 Yujing Jiang, Mei-Ling Ting Lee, and Jun Yan
## Copyright (C) 2022-2024 Wenjie Wang
##
## This file is part of the R package clusrank.
##
## The R package clusrank is free software: You can redistribute it and/or
## modify it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or any later
## version (at your option). See the GNU General Public License at
## <https://www.gnu.org/licenses/> for details.
##
## The R package clusrank is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
##


##' Wilcoxon Rank Sum and Signed Rank Test for Clustered Data
##'
##' Performs one-sample and two-sample Wilcoxon test for clustered data
##' on vectors of data.
##'
##' @param x A numeric vector of data values or a formula. Non-finite (e.g.,
##'     infinite or missing) values will be omitted.
##' @param y An optional numeric vector of data values, non-finite
##'     values will be omitted.
##' @param cluster An optional numeric vector of cluster id.
##' @param group An optional numeric vector of treatment id.
##' @param stratum An optional numeric vector of stratum id. Only
##' available for \code{rgl} rank sum test when treatment is assigned at
##'     cluster level.
##' @param method A character string specifying the method of
##'     clustered Wilcoxon rank test to be use, should be one of
##'     \code{"rgl"} or \code{"ds"}. For rank-sum test, the \code{"dd"}
##'     method is also available.
##' @param paired A logical indicating whether you want a paired test.
##' @param exact A logical indicating if a permutation test is to be
##'     used. If it is set as \code{FALSE}, then test based on
##'     large-sample theory is carried out. If it is set as
##'     \code{TRUE}, then a permutation test is carried out. There are
##'     two available permutation tests: exact permutation test is available for
##'     \code{rgl} signed rank test and \code{rgl} rank sum test when
##'     treatment is assigned at cluster level, random permutation
##'     test is available for all tests. For more details look at the
##'     description of the argument \code{B}.
##' @param B An integer specifying the number of permutations if exact = TRUE.
##'     If B = 0, then the test is the exact permutation test.
##'     If B > 0, then an approximation to the exact test with B random permutation.
##'     Default is set as 2000 to ran a random permutation test.
##' @param formula A formula of the form \code{lhs ~ rhs} where the
##'     \code{lhs} is the measurements and
##'     the \code{rhs} is of the form group + \code{cluster}(x1) +
##'     \code{stratum}(x2) for clustered rank sum test, where
##'     \code{x1} and \code{x2} are cluster id and stratum id in the
##'     data frame \code{data}. For clustered signed rank test, the
##'     \code{rhs} should only contain \code{cluster}(x1).
##' @param data An optional data frame containing the variables.
##' @param subset An optional vector specifying a subset of
##'     observations to be used.
##' @param na.action A function which indicates what should happen
##'     when the data contain NAs. Defaults to \code{getOption("na.action")}.
##' @param alternative A character string specifying the alternative
##'     hypothesis, must be one of \code{"two sided"} (default),
##'     \code{"greater"} or \code{"less"}. You can specify just the
##'     initial letter.
##' @param mu A number specifying an optional parameter used to form
##'     the null hypothesis. Default is 0. See 'Details'.
##' @param ... Further arguments to be passed to or from methods.
##' @details The formula interface is to both clustered signed rank
##'     test and clustered rank sum test.
##'
##'
##' The default of \code{cluster} id is that there is one member in
##'     each cluster. Both balanced data (identical cluster size) and
##'     unbalanced data (different cluster sizes) are
##'     supported in all tests provided in this package. For clustered
##'     rank sum test, the data can either have treatment assigned at
##'     cluster level or individual level.
##'
##' If both \code{x} and \code{y} are given or only \code{x} is given
##'     and \code{paired} is \code{TRUE}, a clustered Wilcoxon signed
##'     rank test of the null that the distribution of \code{x - y}
##'     (paired sample) or of \code{x} (one sample) is symmetric about
##'     \code{mu} is performed.
##'
##' Otherwise, if only \code{x} is given and \code{paired} is
##' \code{FALSE}, a Wilcoxon rank sum test is performed. In this case,
##' measurements from different treatment groups should be combined in
##' \code{x} and the \code{group} variable is required.  When there
##' are two treatment groups, the null is that the distributions of
##' values from the two groups differ by a location shift of \code{mu}
##' and the alternative is that they differ by some other location
##' shift.  When there are \code{m} (>= 2) treatment groups, \code{ds}
##' method can test if the location of the \code{m} groups are
##' identical or not.
##'
##' For RGL rank sum test when treatment is assigned at cluster level,
##'     an extra stratification variable is allowed through \code{stratum}.
##'
##' The exact test is only available for RGL signed rank test and  RGL
##'     rank sum test when treatment is assigned at cluster level.
##'
##' @return A list with class \code{"htest"} containing the following components,
##' for different test the components may vary:
##' \item{Rstat}{the value of the rank statistic with a name describing it.}
##' \item{ERstat}{the expectation of the rank statistic.}
##' \item{VRstat}{the variance of the rank statistic.}
##' \item{statistic}{the value of the test statistic with a name describing it.}
##' \item{p.value}{the p-value for the test.}
##' \item{alternative}{a character string describing the alternative hypothesis.}
##' \item{null.value}{the location parameter 'mu'.}
##' \item{method}{the type of test applied.}
##' \item{data.name}{a character string giving the names of the data.}
##' \item{balance}{a logical indicating whether the data set is balanced.}
##' \item{ngroup}{number of treatment, will be returned if there are more than 2 treatment groups and \code{ds} method is used.}
##' \item{df}{degrees of freedom of chi-square distribution, will be returned when there are more than 2 treatment groups and \code{ds} method is used.}
##' \item{nobs}{number of observations}
##' \item{nclus}{number of clusters}
##' @section Warning:
##' This function can use large amounts of memory and stack if 'exact =
##'     TRUE' and one sample is large (and even crash R if the stack
##'     limit is exceeded). Not recommended for data set
##'     with number of clusters more than 50.
##'
##' @example inst/examples/ex-clusWilcox.R
##'
##' @author Yujing Jiang
##' @references
##' Bernard Rosner, Robert J. Glynn, Mei-Ling T. Lee (2006)
##' \emph{The Wilcoxon Signed Rank Test for Paired Comparisons of
##'  Clustered Data}. Biometrics, \bold{62}, 185-192.
##'
##' Bernard Rosner, Robert J. Glynn, Mei-Ling T. Lee (2003)
##' \emph{Incorporation of Clustering Effects for the Wilcoxon Rank
##' Sum Test: A Large-Sample Approach}. Biometrics, \bold{59}, 1089-1098.
##'
##' Bernard Rosner, Robert J. Glynn, Mei-Ling T. Lee (2006)
##' \emph{Extension of the Rank Sum Test for Clustered Data:
##' Two-Group Comparisons with Group}. Biometrics, \bold{62}, 1251-1259.
##'
##' Somnath Datta, Glen A. Satten (2005) \emph{Rank-Sum Tests for Clustered Data}.
##' Journal of the American Statistical Association, \bold{100}, 908-915.
##'
##' Somath Datta, Glen A. Satten (2008) \emph{A Signed-Rank Test for Clustered Data}.
##' Biometrics, \bold{64}, 501-507.
##'
##' Sandipan Dutta, Somnath Datta (2015) \emph{A Rank-Sum Test for Clustered
##'     Data When the Number of Subjects in a Group within a Cluster is
##'     Informative}.
##' Biometrics, \bold{72}, 432-440.
##'
##' @importFrom stats complete.cases na.omit terms complete.cases model.extract
##'     aggregate lm ecdf pnorm qnorm var pchisq setNames lag as.formula
##' @importFrom MASS ginv
##' @importFrom Rcpp evalCpp
##' @useDynLib clusrank, .registration = TRUE
##' @export
clusWilcox.test <- function(x, ...) {
    pars <- as.list(match.call()[-1])
    if (!is.null(pars$data)) {
        data.temp <- eval(pars$data, parent.frame())
    } else {
        data.temp <- NULL
    }
    if (!is.null(data.temp) && length(pars$x) == 1) {
        if (is.data.frame(data.temp) &&
            any(as.character(pars$x) %in% names(data.temp))) {
            x <- data.temp[, as.character(pars$x)]
        } else if(is.matrix(data.temp) &&
                  any(as.character(pars$x) %in% colnames(data.temp))) {
            x <- data.temp[, as.character(pars$x)]
        }
    }
    ## see https://github.com/wenjie2wang/clusrank/issues/1
    if (is.language(x)) {
        x <- eval(x, envir = parent.frame())
    }
    UseMethod("clusWilcox.test", x)
}


##' @method clusWilcox.test formula
##' @describeIn clusWilcox.test \code{S3} method for class 'formula'
##' @export
clusWilcox.test.formula <- function(formula, data = parent.frame(), subset = NULL,
                                    na.action = na.omit,
                                    alternative = c("two.sided", "less", "greater"),
                                    mu = 0, paired = FALSE, exact = FALSE,
                                    B = 2000, method = c("rgl", "ds", "dd"),
                                    ...) {
    if (missing(formula) || (length(formula) != 3L)) {
        stop("'formula' missing or incorrect")
    }
    m <- match.call(expand.dots = FALSE)
    if (is.matrix(eval(m$data, parent.frame()))) {
        m$data <- as.data.frame(data)
    }
    special <- c("stratum", "cluster")
    m[[1L]] <- quote(stats::model.frame)
    m$... <- NULL
    m$formula <- if(missing(data)) terms(formula, special)
                 else terms(as.formula(formula), special, data = data)
    subset.ind <- NULL
    if (!missing(subset)) {
        if ("subset" %in% names(m)) subset.ind <- which(names(m) == "subset")
        else subset.ind <- 4
    }

      na.ind <- NULL
    if (!missing(na.action)) {
        if ("na.action" %in% names(m)) na.ind <- which(names(m) == "na.action")
        else na.ind <- 5
    }


    m <- if (missing(data)) m <- m[c(1 : 2, subset.ind, na.ind)]
         else m <- m[c(1 : 3, subset.ind, na.ind)]
    mf <- eval(m, parent.frame())
    Terms <- terms(mf) ## Delete

    x.name <- rownames(attr(m$formula, "factors"))[1]
    DNAME <- paste0(x.name, ";")
    response <- attr(terms(mf), "response")
    x <- mf[[response]]
    n.obs <- length(x)

    group <- extractTerm("group", mf, n.obs, paired)
    DNAME <- paste0(DNAME, group[["name"]])
    group <- group[["var"]]
    method <- match.arg(method)
    if (length(unique(group)) > 2 && method == "rgl") {
        stop("RGL method cannot handle data with more than 2 groups. ",
             "Please consider DS method.")
    }


    cluster <- extractTerm("cluster", mf, n.obs, paired)
    DNAME <- paste0(DNAME, cluster[["name"]])
    cluster <- cluster[["var"]]

    stratum <- extractTerm("stratum", mf, n.obs, paired)
    DNAME <- paste0(DNAME, stratum[["name"]])
    stratum <- stratum[["var"]]


    ## please use tab key to keep the indentation correct
    if (!missing(data)) {
        DNAME <- paste(DNAME, "(from", paste0(m$data, ")"))
    }

    y <- do.call("clusWilcox.test.default",
                 c( list(x = x, cluster = cluster,
                         group = group, stratum = stratum,
                         DNAME = DNAME, paired = paired,
                         alternative = alternative,
                         method = method, mu = mu, exact = exact,
                         B = B),
                   list(...)))
    return(y)
}


##' @method clusWilcox.test default
##' @describeIn clusWilcox.test Default \code{S3} method.
##' @export
clusWilcox.test.default <- function(x, y = NULL, cluster = NULL,
                                    group = NULL, stratum = NULL, data = NULL,
                                    alternative = c("two.sided", "less", "greater"),
                                    mu = 0, paired = FALSE, exact = FALSE, B = 2000,
                                    method = c("rgl", "ds", "dd"), ...) {
    alternative <- match.arg(alternative)
    method <- match.arg(method)
    pars <- as.list(match.call()[-1])

    if (!missing(mu) && ((length(mu) > 1L) || !is.finite(mu)))
        stop("'mu' must be a single number")
    DNAME <- list(...)$"DNAME"
    if (is.null(DNAME))  {
        if (!is.null(pars$data)) {
            x <- extractVar("x", pars, data)
            DNAME <- extractName("x", pars)

            y <- extractVar("y", pars, data)
            DNAME <- paste0(DNAME, extractName("y", pars))

            group <- extractVar("group", pars, data)
            DNAME <- paste0(DNAME, extractName("group", pars))

            cluster <- extractVar("cluster", pars, data)
            DNAME <- paste0(DNAME, extractName("cluster", pars))

            stratum <- extractVar("stratum", pars, data)
            DNAME <- paste0(DNAME, extractName("stratum", pars))

            DNAME <- paste0(DNAME, " (from ", paste0(pars$data, ")"))
        } else {
            DNAME <- (pars$x)
            DNAME <- paste0(DNAME, extractName("y", pars))
            DNAME <- paste0(DNAME, extractName("group", pars))
            DNAME <- paste0(DNAME, extractName("cluster", pars))
            DNAME <- paste0(DNAME, extractName("stratum", pars))
        }
    }


    if (!is.null(y)) {
        if(!is.numeric(y)) {
            stop("'y' must be numeric")
        }
        if(length(y) != length(x)) {
            stop("'y' must have the same length as 'x' for the clustered signed rank test")
        }
        paired <- TRUE
        x <- x - y
    }

    if (is.null(cluster)) {
        stop("'cluster' is required")
    }

    if (is.null(group) && paired == FALSE) {
        stop("'group' is required for the clustered rank sum test")
    }

    if (!is.null(group) && paired == TRUE) {
        warning("'group' will be ignored for the clustered signed rank test")
    }

    if (is.null(stratum)) {
        stratum <- rep(1, length(x))
    }
    if (is.null(DNAME)) {
        if(is.null(y)) {
            DNAME  <-  deparse(substitute(x))
        } else {
            DNAME <- paste(deparse(substitute(x)), "and", deparse(substitute(y)))
        }
    }
    OK <- complete.cases(x, cluster, group, stratum) & is.finite(x)
    x <- x[OK]
    cluster <- cluster[OK]
    group <- group[OK]
    stratum <- stratum[OK]

    if (length(x) < 1L) {
        stop("not enough (finite) 'x' observation")
    }

    if (paired) {
        if (length(table(stratum)) > 1L) {
            warning("'stratum' will be ignored for the clustered signed rank test")
        }
        ## x <- x - mu
        METHOD <- "Clustered Wilcoxon signed rank test"
        if (method == "rgl") {
            METHOD <- paste(METHOD, "using Rosner-Glynn-Lee method", sep = " ")
            arglist <- setNames(list(x, cluster, alternative, mu, METHOD,
                                     DNAME, exact, B),
                                c("x", "cluster", "alternative",
                                  "mu",
                                  "METHOD", "DNAME",  "exact", "B"))
            result <- do.call("clusWilcox_test_signedrank_rgl", c(arglist))
            return(result)
        }
        if (method == "ds") {
            if (exact == TRUE & B == 0) {
                stop("Exact exactutation test is not available for 'ds' method.")
            }
            METHOD <- paste(METHOD, "using Datta-Satten method", sep = " ")
            arglist <- setNames(list(x, cluster, alternative, mu, exact, B, METHOD, DNAME),
                                c("x", "cluster", "alternative",
                                  "mu", "exact", "B", "METHOD", "DNAME"))

            result <-  do.call("clusWilcox_test_signedrank_ds",
                               c(arglist))
            return(result)
        }
        stop("Method should be one of 'rgl' and 'ds'.")
    } else { # else, paired = FALSE
        METHOD <- "Clustered Wilcoxon rank sum test"
        if (method == "rgl") {
            METHOD <- paste( METHOD, "using Rosner-Glynn-Lee method", sep = " ")
            arglist <- setNames(list(x, cluster, group, stratum,
                                     alternative, mu, DNAME,
                                     METHOD, exact, B),
                                c("x", "cluster", "group", "stratum",
                                  "alternative", "mu", "DNAME", "METHOD",
                                  "exact", "B"))
            result <- do.call("clusWilcox_test_ranksum_rgl", c(arglist))
            return(result)
        }
        if (method == "dd") {
            if (exact == TRUE & B == 0) {
                stop("Exact exactutation test is not available for 'dd' method.")
            }
            METHOD <- paste(METHOD, "using Dutta-Datta method.", sep = " ")
            arglist <- setNames(list(x, cluster, group, alternative, mu, exact, B, METHOD, DNAME),
                                c("x", "cluster", "group", "alternative",
                                  "mu", "exact", "B", "METHOD", "DNAME"))
            result <- do.call("clusWilcox_test_ranksum_dd", c(arglist))
            return(result)

        }
        if ((method) == "ds") {
            METHOD <- paste(METHOD, "using Datta-Satten method", sep = " ")
            arglist <- setNames(list(x, cluster, group, mu, alternative,
                                     DNAME, METHOD, exact, B),
                                c("x", "cluster", "group", "mu",
                                  "alternative", "DNAME", "METHOD", "exact", "B"))
            if (exact == TRUE & B == 0) {
                warning("Exact exactutation test is not available for 'ds' method. Will run the large-sample test.")
                exact <- FALSE
            }

            if (length(table(stratum)) > 1L) {
                warning("'stratum' will be ignored for the clustered rank sum test, 'ds' method")
            }
            result <- do.call("clusWilcox_test_ranksum_ds", c(arglist))
            return(result)
        }
        stop("Method should be one of 'rgl', 'dd' or 'ds'.")
    }
}
