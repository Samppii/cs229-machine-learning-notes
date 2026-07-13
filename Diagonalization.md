---
aliases:
  - diagonalization
  - diagonalizations
  - diagonalizable
dateCreated: 2026-07-13 00:00:00
dateModified: 2026-07-13 00:00:00
tags: atom
title: Diagonalization
up:
  - "[[Eigenvalue]]"
units:
  - "[[CS229 PS0 - Solutions]]"
---

# Diagonalization

## Summary

Writing a matrix as

$$A = T\Lambda T^{-1}$$

where $\Lambda$ is **diagonal** (holding the [[Eigenvalue]]s) and the columns of $T$ are the corresponding [[Eigenvector]]s.

- **Why the columns are eigenvectors:** right-multiply by $T$ to get $AT = T\Lambda$; reading column $i$ gives $At^{(i)} = \lambda_i t^{(i)}$ (right-multiplying by a diagonal matrix scales each column).
- The symmetric case sharpens this to $A = U\Lambda U^T$ with $U$ an [[Orthogonal Matrix]] - the [[Spectral Theorem]].

Worked in [[CS229 PS0 - Solutions]] Problem 3(a).
