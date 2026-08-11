---
aliases:
  - multinomial distribution
  - multinomial distributions
  - multinomial
  - categorical distribution
dateCreated: 2026-08-11 00:00:00
dateModified: 2026-08-11 00:00:00
tags: atom
title: Multinomial distribution
units:
  - "[[CS229 Lecture 4]]"
---

# Multinomial distribution

## Summary

The distribution over an outcome that is **one of $k$ classes** - the multi-class generalization of the [[Bernoulli distribution]] (which is the $k = 2$ case). It is parameterized by class probabilities $\phi_1, \dots, \phi_k$ summing to 1, so only $k - 1$ of them are free.

Labels are written as **one-hot vectors** $y \in \{0,1\}^k$: all zeros except a single 1 marking the class.

It is a member of the [[Exponential family]] - here the [[Natural parameter]] $\eta$ is a $(k-1)$-vector rather than a scalar, and inverting it produces the softmax. That is the [[Generalized linear models|GLM]] route to [[Softmax regression]], which is how Andrew's written lecture notes derive it. (In lecture the TA took the shorter [[Cross-entropy]] route instead, since the GLM derivation is messy on a whiteboard; both end at the same equations.)
