---
aliases:
  - natural parameter
  - natural parameters
  - eta
dateCreated: 2026-08-11 00:00:00
dateModified: 2026-08-11 00:00:00
tags: atom
title: Natural parameter
up:
  - "[[Exponential family]]"
units:
  - "[[CS229 Lecture 4]]"
---

# Natural parameter

## Summary

$\eta$ - the parameter a distribution is written in terms of once it is put in [[Exponential family]] form $p(y;\eta) = b(y)\exp(\eta^T T(y) - a(\eta))$. Scalar for every distribution in CS229.

It is **not** the parameter the distribution is usually stated with. Each family has a **canonical parameter** ($\phi$ for [[Bernoulli distribution|Bernoulli]], $\mu$ for [[Gaussian distribution|Gaussian]], $\lambda$ for [[Poisson distribution|Poisson]]) and the derivation produces a formula linking the two:

| family | $\eta$ in terms of the canonical parameter | inverted |
|---|---|---|
| Gaussian | $\eta = \mu$ | identity |
| Bernoulli | $\eta = \log\dfrac{\phi}{1-\phi}$ (the log-odds) | $\phi = \dfrac{1}{1 + e^{-\eta}}$, the [[Sigmoid function\|sigmoid]] |
| Poisson | $\eta = \log\lambda$ | $\lambda = e^\eta$ |

Inverting the Bernoulli relation is where the [[Sigmoid function]] comes from: it was pulled out of thin air in [[CS229 Lecture 3]], and here it just falls out of the algebra. Nobody chose it.

In a [[Generalized linear models|GLM]] the natural parameter is the bridge between the linear model and the distribution: $\eta = \theta^T x$ by assumption, and $\eta$ then determines the canonical parameter via the [[Canonical response function]].
