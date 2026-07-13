---
aliases:
  - quadratic form
  - quadratic forms
dateCreated: 2026-07-13 00:00:00
dateModified: 2026-07-13 00:00:00
tags: atom
title: Quadratic Form
units:
  - "[[CS229 PS0 - Solutions]]"
---

# Quadratic Form

## Summary

An expression $x^TAx$ (row times matrix times column) that collapses to a **single scalar**:

$$x^TAx = \sum_i \sum_j A_{ij}x_ix_j$$

- Two indices, so it expands to a **double sum**. Rule of thumb: more matrices in the sandwich = more sigmas.
- The related one-matrix case $b^Tx = \sum_i b_ix_i$ (a dot product) is a single sum.
- Shapes: $x^Tz$ = scalar, but $zz^T$ = matrix (an [[Outer Product]]). Order matters.

The quadratic form is the object [[Positive Semi-Definite]] tests ($x^TAx \ge 0$), and it is what you expand to take a [[Partial Derivative]]. Worked in [[CS229 PS0 - Solutions]] Problems 1 and 2.
