---
aliases:
  - cross-entropy
  - cross entropy
  - cross-entropies
dateCreated: 2026-07-17 00:00:00
dateModified: 2026-07-17 00:00:00
tags: atom
title: Cross-entropy
up:
  - "[[Logistic regression]]"
units:
  - "[[CS229 Lecture 3]]"
---

# Cross-entropy

## Summary

The objective for [[Logistic regression]] - the log-likelihood of the [[Bernoulli distribution]] model, which is the cross-entropy up to sign:

$$\ell(\theta) = \sum_{i=1}^{m}\left[\, y^{(i)}\log h_\theta(x^{(i)}) + \left(1 - y^{(i)}\right)\log\left(1 - h_\theta(x^{(i)})\right)\right]$$

It falls out of [[Maximum likelihood estimation]] on a Bernoulli model exactly the way minus-squared-error fell out of MLE on a [[Gaussian distribution]] for [[Linear regression]]. We **maximize** it (via [[Gradient ascent]] or [[Newton's method]]); it is concave, so there is a single global maximum.
