---
aliases:
  - eigenvalue
  - eigenvalues
dateCreated: 2026-07-13 00:00:00
dateModified: 2026-07-13 00:00:00
tags: atom
title: Eigenvalue
units:
  - "[[CS229 PS0 - Solutions]]"
---

# Eigenvalue

## Summary

A scalar $\lambda$ for which some nonzero [[Eigenvector]] $v$ satisfies

$$Av = \lambda v$$

i.e. $A$ **stretches $v$ by the factor $\lambda$ with no rotation**.

- Found via the characteristic polynomial $\det(\lambda I - A) = 0$.
- **PSD link:** $A$ is [[Positive Semi-Definite]] $\iff$ all eigenvalues $\ge 0$ (PD $\iff$ all $> 0$).
- For a symmetric $A$ the eigenvalues are real and the eigenvectors orthogonal (the [[Spectral Theorem]]).

**ML payoff:** PCA uses the eigenvalues/eigenvectors of the covariance matrix. See [[CS229 Math Cheatsheet#8. Eigenvalues (Problem 3 preview)|cheat sheet §8]]. Worked in [[CS229 PS0 - Solutions]] Problem 3.
