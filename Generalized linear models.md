---
aliases:
  - generalized linear models
  - generalized linear model
  - GLM
  - GLMs
dateCreated: 2026-08-11 00:00:00
dateModified: 2026-08-11 00:00:00
tags: atom
title: Generalized linear models
up:
  - "[[Exponential family]]"
units:
  - "[[CS229 Lecture 4]]"
---

# Generalized linear models

## Summary

The [[Exponential family]] has no $x$ in it - it describes a distribution over $y$ and nothing else. **GLMs** are the extension that brings in covariates (input [[Features]]). Three assumptions:

1. $y \mid x; \theta \sim \text{ExponentialFamily}(\eta)$ - **choose the distribution based on what $y$ is**
2. $\eta = \theta^T x$, with $\theta, x \in \mathbb{R}^n$ - the design choice; this is where $x$ enters and the "linear" in GLM
3. $h_\theta(x) = E[y \mid x; \theta]$ - **predict the mean** of the resulting distribution

**Choosing the distribution** is dictated by the task, not by judgement:

| $y$ is | distribution |
|---|---|
| real-valued | [[Gaussian distribution\|Gaussian]] |
| binary | [[Bernoulli distribution\|Bernoulli]] |
| counts (non-negative integers) | [[Poisson distribution\|Poisson]] |
| positive reals (durations, volumes) | Gamma / Exponential |
| one of $k$ classes | [[Multinomial distribution\|Multinomial]] |
| a probability distribution | Beta / Dirichlet (Bayesian settings) |

**The mental picture:** a linear model and a distribution stacked. $x$ goes into the linear model, $\theta^T x$ produces the [[Natural parameter]] $\eta$, and $\eta$ parameterizes the exponential-family distribution sitting on top. That distribution's mean is the prediction.

**Cranking the handle** - only assumption 1 ever changes:

| | distribution | $E[y]$ | $h_\theta(x)$ |
|---|---|---|---|
| [[Linear regression]] | Gaussian | $\mu = \eta$ | $\theta^T x$ |
| [[Logistic regression]] | Bernoulli | $\phi = \dfrac{1}{1+e^{-\eta}}$ | $\dfrac{1}{1+e^{-\theta^T x}}$ |
| Poisson regression | Poisson | $\lambda = e^\eta$ | $e^{\theta^T x}$ |

**Training** is [[Maximum likelihood estimation]] on $\theta$, and the incidental benefit is that **you never derive gradients again** - every GLM shares one update rule:

$$\theta_j := \theta_j + \alpha\left(y^{(i)} - h_\theta(x^{(i)})\right)x_j^{(i)}$$

Two structural facts, neither depending on the distribution, make it universal: $\eta = \theta^T x$ gives $\partial\eta/\partial\theta_j = x_j$, and differentiating the exponential-family log-likelihood with respect to $\eta$ gives $y - a'(\eta) = y - h$. Chain them and you get $(y - h)x_j$. This is why [[Linear regression]] and [[Logistic regression]] shared an update rule in [[CS229 Lecture 3]] despite different hypotheses. [[Newton's method]] is the usual practical optimizer, since GLM parameter counts are typically small enough (under a few thousand) that inverting the [[Hessian]] is cheap.

**Scope.** GLMs cover **discriminative, probabilistic models where $\eta$ is linear in $x$**. Outside the family: [[Locally weighted regression]] (non-parametric), the [[Perceptron]] (no probabilistic interpretation), generative models such as GDA and Naive Bayes (they model $p(x \mid y)$), SVMs (no probability model), and neural networks ($\eta$ nonlinear in $\theta$, which is exactly what destroys the [[Convexity]] guarantee).
