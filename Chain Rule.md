---
aliases:
  - chain rule
  - chain rules
dateCreated: 2026-07-13 00:00:00
dateModified: 2026-07-13 00:00:00
tags: atom
title: Chain Rule
units:
  - "[[CS229 PS0 - Solutions]]"
---

# Chain Rule

## Summary

For a composition $f(x) = g(\text{inside})$:

$$\nabla f(x) = g'(\text{inside}) \cdot \nabla(\text{inside})$$

"Outer derivative (evaluated at the inside) times gradient of the inside."

- $g'(a^Tx)$ means "differentiate $g$, then **plug in** $a^Tx$" - not "differentiate with respect to $a^Tx$." You always differentiate with respect to $x$; the inside is just a value to substitute.
- **Trigger:** a function *nested* inside another. (Multiplication triggers the product rule; nesting is not multiplying.)

Used to derive [[Gradient]] and [[Hessian]] of composite functions. Worked in [[CS229 PS0 - Solutions]] Problem 1(b) and 1(d).
