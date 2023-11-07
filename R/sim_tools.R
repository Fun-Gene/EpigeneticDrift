get_p <- function(x, y, cov = NULL) {
  cor_p <- function(x, y) {
    if (length(x) != length(y)) {
      stop('Length differ!')
    }
    n <- length(x)
    corr <- sum((x - mean(x)) * (y - mean(y))) /
      sqrt(sum((x - mean(x)) ^ 2) * sum((y - mean(y)) ^ 2))
    t <- sqrt((n - 2) / (1 - corr ^ 2)) * corr
    return(2 * pt(abs(t), n - 2, lower.tail = F))
  }
  return(apply(x, 2, function(a) {cor_p(a, y)}))
}

res_abs <- function(y, x, cov = NULL, mode = 1) {
  x <- cbind(x, cov)
  if (!is.matrix(x)) {
    x <- as.matrix(x)
  }
  lm_fit <- function(y, x) {
    x1 <- cbind(rep(1, nrow(x)), x)
    param <- solve(t(x1) %*% x1) %*% t(x1) %*% y
    return(x1 %*% param)
  }
  return(apply(y, 2, function(a) {abs(a - lm_fit(a, x)) ^ mode}))
}

bp_test <- function(x, y, cov = NULL, mode = 1) {
  return(get_p(res_abs(x, y, cov = cov, mode = mode), y))
}
