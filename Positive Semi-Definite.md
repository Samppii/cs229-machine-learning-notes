---
aliases:
  - positive semi-definite
  - positive semidefinite
  - PSD
  - psd
dateCreated: 2026-07-13 00:00:00
dateModified: 2026-07-13 00:00:00
tags: atom
title: Positive Semi-Definite
up:
  - "[[Quadratic Form]]"
units:
  - "[[CS229 PS0 - Solutions]]"
---

# Positive Semi-Definite

## Summary

A matrix $A$ is **PSD** ($A \succeq 0$) if:

1. $A$ is **symmetric** ($A = A^T$), and
2. $x^TAx \ge 0$ for **every** $x$ (the [[Quadratic Form]] never goes negative).

- The matrix version of "$x^2 \ge 0$." **Positive definite (PD)** is stricter: $x^TAx > 0$ for all $x \ne 0$ (never touches $0$). "Semi" = zero allowed.
- **PSD $\iff$ all [[Eigenvalue]]s $\ge 0$** (PD $\iff$ all eigenvalues $> 0$).
- **Proof trick for "show $M$ is PSD":** compute $x^TMx$ and show it is a square (or sum of squares). E.g. $x^T(zz^T)x = (x^Tz)^2 \ge 0$.

**ML link:** a PSD [[Hessian]] means a convex cost (see [[Convexity]]) - a bowl with one global minimum, which is why gradient descent works. See [[CS229 Math Cheatsheet#7. PSD (positive semi-definite)|cheat sheet §7]]. Worked in [[CS229 PS0 - Solutions]] Problem 2.
