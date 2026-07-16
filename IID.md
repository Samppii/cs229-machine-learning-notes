---
aliases:
  - iid
  - i.i.d.
  - independently and identically distributed
dateCreated: 2026-07-16 00:00:00
dateModified: 2026-07-16 00:00:00
tags: atom
units:
  - "[[CS229 Lecture 3]]"
---

# IID

## Summary

**Independently and identically distributed** - the standard assumption about a training set:

- **Independent** - each example's randomness (here the noise $\varepsilon^{(i)}$) does not depend on the others.
- **Identically distributed** - every example is drawn from the *same* distribution (same $\sigma^2$, same shape).

It is an **approximation** - real data has some dependence - but a good enough one, and it is what makes the math work: because the examples are independent, the [[Likelihood]] of the whole dataset **factorizes into a product**,

$$L(\theta) = \prod_{i=1}^{m} p\left(y^{(i)} \mid x^{(i)}; \theta\right),$$

which is the step that leads (via the [[Log-likelihood]] and [[Maximum likelihood estimation]]) to the squared-error [[Cost function]] in [[CS229 Lecture 3]].
