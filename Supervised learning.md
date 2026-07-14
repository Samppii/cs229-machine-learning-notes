---
aliases:
  - supervised learning
dateCreated: 2026-07-07 14:00:00
dateModified: 2026-07-07 14:00:00
tags: atom
title: Supervised learning
up:
  - "[[Machine learning]]"
units:
  - "[[CS229 Lecture 1]]"
---

# Supervised learning

## Summary

You are given a dataset of inputs $X$ **and** their labels $Y$, and you learn a mapping (hypothesis) $h: X \to Y$. The defining feature: the "right answers" $Y$ are provided during training.

Two flavors, split by the type of $Y$:
- [[Regression]] - $Y$ is continuous.
- [[Classification]] - $Y$ is discrete.

$X$ is usually multi-dimensional - see [[Features]]. Algorithms named for later lectures: gradient descent, logistic regression, SVMs + kernels, neural nets + backpropagation.

## Notes

- **ALVINN** (Pomerleau, CMU): early autonomous steering. $X$ = camera image, $Y$ = human steering direction, ~10 fps; the network learns to mimic the human. Historical, not current state of the art.
