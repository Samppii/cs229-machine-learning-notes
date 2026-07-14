---
aliases:
  - design matrix
  - design matrices
dateCreated: 2026-07-09 00:00:00
dateModified: 2026-07-09 00:00:00
tags: atom
title: Design matrix
up:
  - "[[Normal equations]]"
units:
  - "[[CS229 Lecture 2]]"
---

# Design matrix

## Summary

The matrix $X$ that stacks every training input $x^{(i)T}$ as a **row** - an $m \times (n+1)$ matrix (the $+1$ is the intercept feature). It's the vectorized packaging that lets the whole training set be written as one matrix expression instead of a sum over examples.

With $X$ built, all $m$ predictions are a single matrix–vector product $X\theta$, and the labels are the column vector $y$. That compactness is what makes the [[Normal equations]]' matrix form - $J(\theta) = \tfrac{1}{2}(X\theta - y)^T(X\theta - y)$ - and its closed-form solution $\theta = (X^T X)^{-1} X^T y$ possible.

- **Rows = examples** (superscript $(i)$), **columns = features** (subscript $j$) - the same [[Linear regression]] notation, now assembled into one object.
