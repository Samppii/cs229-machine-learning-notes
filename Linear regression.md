---
aliases:
  - linear regression
  - linear regressions
dateCreated: 2026-07-08 00:00:00
dateModified: 2026-07-08 00:00:00
tags: atom
title: Linear regression
up:
  - "[[Regression]]"
units:
  - "[[CS229 Lecture 2]]"
---

# Linear regression

## Summary

The first learning algorithm in the course: fit a **linear** [[Hypothesis]] to continuous data. Running example — predict house **price** from house **size** (real Portland, OR Craigslist dataset, $m = 49$ examples, sq ft → price in \$1000s). The training set feeds a learning algorithm that outputs a hypothesis $h$, which maps a new house's size to a predicted price.

An ML algorithm decomposes into three separable roles:

| role | here |
| --- | --- |
| **model** | the [[Hypothesis]] $h(x)$ |
| **objective** | the [[Cost function]] $J(\theta)$ |
| **optimizer** | [[Gradient descent]] (finds the best $\theta$) |

The optimizer is **not** part of the algorithm — it's a general tool. Proof: the *normal equations* (later) solve this **same** linear regression with no gradient descent at all. Learn the optimizer once here, reuse it for logistic regression, neural nets, etc.

## Notation (recurs all quarter)

- $\theta$ = **parameters / weights** (the whole vector); $\theta_j$ = one weight.
- $m$ = number of training examples (rows); $n$ = number of features (columns).
- $x$ = inputs / features; $y$ = output / target.
- $(x^{(i)}, y^{(i)})$ = the $i$-th training example. **Superscript $(i)$ = row** (which house), **subscript = column** (which feature). The superscript is an index, **not** exponentiation. E.g. $x_1^{(2)} = 1416$.
