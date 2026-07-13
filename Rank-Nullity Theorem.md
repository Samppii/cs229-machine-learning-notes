---
aliases:
  - rank-nullity theorem
  - rank-nullity
  - rank nullity theorem
dateCreated: 2026-07-13 00:00:00
dateModified: 2026-07-13 00:00:00
tags: atom
title: Rank-Nullity Theorem
up:
  - "[[Rank]]"
units:
  - "[[CS229 PS0 - Solutions]]"
---

# Rank-Nullity Theorem

## Summary

For $A$ acting on $\mathbb{R}^n$, the [[Rank]] and the dimension of the [[Null Space]] always add up to $n$:

$$\operatorname{rank}(A) + \dim(\operatorname{null}(A)) = n$$

- Intuition: every input dimension either gets **collapsed to zero** (counted by the nullity) or **survives into the output** (counted by the rank). No dimension is lost or double-counted.
- Handy as a consistency check: for $A = zz^T$, $\operatorname{rank} = 1$ and $\dim(\operatorname{null}) = n-1$, and $1 + (n-1) = n$. ✓

Worked in [[CS229 PS0 - Solutions]] Problem 2(b).
