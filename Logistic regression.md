---
aliases:
  - logistic regression
  - logistic regressions
dateCreated: 2026-07-17 00:00:00
dateModified: 2026-07-17 00:00:00
tags: atom
title: Logistic regression
up:
  - "[[Classification]]"
units:
  - "[[CS229 Lecture 3]]"
---

# Logistic regression

## Summary

The first [[Classification]] algorithm ($y \in \{0, 1\}$). It is the [[Sigmoid function]] wrapped around a linear model so the output is a **probability** in $(0, 1)$:

$$h_\theta(x) = g(\theta^T x) = \frac{1}{1 + e^{-\theta^T x}}, \qquad h_\theta(x) = p(y = 1 \mid x; \theta)$$

**Why not [[Linear regression]] for classification?** (1) Outliers swing the fitted line and shift the decision boundary badly - it is not robust. (2) $\theta^T x$ can output values $< 0$ or $> 1$, which is unnatural for 0/1 labels.

**Where it comes from.** Model $y$ as a [[Bernoulli distribution]] with parameter $h_\theta(x)$, then apply the [[Maximum likelihood estimation]] recipe. The log-likelihood is the [[Cross-entropy]], and maximizing it uses [[Gradient ascent]]:

$$\theta_j := \theta_j + \alpha \sum_{i=1}^{m}\left(y^{(i)} - h_\theta(x^{(i)})\right)x_j^{(i)}$$

**Striking fact:** this update has the same **(error) x (feature)** form as the [[Linear regression]] update, even though $h_\theta$ is now the sigmoid - a preview of **generalized linear models**, where both are special cases of one framework. There is **no closed form** ([[Normal equations]] do not apply); it needs an iterative optimizer ([[Gradient ascent]] or [[Newton's method]]). The log-likelihood is concave, so there are no local optima.
