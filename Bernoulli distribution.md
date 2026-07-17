---
aliases:
  - bernoulli distribution
  - bernoulli distributions
  - bernoulli
dateCreated: 2026-07-17 00:00:00
dateModified: 2026-07-17 00:00:00
tags: atom
title: Bernoulli distribution
units:
  - "[[CS229 Lecture 3]]"
---

# Bernoulli distribution

## Summary

The distribution of a single 0/1 outcome with success probability $\phi$. In [[Logistic regression]] the parameter is the hypothesis, $\phi = h_\theta(x)$:

$$p(y = 1 \mid x; \theta) = h_\theta(x), \qquad p(y = 0 \mid x; \theta) = 1 - h_\theta(x)$$

**Compressed into one equation** (the exponent trick):

$$p(y \mid x; \theta) = \left(h_\theta(x)\right)^{y}\left(1 - h_\theta(x)\right)^{1 - y}$$

The exponents act as on/off switches: if $y = 1$ it collapses to $h$; if $y = 0$ it collapses to $1 - h$ (anything to the power 0 is 1). This is the classification counterpart of the [[Gaussian distribution]] assumption that gave [[Linear regression]] its squared-error [[Cost function]]: feed it into the [[Maximum likelihood estimation]] recipe and out comes logistic regression.
