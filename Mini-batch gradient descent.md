---
aliases:
  - mini-batch gradient descent
  - mini-batch gradient descents
  - minibatch gradient descent
  - mini-batch gd
dateCreated: 2026-07-09 00:00:00
dateModified: 2026-07-09 00:00:00
tags: atom
title: Mini-batch gradient descent
up:
  - "[[Gradient descent]]"
units:
  - "[[CS229 Lecture 2]]"
---

# Mini-batch gradient descent

## Summary

The middle ground between [[Batch gradient descent]] (all $m$ per step) and [[Stochastic gradient descent]] (1 per step): use **~100 examples per step**. Faster than batch, less noisy than pure SGD.

Only mentioned in this lecture (it's covered properly in CS230), but worth knowing because **it's what most real deep learning actually uses** — the practical default in the batch ↔ stochastic spectrum.
