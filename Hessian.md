---
aliases:
  - hessian
  - hessians
dateCreated: 2026-07-13 00:00:00
dateModified: 2026-07-13 00:00:00
tags: atom
title: Hessian
up:
  - "[[Gradient]]"
units:
  - "[[CS229 PS0 - Solutions]]"
---

# Hessian

## Summary

$\nabla^2 f$ is the **matrix of second [[Partial Derivative]]s** (shape $n\times n$): differentiate the [[Gradient]] again. Entry $(i,j) = \partial^2 f / \partial x_i \partial x_j$, and it is symmetric.

- Geometric reading: **curvature** - how the slope changes ("the derivative of the gradient").
- For $f(x) = \tfrac{1}{2}x^TAx + b^Tx$ the Hessian is the constant matrix $A$ (the $b$ term is flat, so it contributes $0$).

**ML payoff:** a [[Positive Semi-Definite]] Hessian means the function is convex - a bowl with one global minimum (see [[Convexity]]). Worked in [[CS229 PS0 - Solutions]] Problem 1.
