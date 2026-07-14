---
aliases:
  - stochastic gradient descent
  - stochastic gradient descents
  - sgd
dateCreated: 2026-07-09 00:00:00
dateModified: 2026-07-09 00:00:00
tags: atom
title: Stochastic gradient descent
up:
  - "[[Gradient descent]]"
units:
  - "[[CS229 Lecture 2]]"
---

# Stochastic gradient descent

## Summary

Update using **one example at a time** instead of scanning all $m$ first (contrast [[Batch gradient descent]]). For $i = 1$ to $m$, and all $j$:

$$\theta_j := \theta_j - \alpha\left(h_\theta(x^{(i)}) - y^{(i)}\right)x_j^{(i)}$$

Each step reacts to a single example → a **noisy / zigzag** path. Any one step may point slightly wrong, but on average it heads toward the global minimum. For very large datasets it makes much faster progress, so it's used **more in practice than batch**.

## Never fully converges

Pure SGD **oscillates around the minimum forever** - each new example keeps nudging $\theta$. Fix: **slowly decrease the [[Learning rate]] $\alpha$ over time** → smaller zigzags → it tightens into a smaller region around the minimum.

## Batch vs stochastic - when to use which

- **Small dataset** (hundreds–few thousand): use **batch** - accurate, settles, "one less thing to fiddle with."
- **Large dataset** (hundreds of thousands+, or when one full pass is too slow): use **stochastic** (or [[Mini-batch gradient descent]]).
- The real rule isn't a fixed number - it's *"does one full scan of the data hurt?"* If no → batch. If yes → the dataset is "large," go stochastic/mini-batch. **"Large" is relative to your compute.**

Spectrum:

| variant | per step | character |
| --- | --- | --- |
| [[Batch gradient descent]] | all $m$ | accurate, smooth, slow |
| [[Mini-batch gradient descent]] | ~100 | practical middle ground |
| **Stochastic** | 1 | fast, noisy, never fully settles |
