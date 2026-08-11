---
aliases:
  - softmax regression
  - softmax
  - multinomial logistic regression
dateCreated: 2026-08-11 00:00:00
dateModified: 2026-08-11 00:00:00
tags: atom
title: Softmax regression
up:
  - "[[Logistic regression]]"
units:
  - "[[CS229 Lecture 4]]"
---

# Softmax regression

## Summary

Multi-class [[Classification]]: $k$ classes, $x^{(i)} \in \mathbb{R}^n$, labels as one-hot vectors $y \in \{0,1\}^k$ ([[Multinomial distribution]]).

**One $\theta$ per class.** Where [[Logistic regression]] had a single $\theta$ doing a binary split, softmax has $\theta_{\text{class}} \in \mathbb{R}^n$ for each class (optionally stacked as an $n \times k$ matrix). Each defines its own hyperplane $\theta_{\text{class}}^T x = 0$, so $k$ classes carve the input space with $k$ linear boundaries. That is what makes softmax a **linear** model - the nonlinearity sits outside, in the softmax function.

**The pipeline.** Given a new $x$:

1. **Logits** - compute $\theta_{\text{class}}^T x$ for each class. Real numbers in $(-\infty, \infty)$; this is "logit space", not probabilities.
2. **Exponentiate** - $e^{\theta_{\text{class}}^T x}$, making everything positive.
3. **Normalize** - divide by the sum so the values add to 1:

$$\hat{p}(y = \text{class} \mid x) = \frac{e^{\theta_{\text{class}}^T x}}{\sum_{i} e^{\theta_i^T x}}$$

The hypothesis now outputs a **whole probability distribution** over classes, not a scalar.

**Training** minimizes the [[Cross-entropy]] between $\hat p$ (the softmax output) and $p$ (the one-hot label read as a distribution). Because $p$ is one-hot, every term vanishes except the correct class and the loss collapses to $-\log \hat p(y_{\text{true}})$; run [[Gradient descent]] on the $\theta$'s.

**Connections.** With $k = 2$ softmax collapses to the [[Sigmoid function|sigmoid]] and the loss becomes logistic regression's - softmax is logistic regression generalized. It is also the loss used for next-token prediction over a vocabulary (a softmax over roughly 50,000 classes).
