---
aliases:
  - sigmoid function
  - sigmoid functions
  - sigmoid
  - logistic function
dateCreated: 2026-07-17 00:00:00
dateModified: 2026-07-17 00:00:00
tags: atom
title: Sigmoid function
up:
  - "[[Logistic regression]]"
units:
  - "[[CS229 Lecture 3]]"
---

# Sigmoid function

## Summary

The **sigmoid** (a.k.a. **logistic**) function - the S-shaped squashing function at the heart of [[Logistic regression]]:

$$g(z) = \frac{1}{1 + e^{-z}}$$

- Output always in $(0, 1)$; crosses $0.5$ at $z = 0$; asymptotes to $1$ as $z \to +\infty$ and to $0$ as $z \to -\infty$.
- Passing $\theta^T x$ through it bounds the hypothesis to $(0, 1)$ so it reads as a probability.
- **Useful derivative property** (used in the gradient derivation): $g'(z) = g(z)\left(1 - g(z)\right)$.

Many functions map to $(0, 1)$; the sigmoid is chosen because it falls out of the broader class of **generalized linear models** (GLMs), covered next lecture.
