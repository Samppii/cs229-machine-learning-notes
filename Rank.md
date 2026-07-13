---
aliases:
  - rank
  - ranks
dateCreated: 2026-07-13 00:00:00
dateModified: 2026-07-13 00:00:00
tags: atom
title: Rank
units:
  - "[[CS229 PS0 - Solutions]]"
---

# Rank

## Summary

The rank of $A$ is the **dimension of its output space** (the span of its columns) - how many independent directions the matrix can reach.

- An [[Outer Product]] $zz^T$ has rank $1$: every output $Ax = z(z^Tx)$ is a multiple of the single vector $z$, so all outputs lie on one line.
- Tied to the [[Null Space]] by the [[Rank-Nullity Theorem]]: $\operatorname{rank}(A) + \dim(\operatorname{null}(A)) = n$.

Worked in [[CS229 PS0 - Solutions]] Problem 2(b).
