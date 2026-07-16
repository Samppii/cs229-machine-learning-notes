---
aliases:
  - bandwidth
  - bandwidths
  - tau
dateCreated: 2026-07-16 00:00:00
dateModified: 2026-07-16 00:00:00
tags: atom
title: Bandwidth
up:
  - "[[Locally weighted regression]]"
units:
  - "[[CS229 Lecture 3]]"
---

# Bandwidth

## Summary

The hyperparameter $\tau$ in [[Locally weighted regression]] - it sets **how wide** the weighting bell is, i.e. how large a neighborhood around the prediction point $x$ actually counts:

$$w^{(i)} = \exp\left(-\frac{(x^{(i)} - x)^2}{2\tau^2}\right)$$

- **Big $\tau$** = wide neighborhood = more examples counted = **smoother** fit (risk: oversmoothing / underfitting).
- **Small $\tau$** = narrow neighborhood = few examples counted = **jagged** fit (risk: overfitting).

It plays the same role for LWR that the [[Learning rate]] plays for [[Gradient descent]]: a dial you tune rather than learn. Tuned in PS1.
