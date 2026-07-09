---
aliases:
  - hypothesis
  - hypotheses
dateCreated: 2026-07-08 00:00:00
dateModified: 2026-07-08 00:00:00
tags: atom
title: Hypothesis
up:
  - "[[Linear regression]]"
units:
  - "[[CS229 Lecture 2]]"
---

# Hypothesis

## Summary

The **model** — the function $h$ that maps inputs to a predicted output. For [[Linear regression]] it's linear (technically affine) in the [[Features]]. Three **equivalent** forms — same equation, three costumes:

- One feature: $h(x) = \theta_0 + \theta_1 x_1$ (a line).
- Two features ($x_1$ = size, $x_2$ = #bedrooms): $h(x) = \theta_0 + \theta_1 x_1 + \theta_2 x_2$.
- Define a dummy feature $x_0 = 1$ and compress to a dot product:
$$h(x) = \sum_{j=0}^{n} \theta_j x_j = \theta^T x$$

So *expanded → sigma → vector* all say the same thing. $\theta$ and $x$ are both $(n+1)$-dimensional vectors.

## Intercept vs. weights

- $\theta_0$ = **baseline / intercept** — no feature attached (that's what $x_0 = 1$ buys you).
- $\theta_1, \theta_2, \dots$ = **weights**, one per feature. Each weight's sign + magnitude = the direction and strength of that feature's effect.

The learning problem is: pick the $\theta$ that makes $h(x) \approx y$ across the training set — made precise by the [[Cost function]].
