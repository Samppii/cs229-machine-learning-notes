---
dateCreated: 2026-07-13 00:00:00
dateModified: 2026-07-13 00:00:00
tags: index
title: CS229 PS0 - Solutions
status: complete
units:
  - "[[CS229]]"
up:
  - "[[CS229]]"
---

# CS229 PS0 - Solutions

Worked solutions to **CS229 Problem Set 0** (linear algebra + matrix calculus warm-up). Everything here is "derivatives and matrix multiplication in disguise" - see [[CS229 Math Cheatsheet]] for the formula reference this set drills.

> [!info] Concepts used
> [[Gradient]], [[Hessian]], [[Partial Derivative]], [[Quadratic Form]], [[Chain Rule]], [[Positive Semi-Definite]], [[Null Space]], [[Rank]], [[Rank-Nullity Theorem]], [[Eigenvalue]] / [[Eigenvector]], [[Spectral Theorem]], [[Diagonalization]], [[Outer Product]], [[Orthogonal Matrix]].

## Problem statement

![[ps0.pdf]]

---

## Problem 1 - Gradients and Hessians

Let $f(x) = \tfrac{1}{2}x^TAx + b^Tx$, with $A$ symmetric and $b \in \mathbb{R}^n$.

### 1(a) - Find $\nabla f(x)$

Expand into sums: $\tfrac{1}{2}x^TAx = \tfrac{1}{2}\sum_i\sum_j A_{ij}x_ix_j$ (a [[Quadratic Form]]) and $b^Tx = \sum_i b_ix_i$.

Take the [[Partial Derivative]] $\partial/\partial x_k$:

- **$b^Tx$ part:** only the $b_kx_k$ term contains $x_k$, so its derivative is $b_k$. Stacked over $k$ this gives $b$.
- **$\tfrac{1}{2}x^TAx$ part:** $x_k$ appears in **two slots** (as the $x_i$ factor and the $x_j$ factor), so it contributes twice: $Ax + A^Tx$. Since $A$ is symmetric ($A^T = A$), this is $Ax + A^Tx = 2Ax$, and the $\tfrac{1}{2}$ cancels the $2$, leaving $Ax$.

$$\boxed{\nabla f(x) = Ax + b}$$

