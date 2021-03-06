#' Compare two correlation coefficients obtained from different sample sizes
#'
#' @description The function compares two correlation coefficients obtained from
#' different sample sizes using Z-Fisher transformation.
#'
#' @param data An object of class \code{data.frame} with at least 4 columns
#' of data used to perform the test.
#' 4 columns must be called "n1", "n2", "r1" and "r2".
#' \itemize{
#' \item{n1 and n2 are the sizes of the samples from which r1 and r2
#' were computed respectively.}
#' \item{r1 and r2 are Pearson's correlation coefficients}
#' }
#' @details The Z-Fisher method consists in computing z scores from the
#' correlation coefficients and to compare these z scores.
#' z scores are computed as follows :
#' Let n1 and r1 be the sample size and the correlation coefficient,
#' z1 = (1/2)*log( (1+r1) / (1-r1) )
#' Then, a test's statistic is computed from z1 and z2 :
#' Z = (z1-z2) / sqrt( (1/(n1-3)) + (1/(n2-3)))
#' If Z is above the limit given by the alpha value, then the difference between
#' r1 and r2 is significant
#' @return An object of class \code{data.frame} with the same columns as 'data'
#' and 4 columns more : z1, z2 (respective z-scores), Z (test's statistic) and
#' p (p-value) of the test.
#' @export
#' @author P. Savary
#' @examples
#' df <- data.frame(n1 = rpois(n = 40, lambda = 85),
#'                  n2 = rpois(n = 40, lambda = 60),
#'                  r1 = runif(n = 40, min = 0.6, max = 0.85),
#'                  r2 = runif(n = 40, min = 0.55, max = 0.75))
#' data <- compar_r_fisher(df)


compar_r_fisher <- function(data){
  data$z1 <- (1/2)*log( (1+data$r1) / (1-data$r1) )
  data$z2 <- (1/2)*log( (1+data$r2) / (1-data$r2) )
  data$Z <- (data$z1 - data$z2) / sqrt( ( 1/(data$n1 - 3) ) +
                                          ( 1/(data$n2 - 3) ))
  data$p <- (2*(1-stats::pnorm(abs(data$Z))))

  return(data)
}


