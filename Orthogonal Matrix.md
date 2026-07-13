---
aliases:
  - orthogonal matrix
  - orthogonal matrices
dateCreated: 2026-07-13 00:00:00
dateModified: 2026-07-13 00:00:00
tags: atom
title: Orthogonal Matrix
units:
  - "[[CS229 PS0 - Solutions]]"
---

# Orthogonal Matrix

## Summary

A square matrix $U$ whose columns are **orthonormal** (unit length and mutually perpendicular), equivalently

$$U^TU = I \quad\Longleftrightarrow\quad U^T = U^{-1}$$

- The inverse is free - it is just the transpose. This is what makes the [[Spectral Theorem]] form $A = U\Lambda U^T$ the same as the [[Diagonalization]] form $A = U\Lambda U^{-1}$.
- Geometrically it is a rotation/reflection: it preserves lengths and angles.
- Because each column $u^{(i)}$ is a unit vector, $(u^{(i)})^Tu^{(i)} = 1$ - the fact that makes PS0 3(c) collapse to $\lambda_i$.

Worked in [[CS229 PS0 - Solutions]] Problem 3(b)-(c).
