---
aliases:
  - poisson distribution
  - poisson distributions
  - poisson
dateCreated: 2026-08-11 00:00:00
dateModified: 2026-08-11 00:00:00
tags: atom
title: Poisson distribution
units:
  - "[[CS229 Lecture 4]]"
---

# Poisson distribution

## Summary

The distribution over **counts** (non-negative integers) with rate $\lambda$:

$$p(y;\lambda) = \frac{e^{-\lambda}\lambda^{y}}{y!}$$

**In [[Exponential family]] form.** Products and powers with no exp, so use the Bernoulli route - wrap in $\exp(\log(\cdot))$:

$$p(y;\lambda) = \frac{1}{y!}\exp\left(y\log\lambda - \lambda\right)$$

Read off $b(y) = 1/y!$, $T(y) = y$, [[Natural parameter|$\eta$]] $= \log\lambda$, and - after inverting to $\lambda = e^\eta$ - the [[Log partition function]] $a(\eta) = e^\eta$. Since $a'(\eta) = e^\eta = \lambda = E[y]$, the [[Generalized linear models|GLM]] built on it (**Poisson regression**) has hypothesis

$$h_\theta(x) = e^{\theta^T x}$$

Use it whenever $y$ is a count: website visitors per hour, customers per day, photons per interval. Worked in PS1 Problem 3.
