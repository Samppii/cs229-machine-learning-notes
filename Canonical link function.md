---
aliases:
  - canonical link function
  - canonical link functions
  - link function
dateCreated: 2026-08-11 00:00:00
dateModified: 2026-08-11 00:00:00
tags: atom
title: Canonical link function
up:
  - "[[Generalized linear models]]"
units:
  - "[[CS229 Lecture 4]]"
---

# Canonical link function

## Summary

$g^{-1}$ - the inverse of the [[Canonical response function]], mapping the **mean back to the [[Natural parameter]]**: it is the formula for $\eta$ that falls out when a distribution is massaged into [[Exponential family]] form.

| distribution | link ($\text{mean} \to \eta$) | response ($\eta \to \text{mean}$) |
|---|---|---|
| [[Gaussian distribution\|Gaussian]] | $\eta = \mu$ (identity) | identity |
| [[Bernoulli distribution\|Bernoulli]] | $\eta = \log\dfrac{\phi}{1-\phi}$ (log-odds) | [[Sigmoid function\|sigmoid]] |
| [[Poisson distribution\|Poisson]] | $\eta = \log\lambda$ | $e^\eta$ |

Easy to mix up with the response function: **link goes from the distribution's own parameter to $\eta$; response goes the other way** and is the one you actually use to build $h_\theta(x)$ in a [[Generalized linear models|GLM]].
