---
aliases:
  - learning rate
  - learning rates
dateCreated: 2026-07-08 00:00:00
dateModified: 2026-07-08 00:00:00
tags: atom
title: Learning rate
up:
  - "[[Gradient descent]]"
units:
  - "[[CS229 Lecture 2]]"
---

# Learning rate

## Summary

$\alpha$ - the **step size** in the [[Gradient descent]] update $\theta_j := \theta_j - \alpha \frac{\partial}{\partial \theta_j} J(\theta)$. It scales how far each step moves.

- **Too large** → overshoots the minimum; $J(\theta)$ can even *increase* and diverge.
- **Too small** → converges, but slowly (many tiny steps).
- **In practice** - try values around $0.01$, searching on a roughly doubling scale ($\dots, 0.001, 0.003, 0.01, 0.03, 0.1, \dots$).

It's a **hyperparameter**: you set it, the algorithm doesn't learn it.
