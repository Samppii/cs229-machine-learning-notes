---
aliases:
  - canonical response function
  - canonical response functions
  - response function
dateCreated: 2026-08-11 00:00:00
dateModified: 2026-08-11 00:00:00
tags: atom
title: Canonical response function
up:
  - "[[Generalized linear models]]"
units:
  - "[[CS229 Lecture 4]]"
---

# Canonical response function

## Summary

The map $g$ taking the [[Natural parameter]] to the mean of the distribution: $g(\eta) = E[y; \eta]$. It is the second arrow in a [[Generalized linear models|GLM]]'s chain of three parameterizations:

$$\theta \;\xrightarrow{\;\theta^T x\;}\; \eta \;\xrightarrow{\;g\;}\; \text{canonical parameter } (\phi, \mu, \lambda)$$

The first arrow is a design choice; this second one is **determined by the distribution** - you do not get to pick it. Concretely it is the derivative of the [[Log partition function]]:

$$g(\eta) = \frac{\partial}{\partial\eta}a(\eta)$$

Examples: identity for the [[Gaussian distribution|Gaussian]] ($\mu = \eta$, which is why linear regression's hypothesis is a bare $\theta^T x$ with no wrapper), the [[Sigmoid function|sigmoid]] for the [[Bernoulli distribution|Bernoulli]], and $e^\eta$ for the [[Poisson distribution|Poisson]]. Its inverse is the [[Canonical link function]].
