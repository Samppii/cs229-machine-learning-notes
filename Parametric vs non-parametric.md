---
aliases:
  - parametric vs non-parametric
  - parametric vs nonparametric
  - non-parametric
dateCreated: 2026-07-16 00:00:00
dateModified: 2026-07-16 00:00:00
tags: atom
units:
  - "[[CS229 Lecture 3]]"
---

# Parametric vs non-parametric

## Summary

Two families of learning algorithm, split by **whether you can throw the training data away** after fitting.

| | **Parametric** | **Non-parametric** |
| --- | --- | --- |
| example | [[Linear regression]] | [[Locally weighted regression]] |
| what you keep | a fixed vector $\theta$ | **all the training data** |
| storage | fixed (independent of $m$) | **grows with** $m$ |
| predict | use $\theta$ alone | re-use nearby examples every time |

- **Parametric:** fit a fixed set of parameters $\theta$, then discard the data - prediction uses only $\theta$.
- **Non-parametric:** must keep every example, because each prediction re-fits using the local data around the query point. Good for low-dimensional data with lots of examples; expensive when $m$ is in the millions.

The count of parameters is what is really at stake: parametric = *fixed* number of parameters no matter how much data; non-parametric = the effective complexity grows with the dataset.
