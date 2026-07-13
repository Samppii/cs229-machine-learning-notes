---
aliases:
  - outer product
  - outer products
dateCreated: 2026-07-13 00:00:00
dateModified: 2026-07-13 00:00:00
tags: atom
title: Outer Product
units:
  - "[[CS229 PS0 - Solutions]]"
---

# Outer Product

## Summary

$zz^T$ - a column vector times a row vector - produces an $n\times n$ **matrix** (entry $(i,j) = z_iz_j$). Contrast with the inner product $z^Tz$, which is a scalar. **Order matters:** $a^Ta$ is a number, $aa^T$ is a matrix.

- Any outer product $zz^T$ has [[Rank]] $1$ (every column is a multiple of $z$).
- It is what turns two stray vectors into a proper matrix - e.g. the [[Hessian]] $g''(a^Tx)\,aa^T$ in PS0 1(d), or the [[Positive Semi-Definite]] matrix $zz^T$ in PS0 2(a).

Worked in [[CS229 PS0 - Solutions]] Problems 1(d) and 2.
