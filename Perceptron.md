---
aliases:
  - perceptron
  - perceptrons
  - perceptron algorithm
dateCreated: 2026-08-11 00:00:00
dateModified: 2026-08-11 00:00:00
tags: atom
title: Perceptron
up:
  - "[[Classification]]"
units:
  - "[[CS229 Lecture 4]]"
---

# Perceptron

## Summary

[[Logistic regression]] with a **hard** step function in place of the smooth [[Sigmoid function]] - "the hard version of the sigmoid":

$$g(z) = \begin{cases} 1 & z \geq 0 \\ 0 & z < 0\end{cases} \qquad h_\theta(x) = g(\theta^T x)$$

**Update rule** (same shape as [[Linear regression]] and [[Logistic regression]]):

$$\theta_j := \theta_j + \alpha\left(y^{(i)} - h_\theta(x^{(i)})\right)x_j^{(i)}$$

Since $y$ and $h$ are both exactly 0 or 1, the error term takes only three values: $0$ (prediction correct, $\theta$ does not move), $+1$ (wrong, true label 1, so $\theta := \theta + \alpha x$), $-1$ (wrong, true label 0, so $\theta := \theta - \alpha x$). Go example by example, ignore the ones you get right, nudge $\theta$ toward or away from each mistake.

**Geometry.** $\theta$ is perpendicular to the decision boundary $\theta^T x = 0$. A dot product is positive when two vectors point in similar directions, so you want $\theta$ pointing **toward** the class-1 examples and **away from** the class-0 ones. Adding $x$ to $\theta$ drags $\theta$ in $x$'s direction and the perpendicular boundary rotates with it. The general technique - **adding one vector to another makes the second more similar to the first** - recurs throughout machine learning.

**Weaknesses.**

- **No probabilistic interpretation.** $h(x) = 1$ means "on the positive side of the line", not "100% confident". No distribution is assumed and the update is a geometric heuristic, not something derived from [[Maximum likelihood estimation]] - so no confidence estimates and no principled [[Cost function]].
- **Greedy, local updates.** Rotating $\theta$ to fix one point can knock a previously-correct point onto the wrong side; the algorithm can thrash. It converges only if the data is **linearly separable** (the perceptron convergence theorem), otherwise it cycles forever with no natural stopping criterion. Common practice is to anneal $\alpha$ downward until $\theta$ stops moving much.
- **Minsky's critique** (1960s): it cannot learn non-linearly-separable data such as XOR. This killed interest in the algorithm for years.

Not used in practice - covered for historical reasons, because it is simple to analyse, and because there are homework questions on it. It is also **not** a [[Generalized linear models|GLM]]: no probability model, so nothing to take maximum likelihood of.
