---
aliases:
  - loss function
  - loss functions
  - loss
dateCreated: 2026-07-08 00:00:00
dateModified: 2026-07-08 00:00:00
tags: atom
title: Loss function
up:
  - "[[Cost function]]"
units:
  - "[[CS229 Lecture 2]]"
---

# Loss function

## Summary

A three-rung vocabulary ladder that recurs everywhere in ML. Each rung wraps the one below:

| term | scope | formula | notes |
| --- | --- | --- | --- |
| **error / residual** | one example | $h(x^{(i)}) - y^{(i)}$ | raw, **signed** |
| **loss** | one example | $\left(h(x^{(i)}) - y^{(i)}\right)^2$ | squared → always $\ge 0$, punishes big misses |
| **cost** | whole dataset | $J(\theta)$ | the losses summed — see [[Cost function]] |

- **Error** can be negative (predicted too high or too low). Summing raw errors lets them cancel, which is why the **loss** squares first.
- **Loss** is per-example; **cost** aggregates loss over all $m$ examples.
- Squaring is one choice of loss (least squares). Others exist (absolute, 4th power); the squared choice is justified next lecture via the Gaussian assumption.
