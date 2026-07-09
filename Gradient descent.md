---
aliases:
  - gradient descent
  - gradient descents
dateCreated: 2026-07-08 00:00:00
dateModified: 2026-07-08 00:00:00
tags: atom
title: Gradient descent
units:
  - "[[CS229 Lecture 2]]"
---

# Gradient descent

## Summary

A general **optimizer**: hand it any function and it finds a minimum. Here it minimizes the [[Cost function]] $J(\theta)$, but it is **not** specific to [[Linear regression]] — the same procedure powers logistic regression, neural nets, etc. (Regression can also be solved with no gradient descent at all, via the normal equations.)

**Picture:** $J(\theta)$ is a surface (a hill); height = how wrong you are. Start anywhere, find the steepest downhill direction, take a small step, repeat until you reach the bottom.

## The update rule

$$\theta_j := \theta_j - \alpha \frac{\partial}{\partial \theta_j} J(\theta)$$

- $:=$ is **assignment** (an update), not an equality claim — like `theta_j = theta_j - ...` in code.
- $\alpha$ = the [[Learning rate]] (step size).
- $\frac{\partial}{\partial \theta_j} J(\theta)$ = the gradient in the $\theta_j$ direction; it points **uphill**.
- The **minus** flips uphill → downhill (answers "why subtract, not add?").
- $\partial$ (partial, not $d$) because $J$ depends on several $\theta$'s — differentiate w.r.t. $\theta_j$ while holding the other $\theta$'s fixed.

## The computed gradient (single example)

For one training example the partial works out to:

$$\frac{\partial}{\partial \theta_j} J(\theta) = \left(h_\theta(x) - y\right)x_j$$

giving the single-example update:

$$\theta_j := \theta_j - \alpha\left(h_\theta(x) - y\right)x_j$$

**Read it in plain English: step size × error × input.** Bigger error → bigger correction, scaled by which feature you're adjusting. This is the core learning signal.

*Derivation:* the $2$ from the square cancels the $\tfrac{1}{2}$ in [[Cost function]]; chain rule; every term's partial is $0$ except the $\theta_j x_j$ term, whose partial is $x_j$.

## Convergence

Because $J(\theta)$ for linear regression is a sum of squares, it is **convex** — see [[Convexity]]. So gradient descent always reaches the **global** minimum regardless of where $\theta$ starts (init to zeros or randomly — doesn't matter), provided the [[Learning rate]] is sane. **Stopping criterion:** plot $J(\theta)$ over iterations; when it flattens, you've converged.
