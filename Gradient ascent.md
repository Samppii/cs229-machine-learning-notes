---
aliases:
  - gradient ascent
  - gradient ascents
dateCreated: 2026-07-17 00:00:00
dateModified: 2026-07-17 00:00:00
tags: atom
up:
  - "[[Gradient descent]]"
units:
  - "[[CS229 Lecture 3]]"
title: Gradient ascent
---

# Gradient ascent

## Summary

[[Gradient descent]] run **uphill** - used when the goal is to **maximize** an objective (as in [[Maximum likelihood estimation]]) rather than minimize a cost. The only change is the sign: a **plus** instead of a minus.

$$\theta_j := \theta_j + \alpha \frac{\partial}{\partial \theta_j}\ell(\theta)$$

For [[Logistic regression]] (using $g'(z) = g(z)(1 - g(z))$) this works out to:

$$\theta_j := \theta_j + \alpha \sum_{i=1}^{m}\left(y^{(i)} - h_\theta(x^{(i)})\right)x_j^{(i)}$$

- Same **(error) x (feature)** shape as the [[Linear regression]] descent update (a preview of generalized linear models).
- Like descent, it takes many small steps; [[Newton's method]] is a faster alternative when the parameter count is small.
