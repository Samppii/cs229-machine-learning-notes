---
aliases:
  - batch gradient descent
  - batch gradient descents
  - batch gd
dateCreated: 2026-07-09 00:00:00
dateModified: 2026-07-09 00:00:00
tags: atom
title: Batch gradient descent
up:
  - "[[Gradient descent]]"
units:
  - "[[CS229 Lecture 2]]"
---

# Batch gradient descent

## Summary

The plain form of [[Gradient descent]]: sum the single-example gradient over **all** $m$ training examples, then take one step. (Derivative of a sum = sum of derivatives.) Repeat until convergence, for all $j$:

$$\theta_j := \theta_j - \alpha \sum_{i=1}^{m}\left(h_\theta(x^{(i)}) - y^{(i)}\right)x_j^{(i)}$$

"**Batch**" = every step processes the **entire** training set as one batch. The $\sum_{i=1}^{m}$ means a single step reads all $m$ examples.

## Trade-off

- **Upside:** each step uses the full dataset → the true, accurate downhill direction → a smooth path that converges and settles. See [[Convexity]] for why it lands on the global minimum.
- **Downside — slow on large data:** to take even *one* step you must scan all $m$ examples. With millions of examples or terabytes of data this is prohibitive (Ng: you might never finish a single step).

This cost is exactly what [[Stochastic gradient descent]] and [[Mini-batch gradient descent]] trade accuracy to avoid.
