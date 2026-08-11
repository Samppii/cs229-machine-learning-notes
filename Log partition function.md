---
aliases:
  - log partition function
  - log partition functions
  - log-partition function
dateCreated: 2026-08-11 00:00:00
dateModified: 2026-08-11 00:00:00
tags: atom
title: Log partition function
up:
  - "[[Exponential family]]"
units:
  - "[[CS229 Lecture 4]]"
---

# Log partition function

## Summary

$a(\eta)$ - the piece of the [[Exponential family]] template that depends on the [[Natural parameter]] only. Pulling it out of the exponent shows what it is:

$$p(y;\eta) = \frac{b(y)\exp\left(\eta^T T(y)\right)}{\exp(a(\eta))}$$

The denominator is the **normalizing constant** (the "partition function") that makes the distribution integrate to 1, and $a(\eta)$ is its log.

**It stores the moments.** Differentiating it gives the mean and variance without doing any integral:

$$E[y;\eta] = \frac{\partial}{\partial\eta}a(\eta) \qquad \text{Var}(y;\eta) = \frac{\partial^2}{\partial\eta^2}a(\eta)$$

(For vector $\eta$ the second becomes the [[Hessian]].) Checked on the two derivations:

| distribution | $a(\eta)$ | $a'(\eta)$ | $a''(\eta)$ |
|---|---|---|---|
| [[Gaussian distribution\|Gaussian]] | $\eta^2/2$ | $\eta = \mu$ | $1 = \sigma^2$ |
| [[Bernoulli distribution\|Bernoulli]] | $\log(1 + e^\eta)$ | $\dfrac{1}{1+e^{-\eta}} = \phi$ | - |
| [[Poisson distribution\|Poisson]] | $e^\eta$ | $e^\eta = \lambda$ | - |

Note the [[Sigmoid function|sigmoid]] appearing a second time, now as a derivative rather than by inverting $\eta$ - two independent routes agreeing.

Two consequences: $a''(\eta) = \text{Var}(y) \geq 0$ gives [[Convexity]] for every member of the family, and $a'(\eta) = E[y]$ makes the derivative of $a$ the [[Canonical response function]] of a [[Generalized linear models|GLM]].
