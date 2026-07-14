---
dateCreated: 2026-07-08 00:00:00
dateModified: 2026-07-13 00:00:00
tags: index
title: CS229 Lecture 2
status: complete
units:
  - "[[CS229]]"
up:
  - "[[CS229]]"
---

# CS229 Lecture 2

**First real algorithm.** Builds [[Linear regression]] from the ground up: the [[Hypothesis]] $h(x)=\theta^T x$, the [[Cost function]] $J(\theta)$ (ordinary least squares), and [[Gradient descent]] as the optimizer that minimizes it - plus why that optimization is easy here (a convex bowl).

## Rundown (Arc 1 → Arc 2 → Arc 3)

The whole lecture builds one algorithm in three arcs: **predict → measure → solve.** The math is the [[CS229 PS0 - Solutions]] practice made concrete (see also the [[CS229 Math Cheatsheet]]).

**Arc 1 - Predict (the [[Hypothesis]]).** $h(x) = \theta_0 + \theta_1 x_1 + \dots = \theta^T x$ (expanded → sigma → vector). $\theta_0$ = intercept (folded in via the dummy $x_0 = 1$), the rest are per-feature weights. This is a dot product (row × column → scalar), the same $b^Tx$ shape as [[CS229 PS0 - Solutions]] Problem 1, now acting as a weighted sum of features. Notation: $m$ = examples, $n$ = features, superscript $(i)$ = which example, subscript = which feature.

**Arc 2 - Measure (the [[Cost function]]).** Ordinary least squares $J(\theta) = \tfrac{1}{2}\sum_{i=1}^{m}\left(h_\theta(x^{(i)}) - y^{(i)}\right)^2$. The error → loss → cost ladder: error $= h-y$ (signed, one example), loss $= (h-y)^2$, cost $= J(\theta)$ (summed over all $m$). Squaring kills the sign and punishes big misses; the $\tfrac12$ cancels the $2$ on differentiating. $J$ is a [[Quadratic Form]] in $\theta$ (the $\tfrac12\theta^T A\theta + b^T\theta$ shape from PS0 Problem 1), which is why the PS0 [[Gradient]] practice transfers directly.

**Arc 3 - Solve (the optimizer, swappable).** Same cost, two solvers:
- **Arc 3a - [[Gradient descent]]** (iterative, any model): $\theta_j := \theta_j - \alpha\,\frac{\partial}{\partial\theta_j}J(\theta)$, gradient $=(h_\theta(x^{(i)})-y^{(i)})\,x_j^{(i)}$. Batch (all $m$: accurate, slow) vs stochastic (one example: noisy, fast) vs mini-batch (~100). $J$ is a convex bowl (no local optima) because its [[Hessian]] $X^TX$ is [[Positive Semi-Definite]] (see PS0 Problems 2 and 3) → one global min; the contour plot is that bowl from the top.
- **Arc 3b - [[Normal equations]]** (closed form, linear regression only): $\theta = (X^TX)^{-1}X^Ty$. One shot, no iteration - available only because setting the derivative to $0$ gives an equation *linear* in $\theta$. Nonlinear models (logistic, neural nets) have no closed form and must use gradient descent. Non-invertible $X^TX$ means redundant features (use the pseudo-inverse or drop the duplicate).

**Structural takeaway:** a supervised algorithm = **model + objective + optimizer.** Model and cost change per algorithm; the optimizer is the reusable tool. *Thread to Lecture 3:* squared error is not arbitrary - it falls out of a Gaussian-noise + maximum-likelihood assumption (justified via GLMs), and logistic regression (first classifier) comes next.

## What the lecture covers (Part 1)

- **The model** - [[Hypothesis]]: $h(x) = \sum_j \theta_j x_j = \theta^T x$, its three equivalent forms, intercept vs. weights.
- **The objective** - [[Cost function]] $J(\theta)$, ordinary least squares; the [[Loss function]] ladder (error → loss → cost).
- **The optimizer** - [[Gradient descent]]: the update rule, the single-example gradient $(h(x)-y)x_j$, and why it's *general* (not specific to regression).
  - [[Learning rate]] $\alpha$ - the step size.
  - [[Convexity]] - why gradient descent always finds the global minimum here.

## What the lecture covers (Part 2)

Two ways to actually run [[Gradient descent]], then a second optimizer entirely:

- **Scaling the descent** - how much data each step uses:
  - [[Batch gradient descent]] - sum the gradient over all $m$ examples per step; accurate and smooth but slow on large data.
  - [[Stochastic gradient descent]] - one example per step; fast and noisy, never fully settles (shrink $\alpha$ over time). Includes the *batch vs stochastic* decision.
  - [[Mini-batch gradient descent]] - ~100 examples per step; the practical middle ground (and what real deep learning uses).
- **A closed-form alternative** - [[Normal equations]]: solve the *same* OLS cost in one step via the [[Design matrix]] $X$ and $\theta = (X^T X)^{-1} X^T y$. Linear regression only.

## Big picture

Linear regression = **model + objective**. Gradient descent = a general **optimizer** you hand any function. They are separable - and Part 2 makes that concrete: the [[Normal equations]] solve the *same* regression with **no gradient descent at all**.

**The two optimizers, same OLS cost** ("it depends how you want to solve it"):

- [[Gradient descent]] (Arc 3a) → iterative downhill walk → works on *any* model.
- [[Normal equations]] (Arc 3b) → one-shot closed-form formula → *linear regression only*.

The structure this lecture sets up, reused all quarter: **model (hypothesis) + objective (cost) + optimizer = a supervised learning algorithm.** The model and cost change per algorithm; the optimizer (gradient descent) is the reusable tool.

## Code practice

Implemented this lecture from scratch in numpy: [[Lecture_2_Linear_Regression_Code_Practice]] (in `CodePractice/`). Toy data ($y = 5 + 2x + \text{noise}$), the [[Cost function]], [[Batch gradient descent]], [[Stochastic gradient descent]], and the [[Normal equations]] - all recovering $\theta \approx [5, 2]$. The math-to-numpy mapping (shapes, why `X.T` in the gradient, when `@` sums vs when you need `.sum()`) lives in [[CS229 Lecture 2 Code Cheatsheet]].

## Threads to later lectures

- **Why** squared error? Squared error ↔ a Gaussian assumption; linear regression is a special case of **GLMs** - next lecture justifies the cost.
- [[Gradient descent]] is reused for GLMs, neural nets, etc.; the normal equation is the linear-regression-only shortcut.
- Non-convex models (neural networks) have local optima → convergence / init / learning-rate issues that linear regression's convex bowl (see [[Convexity]]) avoids.

## Notes in this lecture

![[Unit Preview.base]]