This is the matrix-calculus analog of $\tfrac{d}{dx}\!\left(\tfrac{1}{2}ax^2 + bx\right) = ax + b$. See [[CS229 Math Cheatsheet#5. THE SHORTCUT FORMULAS (memorize - use freely)|cheat sheet §5]] for the shortcut. Builds on [[Gradient]], [[Partial Derivative]], [[Quadratic Form]].

### 1(b) - $f(x) = g(h(x))$, with $g:\mathbb{R}\to\mathbb{R}$, $h:\mathbb{R}^n\to\mathbb{R}$. Find $\nabla f(x)$

Apply the [[Chain Rule]]: outer derivative (evaluated at the inside) times gradient of the inside.

$$\boxed{\nabla f(x) = g'(h(x))\,\nabla h(x)}$$

- $g'(h(x))$ is a **scalar** (differentiate $g$, then plug in $h(x)$); $\nabla h(x)$ is a **vector**. Scalar times vector = vector, which is the correct shape for a [[Gradient]].

### 1(c) - Find $\nabla^2 f(x)$ for $f(x) = \tfrac{1}{2}x^TAx + b^Tx$

The [[Hessian]] is the gradient differentiated again w.r.t. $x$. From 1(a), $\nabla f = Ax + b$:

- $Ax$ (linear in $x$) differentiates to $A$.
- $b$ (constant) differentiates to $0$.

$$\boxed{\nabla^2 f(x) = A}$$

The $b$ term vanishes: a linear/flat term has zero curvature. A constant Hessian equal to $A$ means constant curvature, so the quadratic is a bowl (this is exactly the [[Convexity]] story when $A$ is [[Positive Semi-Definite]]).

### 1(d) - $f(x) = g(a^Tx)$. Find $\nabla f(x)$ and $\nabla^2 f(x)$

**Gradient** - [[Chain Rule]], where the inside $a^Tx$ has gradient $a$:

$$\boxed{\nabla f(x) = g'(a^Tx)\,a}$$

**Hessian** - differentiate $g'(a^Tx)\,a$ again. Only $g'(a^Tx)$ depends on $x$, so the chain rule fires once more: $\partial/\partial x\,[g'(a^Tx)] = g''(a^Tx)\,a$. Combining the two $a$ vectors (one from the gradient, one from this second chain-rule step) as an [[Outer Product]] gives an $n\times n$ matrix:

$$\boxed{\nabla^2 f(x) = g''(a^Tx)\,aa^T}$$

- $g''(a^Tx)$ is a scalar; $aa^T$ is a matrix (column times row). The $(k,j)$ entry is $g''(a^Tx)\,a_k a_j$. It must be $aa^T$ (not $a^Ta$) because a Hessian is a matrix, and column times row = matrix. See [[CS229 Math Cheatsheet#6. Chain rule (for compositions - function inside a function)|cheat sheet §6]].

---

## Problem 2 - Positive Semi-Definite Matrices

Recall [[Positive Semi-Definite]]: $A$ is PSD if $A$ is symmetric **and** $x^TAx \ge 0$ for all $x$. ("Semi" means zero is allowed, i.e. $\ge 0$ not $> 0$.) See [[CS229 Math Cheatsheet#7. PSD (positive semi-definite)|cheat sheet §7]].

### 2(a) - Show $A = zz^T$ is PSD

**Symmetric:** $(zz^T)^T = (z^T)^Tz^T = zz^T$. ✓

**Non-negative quadratic form:** for any $x$,

$$x^T(zz^T)x = (x^Tz)(z^Tx) = (x^Tz)^2 \ge 0$$

since $x^Tz$ is a **scalar** (a [[Quadratic Form]] / dot product, row times column), and any real number squared is $\ge 0$. It can equal $0$ (whenever $x^Tz = 0$), which is why this is PSD and not PD. $\boxed{zz^T \text{ is PSD}}$

### 2(b) - Null space and rank of $A = zz^T$ (with $z \ne 0$)

For any $x$: $Ax = (zz^T)x = z(z^Tx) = z\cdot(\text{scalar})$, so every output is a multiple of $z$ - all outputs lie on the single line through $z$.

- **[[Rank]]:** the outputs span 1 dimension, so $\boxed{\operatorname{rank}(A) = 1}$.
- **[[Null Space]]:** $Ax = 0 \iff z^Tx = 0$ (since $z \ne 0$), so the null space is every $x$ **perpendicular to $z$**: $\boxed{\operatorname{null}(A) = \{x : z^Tx = 0\}}$, of dimension $n-1$.
- **Check** via the [[Rank-Nullity Theorem]]: $\operatorname{rank} + \dim(\operatorname{null}) = 1 + (n-1) = n$. ✓

### 2(c) - If $A$ is PSD and $B \in \mathbb{R}^{m\times n}$ is arbitrary, is $BAB^T$ PSD?

**Yes.** For any $x \in \mathbb{R}^m$, regroup and substitute $y = B^Tx$ (so $x^TB = y^T$):

$$x^T(BAB^T)x = (x^TB)A(B^Tx) = y^TAy \ge 0$$

because $A$ is PSD ($y^TAy \ge 0$ for all $y$, including $y = B^Tx \in \mathbb{R}^n$). It is also symmetric: $(BAB^T)^T = BA^TB^T = BAB^T$ (using $A = A^T$). $\boxed{BAB^T \text{ is PSD}}$

Dimensions: $B$ is $m\times n$, so $BAB^T$ is $m\times m$; the substituted $y = B^Tx \in \mathbb{R}^n$ lands exactly where $A$'s PSD-ness applies. This is the covariance-under-transformation pattern.

---

## Problem 3 - Eigenvectors, Eigenvalues, and the Spectral Theorem

Recall [[Eigenvalue]] / [[Eigenvector]]: $Av = \lambda v$ ($A$ only scales $v$ by $\lambda$, no rotation). The [[Spectral Theorem]] says a symmetric $A = U\Lambda U^T$ with $U$ an [[Orthogonal Matrix]] ($U^TU = I$). See [[CS229 Math Cheatsheet#8. Eigenvalues (Problem 3 preview)|cheat sheet §8]].

### 3(a) - $A = T\Lambda T^{-1}$ diagonalizable, $T = [t^{(1)}\cdots t^{(n)}]$. Show $At^{(i)} = \lambda_i t^{(i)}$

Multiply $A = T\Lambda T^{-1}$ by $T$ on the right:

$$AT = T\Lambda T^{-1}T = T\Lambda$$

Read column $i$ of both sides. Since $\Lambda$ is diagonal, the $i$-th column of $T\Lambda$ is $t^{(i)}$ scaled by $\lambda_i$ (right-multiplying by a diagonal matrix scales each column):

$$\boxed{At^{(i)} = \lambda_i t^{(i)}}$$

So the columns of $T$ are eigenvectors with eigenvalues $\lambda_i$. This is exactly what [[Diagonalization]] means.

### 3(b) - $A$ symmetric, $A = U\Lambda U^T$, $U$ orthogonal, $U = [u^{(1)}\cdots u^{(n)}]$. Show $Au^{(i)} = \lambda_i u^{(i)}$

Identical to (a): $U$ orthogonal means $U^T = U^{-1}$, so $A = U\Lambda U^T = U\Lambda U^{-1}$ (the (a) form with $U$ in place of $T$). Multiply by $U$ on the right, using $U^TU = I$:

$$AU = U\Lambda U^TU = U\Lambda$$

Read column $i$:

$$\boxed{Au^{(i)} = \lambda_i u^{(i)}}$$

Same proof as (a); the only new ingredient is $U^TU = I$. The upgrade over (a): the eigenvectors $u^{(i)}$ are now **orthonormal**, not just independent (a property of the [[Orthogonal Matrix]] $U$).

### 3(c) - If $A$ is PSD, then $\lambda_i(A) \ge 0$ for each $i$

Plug the eigenvector $u^{(i)}$ into the PSD condition. Using $Au^{(i)} = \lambda_i u^{(i)}$ (from part b) and $(u^{(i)})^Tu^{(i)} = 1$ ($u^{(i)}$ is a unit vector since $U$ is orthogonal):

$$(u^{(i)})^T A u^{(i)} = (u^{(i)})^T(\lambda_i u^{(i)}) = \lambda_i (u^{(i)})^Tu^{(i)} = \lambda_i$$

Since $A$ is PSD, $(u^{(i)})^TAu^{(i)} \ge 0$. Therefore:

$$\boxed{\lambda_i \ge 0 \quad \text{for each } i}$$

$i$ was arbitrary, so this holds for **every** eigenvalue: all eigenvalues of a PSD matrix are $\ge 0$.

This is the key link: [[Positive Semi-Definite]] $\iff$ all [[Eigenvalue]]s $\ge 0$. In ML terms: convex cost $\iff$ PSD [[Hessian]] $\iff$ non-negative eigenvalues $\iff$ a bowl (see [[Convexity]], [[Cost function]]).

---

## Concept atoms from this set

![[Unit Preview.base]]
