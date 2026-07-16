---
aliases:
  - locally weighted regression
  - locally weighted regressions
  - LWR
dateCreated: 2026-07-16 00:00:00
dateModified: 2026-07-16 00:00:00
tags: atom
title: Locally weighted regression
up:
  - "[[Linear regression]]"
units:
  - "[[CS229 Lecture 3]]"
---

# Locally weighted regression

## Summary

A **non-parametric** twist on [[Linear regression]] that fits curved data without hand-engineering features. Same squared-error cost, but each training example gets a **weight** $w^{(i)}$ based on how close it is to the point $x$ where you want to predict:

$$J(\theta) = \sum_{i=1}^{m} w^{(i)}\left(y^{(i)} - \theta^T x^{(i)}\right)^2, \qquad w^{(i)} = \exp\left(-\frac{(x^{(i)} - x)^2}{2\tau^2}\right)$$

- **Near** the prediction point ($|x^{(i)} - x|$ small) $\Rightarrow w^{(i)} \approx 1$; **far** $\Rightarrow w^{(i)} \approx 0$. The fit only listens to the local neighborhood.
- **Per prediction:** weights are computed *relative to* $x$, so you re-compute weights and **re-fit a fresh local line for every new prediction point**. Many local lines strung together trace a curve.
- Weights are **computed** from distance; only $\theta$ is **fitted** (by weighted least squares).
- The [[Bandwidth]] $\tau$ sets how wide the neighborhood is.

**Alternative it competes with:** engineering features (add $x^2$, $\sqrt{x}$ - still linear in $\theta$, i.e. polynomial regression). LWR sidesteps having to pick those features by hand.

> [!caution] The weight is not a probability
> $w^{(i)}$ **looks** Gaussian but is **not** a probability density - no normalizing constant, does not integrate to 1. It only borrows the bell shape because that shape is convenient for weighting. The real Gaussian shows up separately in the [[CS229 Lecture 3]] probabilistic interpretation.

See [[Parametric vs non-parametric]] for why LWR must keep all the training data around.
