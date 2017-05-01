callHestoncf <- function(S,X,tau,r,q,v0,vT,rho,k,sigma)
{
	# callHestoncf Pricing function for European calls
	# ---
	# S     = spot
	# X     = strike
	# tau   = time to mat
	# r     = riskfree rate
	# q     = dividend yield
	# v0    = initial variance
	# vT    = long run variance (theta in Heston's paper)
	# rho   = correlation
	# k     = speed of mean reversion (kappa in Heston's paper)
	# sigma = vol of vol
	# ---
	# Manfred Gilli and Enrico Schumann, version 2010-02-05
	# http://comisef.eu
	#
	
	# -- functions --
	P1 <- function(om,S,X,tau,r,q,v0,vT,rho,k,sigma)
	{
		i <- 1i
		p <- Re(exp(-i*log(X)*om) * cfHeston(om-i,S,tau,r,q,v0,vT,rho,k,sigma) / (i * om * S * exp((r-q) * tau)))
		return(p)
	}
	P2 <- function(om,S,X,tau,r,q,v0,vT,rho,k,sigma)
	{
		i <- 1i
		p <- Re(exp(-i*log(X)*om) * cfHeston(om  ,S,tau,r,q,v0,vT,rho,k,sigma) / (i * om))
		return(p)
	}
	cfHeston <- function(om,S,tau,r,q,v0,vT,rho,k,sigma)
	{
		d   <- sqrt((rho * sigma * 1i*om - k)^2 + sigma^2 * (1i*om + om ^ 2))
		g2  <- (k - rho*sigma*1i*om - d) / (k - rho*sigma*1i*om + d)
		cf1 <- 1i*om * (log(S) + (r - q) * tau)
		cf2 <- vT * k / (sigma^2) * ((k - rho*sigma*1i*om - d) * tau - 2 * log((1 - g2 * exp(-d * tau)) / (1 - g2)))
		cf3 <- v0 / sigma^2 * (k - rho*sigma*1i*om - d) * (1 - exp(-d * tau)) / (1 - g2 * exp(-d * tau))
		cf  <- exp(cf1 + cf2 + cf3)
		return(cf)
	}
	# -- pricing --
	vP1 <- 0.5 + 1/pi * integrate(P1,lower=0,upper=200,S,X,tau,r,q,v0,vT,rho,k,sigma)$value
	vP2 <- 0.5 + 1/pi * integrate(P2,lower=0,upper=200,S,X,tau,r,q,v0,vT,rho,k,sigma)$value
	call <- exp(-q * tau) * S * vP1 - exp(-r * tau) * X * vP2;
	return(call)
}
