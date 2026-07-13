---
aliases:
  - partial derivative
  - partial derivatives
dateCreated: 2026-07-13 00:00:00
dateModified: 2026-07-13 00:00:00
tags: atom
title: Partial Derivative
units:
  - "[[CS229 PS0 - Solutions]]"
---

# Partial Derivative

## Summary

$\partial/\partial x_k$ means **differentiate with respect to $x_k$ while treating every other variable as a constant**. Same rules as an ordinary derivative (power rule, etc.) plus one instruction: freeze the others.

- $\partial$ (curly) = partial, used when a function has several inputs; $d$ (straight) = ordinary, one input. Same action.
- **Term-by-term rule:** a term containing $x_k$ survives; a term with no $x_k$ is a constant and goes to $0$. E.g. $\partial/\partial x_k (b_kx_k) = b_k$.

This is the atom that [[Gradient]] and [[Hessian]] are built from. Worked in [[CS229 PS0 - Solutions]] Problem 1.
