---
aliases:
  - normal equations
  - normal equation
dateCreated: 2026-07-09 00:00:00
dateModified: 2026-07-09 00:00:00
tags: atom
title: Normal equations
up:
  - "[[Linear regression]]"
units:
  - "[[CS229 Lecture 2]]"
---

# Normal equations

## Summary

A **closed-form** optimizer for the **same** OLS [[Cost function]] that [[Gradient descent]] minimizes. Solves for the optimal $\theta$ in **one step** — no iteration, no [[Learning rate]], no convergence loop — but works for **[[Linear regression]] only**.

## Setup — the design matrix

Stack all training inputs $x^{(i)T}$ as rows into the [[Design matrix]] $X$ ($m \times (n+1)$). Then $X\theta$ is the vector of all predictions and $y$ is the column vector of all labels:

$$X\theta = \begin{bmatrix} h(x^{(1)}) \\ h(x^{(2)}) \\ \vdots \\ h(x^{(m)}) \end{bmatrix}$$

Cost in matrix form (using $z^Tz = \sum_i z_i^2$):

$$J(\theta) = \tfrac{1}{2}(X\theta - y)^T(X\theta - y)$$

## Why the matrix-calculus detour

To find the minimum you take $\nabla_\theta J$, set it to $\vec 0$, and solve. But $\theta$ is a **vector**, so "the derivative" must first be *defined* for vector/matrix-valued functions. So Ng (1) defines the derivative w.r.t. a vector/matrix (a matrix of partial derivatives, one per element), (2) gives the **rules** — the trace identities — then (3) applies them. The detour is tool-building, not a tangent.

**Trace** = sum of the diagonal entries of a square matrix (a scalar); a tidy scalar-wrapper that keeps the matrix calculus compact. Key facts used: $\operatorname{tr}A = \operatorname{tr}A^T$, $\operatorname{tr}AB = \operatorname{tr}BA$, cyclic $\operatorname{tr}ABC = \operatorname{tr}CAB$, and $\nabla_A \operatorname{tr}AB = B^T$. (Trace often isn't in an applied linear algebra course — it's a small add-on; learn it from the CS229 linear algebra section notes.)

## The result

Take $\nabla_\theta J(\theta)$, set to $\vec 0$, simplify (Ng skips the full trace algebra on the board — it's in the notes + pset 1) → the **normal equations**:

$$X^T X \theta = X^T y$$

Solve for $\theta$ → the closed-form solution:

$$\theta = (X^T X)^{-1} X^T y$$

**One formula → the global minimum in one step.** Same optimal $\theta$ gradient descent would eventually reach — computed directly instead of walked to.

## Why only linear regression

Its "derivative = 0" equation is *linear in $\theta$*, so $\theta$ can be isolated algebraically. Logistic regression, neural nets, etc. are **nonlinear** → no closed form → must use [[Gradient descent]]. This is why gradient descent is taught so carefully (the universal workhorse); the normal equation is the rare special-case shortcut.

## Practical footnotes

- **If $X^TX$ is non-invertible:** usually redundant / linearly dependent features (often a duplicated feature). Use the pseudo-inverse, or better, find and remove the repeated feature.
- Even for linear regression, huge feature counts make the $(X^TX)^{-1}$ inverse expensive, so gradient descent is sometimes still preferred at scale.
