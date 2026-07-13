---
aliases:
  - eigenvector
  - eigenvectors
dateCreated: 2026-07-13 00:00:00
dateModified: 2026-07-13 00:00:00
tags: atom
title: Eigenvector
up:
  - "[[Eigenvalue]]"
units:
  - "[[CS229 PS0 - Solutions]]"
---

# Eigenvector

## Summary

A nonzero vector $v$ that $A$ maps to a scalar multiple of itself:

$$Av = \lambda v$$

$A$ only **scales** $v$ (by its [[Eigenvalue]] $\lambda$), never rotates it - the direction of $v$ is preserved.

- When $A = T\Lambda T^{-1}$ is diagonalizable, the **columns of $T$ are the eigenvectors** (see [[Diagonalization]]).
- For symmetric $A = U\Lambda U^T$, the eigenvectors are **orthonormal** - the columns of the [[Orthogonal Matrix]] $U$ (the [[Spectral Theorem]]).

Worked in [[CS229 PS0 - Solutions]] Problem 3.
