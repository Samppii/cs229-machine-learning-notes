---
aliases:
  - spectral theorem
dateCreated: 2026-07-13 00:00:00
dateModified: 2026-07-13 00:00:00
tags: atom
title: Spectral Theorem
up:
  - "[[Diagonalization]]"
units:
  - "[[CS229 PS0 - Solutions]]"
---

# Spectral Theorem

## Summary

Every **symmetric** matrix $A$ can be diagonalized by an [[Orthogonal Matrix]]:

$$A = U\Lambda U^T, \qquad U^TU = I$$

- The [[Eigenvalue]]s (in $\Lambda$) are **real** and the [[Eigenvector]]s (columns of $U$) are **orthonormal**.
- It is the [[Diagonalization]] $A = T\Lambda T^{-1}$ with the bonus that $T = U$ is orthogonal, so $T^{-1} = U^T$ - no inverse to compute.
- Combined with $x^TAx \ge 0$ it gives the clean result that a [[Positive Semi-Definite]] matrix has all eigenvalues $\ge 0$ (PS0 3(c)).

Worked in [[CS229 PS0 - Solutions]] Problem 3(b)-(c).
