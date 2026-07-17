---
aliases:
  - quadratic convergence
  - quadratic convergences
dateCreated: 2026-07-17 00:00:00
dateModified: 2026-07-17 00:00:00
tags: atom
up:
  - "[[Newton's method]]"
units:
  - "[[CS229 Lecture 3]]"
title: Quadratic convergence
---

# Quadratic convergence

## Summary

The reason [[Newton's method]] needs so few iterations: near the solution the number of correct significant digits roughly **doubles** each step.

$$0.01 \;\to\; 0.0001 \;\to\; 0.00000001 \;\to\; \dots$$

This is extremely fast compared with the steady, small progress of [[Gradient descent]] / [[Gradient ascent]]. The catch is cost per step: each iteration inverts the [[Hessian]], so the speed pays off only when the parameter count is small.
