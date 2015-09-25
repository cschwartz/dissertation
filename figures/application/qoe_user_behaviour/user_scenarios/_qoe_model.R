q1 <- function(L, N, alpha, beta, a = 3.5, b = 1.5) {
  unclamped <- a * exp((-alpha *L + -beta) * N) + b
  pmin(5, pmax(1, unclamped))
}

q2 <- function(T0, gamma, c = 5.381) {
  unclamped <- -gamma * log10(T0 + c) + gamma * log10(c) + 1
  pmin(1, pmax(0, unclamped)) * 4 + 1
}

qoe <- function(L, N, T0, alpha, beta, gamma) {
  unclamped <- (q1(L, N, alpha, beta) - 0.5)/4.5*5 + q2(T0, gamma) - 5
  pmax(1, unclamped)
}

qoe.infinite <- function(B, a, lambda, alpha, beta, gamma) {
  mu <- lambda / a
  d <- B * mu
  
  L <- B / a
  T0 <- L
  N <- (mu - lambda) / d
  
  qoe(L, N * 30, T0, alpha, beta, gamma)
}

qoe.finite <- function(B, a, lambda, T, alpha, beta, gamma) {
  mu <- lambda / a
  d <- B * mu
  
  L <- B / a
  T0 <- L
  N <- floor(T * ((mu - lambda)/d)) / T
  
  qoe(L, N * 30, T0, alpha, beta, gamma)
}