---
aliases:
  - null space
  - null spaces
  - nullspace
  - kernel
dateCreated: 2026-07-13 00:00:00
dateModified: 2026-07-13 00:00:00
tags: atom
title: Null Space
units:
  - "[[CS229 PS0 - Solutions]]"
---

# Null Space

## Summary

The null space of $A$ is the set of vectors it sends to zero:

$$\operatorname{null}(A) = \{x : Ax = 0\}$$

- Its dimension is the **nullity**. For $A = zz^T$ ($z \ne 0$), $Ax = 0 \iff z^Tx = 0$, so the null space is everything **perpendicular to $z$** - an $(n-1)$-dimensional subspace.
- Tied to [[Rank]] by the [[Rank-Nullity Theorem]]: $\operatorname{rank}(A) + \dim(\operatorname{null}(A)) = n$.

Worked in [[CS229 PS0 - Solutions]] Problem 2(b).
