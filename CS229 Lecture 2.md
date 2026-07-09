---
dateCreated: 2026-07-08 00:00:00
dateModified: 2026-07-09 00:00:00
tags: index
title: CS229 Lecture 2
status: complete
units:
  - "[[CS229]]"
up:
  - "[[CS229]]"
---

# CS229 Lecture 2

**First real algorithm.** Builds [[Linear regression]] from the ground up: the [[Hypothesis]] $h(x)=\theta^T x$, the [[Cost function]] $J(\theta)$ (ordinary least squares), and [[Gradient descent]] as the optimizer that minimizes it — plus why that optimization is easy here (a convex bowl).

## What the lecture covers (Part 1)

- **The model** — [[Hypothesis]]: $h(x) = \sum_j \theta_j x_j = \theta^T x$, its three equivalent forms, intercept vs. weights.
- **The objective** — [[Cost function]] $J(\theta)$, ordinary least squares; the [[Loss function]] ladder (error → loss → cost).
- **The optimizer** — [[Gradient descent]]: the update rule, the single-example gradient $(h(x)-y)x_j$, and why it's *general* (not specific to regression).
  - [[Learning rate]] $\alpha$ — the step size.
  - [[Convexity]] — why gradient descent always finds the global minimum here.

## What the lecture covers (Part 2)

Two ways to actually run [[Gradient descent]], then a second optimizer entirely:

- **Scaling the descent** — how much data each step uses:
  - [[Batch gradient descent]] — sum the gradient over all $m$ examples per step; accurate and smooth but slow on large data.
  - [[Stochastic gradient descent]] — one example per step; fast and noisy, never fully settles (shrink $\alpha$ over time). Includes the *batch vs stochastic* decision.
  - [[Mini-batch gradient descent]] — ~100 examples per step; the practical middle ground (and what real deep learning uses).
- **A closed-form alternative** — [[Normal equations]]: solve the *same* OLS cost in one step via the [[Design matrix]] $X$ and $\theta = (X^T X)^{-1} X^T y$. Linear regression only.

## Big picture

Linear regression = **model + objective**. Gradient descent = a general **optimizer** you hand any function. They are separable — and Part 2 makes that concrete: the [[Normal equations]] solve the *same* regression with **no gradient descent at all**.

**The two optimizers, same OLS cost** ("it depends how you want to solve it"):

- [[Gradient descent]] (Arc 3a) → iterative downhill walk → works on *any* model.
- [[Normal equations]] (Arc 3b) → one-shot closed-form formula → *linear regression only*.

The structure this lecture sets up, reused all quarter: **model (hypothesis) + objective (cost) + optimizer = a supervised learning algorithm.** The model and cost change per algorithm; the optimizer (gradient descent) is the reusable tool.

## Threads to later lectures

- **Why** squared error? Squared error ↔ a Gaussian assumption; linear regression is a special case of **GLMs** — next lecture justifies the cost.
- [[Gradient descent]] is reused for GLMs, neural nets, etc.; the normal equation is the linear-regression-only shortcut.
- Non-convex models (neural networks) have local optima → convergence / init / learning-rate issues that linear regression's convex bowl (see [[Convexity]]) avoids.

## Notes in this lecture

![[Unit Preview.base]]
