---
aliases:
  - gradient
  - gradients
dateCreated: 2026-07-13 00:00:00
dateModified: 2026-07-13 00:00:00
tags: atom
title: Gradient
up:
  - "[[Partial Derivative]]"
units:
  - "[[CS229 PS0 - Solutions]]"
---

# Gradient

## Summary

$\nabla f$ is the **vector of first [[Partial Derivative]]s** of $f$: differentiate $f$ once with respect to each variable and stack the results into a column vector (shape $n\times 1$).

- Geometric reading: "which way is uphill" - it points in the direction of steepest increase.
- Shortcut formulas (see [[CS229 Math Cheatsheet#5. THE SHORTCUT FORMULAS (memorize - use freely)|cheat sheet §5]]): $\nabla(b^Tx) = b$, $\nabla(x^Tx) = 2x$, $\nabla(\tfrac{1}{2}x^TAx) = Ax$ for symmetric $A$.

Its own derivative (differentiated again) is the [[Hessian]]. The gradient drives [[Gradient descent]]. Worked in [[CS229 PS0 - Solutions]] Problem 1.
