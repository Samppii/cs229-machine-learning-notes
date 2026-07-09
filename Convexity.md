---
aliases:
  - convexity
  - convex
  - convex function
dateCreated: 2026-07-08 00:00:00
dateModified: 2026-07-08 00:00:00
tags: atom
title: Convexity
up:
  - "[[Gradient descent]]"
units:
  - "[[CS229 Lecture 2]]"
---

# Convexity

## Summary

A property of the [[Cost function]] that makes optimization easy. For [[Linear regression]], $J(\theta)$ is a **sum of squares** → **convex** → a single bowl with **no local optima** (the only optimum is the global one).

**Consequence:** [[Gradient descent]] always converges to the **global** minimum, regardless of where $\theta$ is initialized (zeros or random — doesn't matter). It still needs a sane [[Learning rate]] to converge at all.

## Two views of the same descent

- **Contour plot** (top-down): nested ellipses; outer rings = high cost, center = global min. Gradient descent spirals inward, and each step crosses its contour at $90°$ (perpendicular).
- **Data plot**: the [[Hypothesis]] line starts flat ($\theta = 0$ → predicts $0$ everywhere) and rotates/shifts to fit the houses better each iteration until it settles.
- Moving in weight-space (dot → center) **is** the line improving in data-space — same event, two angles.

## Caveat

This friendliness is special to linear regression. **Neural networks are non-convex** — a lumpy surface with multiple local optima — so none of the "any starting point works" guarantee carries over.
