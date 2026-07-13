# CS229 Math Cheat Sheet - Vectors, Matrices, Derivatives, PSD

A reference for the linear algebra + matrix calculus behind CS229 (PS0, Lecture 2). Everything here is "derivatives and matrix multiplication in disguise."

---

## 1. The building blocks (vectors & matrices)

| thing | what it is | shape |
|---|---|---|
| **x** | column vector (standing up) | n×1 |
| **xᵀ** | row vector (transpose = flip orientation) | 1×n |
| **A** | matrix | n×n |
| **transpose (ᵀ)** | flips orientation (column↔row); flips a matrix over its diagonal | - |

**Transpose flips. Multiplication sums.** (Transpose alone makes no sum - the sum comes from multiplying a row by a column.)

Key transpose rule: **(BC)ᵀ = CᵀBᵀ** (reverses the order).

---

## 2. The two multiplication patterns (both collapse to ONE number)

**Dot product** (two vectors) → one number:
$$b^T x = \sum_i b_i x_i = b_1x_1 + b_2x_2 + \dots$$
- row × column = scalar. One index → **one sum**.

**Quadratic form** (vector-matrix-vector) → one number:
$$x^T A x = \sum_i \sum_j A_{ij} x_i x_j$$
- row × matrix × column = scalar. Two indices → **double sum**.
- Rule: **more matrices in the sandwich = more sigmas.** Matrix in the middle adds an index.

**Shapes tell you the output:**
- **xᵀz** or **zᵀx** = row × column = **scalar** (a number)
- **zzᵀ** = column × row = **matrix** (n×n, the "outer product")
- Order matters: `aᵀa` = number, `aaᵀ` = matrix.

**Why ML cares:** `θᵀx` takes multi-dimensional input (features) → collapses to ONE number (the prediction). That "many dims → a number" crunch is the core move of ML.

---

## 3. Partial derivatives (the foundation)

**∂/∂xₖ = differentiate w.r.t. xₖ, treat EVERY other variable as a constant.**

- Same rules as normal derivatives (power rule, etc.) + one extra instruction: freeze the others.
- **∂ (curly) = partial** (multiple variables). **d (straight) = ordinary** (one variable). Same action.
- Trick when stuck: *replace every constant with an actual number in your head*, then it's a plain d/dx problem.

**Term-by-term rule (differentiating a sum):**
- A term **containing xₖ** → survives.
- A term with **no xₖ** → it's a constant → **0**.
- `∂/∂xₖ (bₖxₖ) = bₖ` (coefficient stays, xₖ consumed - like d/dx of 5x = 5).

---

## 4. Gradient & Hessian

| | what it is | how you build it | shape |
|---|---|---|---|
| **Gradient ∇f** | vector of **first** partial derivatives | differentiate f once w.r.t. each variable, stack | vector (n×1) |
| **Hessian ∇²f** | matrix of **second** partial derivatives | differentiate the gradient again | matrix (n×n) |

- **Gradient** = "which way is uphill" (slope, per variable).
- **Hessian** = curvature (how the slope changes) = "the derivative of the gradient."
- Hessian entry (i,j) = ∂²f / ∂xᵢ∂xⱼ. Symmetric.

---

## 5. THE SHORTCUT FORMULAS (memorize - use freely)

| expression | gradient ∇ | why (single-var analog) |
|---|---|---|
| **bᵀx** | **b** | d/dx(bx) = b |
| **xᵀx** | **2x** | d/dx(x²) = 2x |
| **xᵀAx** (A symmetric) | **2Ax** | d/dx(ax²) = 2ax |
| **½xᵀAx** (A symmetric) | **Ax** | d/dx(½ax²) = ax |

**Hessians:**

| expression | Hessian ∇² |
|---|---|
| **bᵀx** | **0** (linear = flat = no curvature) |
| **½xᵀAx** (A sym) | **A** |

**The full PS0 Problem 1 function** f(x) = ½xᵀAx + bᵀx:
- **∇f = Ax + b**
- **∇²f = A** (the b vanishes: derivative of a constant is 0)

**Non-symmetric caveat:** ∇(xᵀAx) = (A + Aᵀ)x. Symmetric makes Aᵀ = A → collapses to 2Ax.

**Where the factor of 2 comes from:** in xᵀAx, x appears in **two slots** → differentiating hits both → Ax + Aᵀx → (symmetric) → 2Ax. Same reason d/dx(x²)=2x.

---

## 6. Chain rule (for compositions - function inside a function)

For **f(x) = g(inside)**:
$$\nabla f(x) = g'(\text{inside}) \cdot \nabla(\text{inside})$$
- "outer derivative (evaluated at the inside) × gradient of the inside."
- **g'(aᵀx) means "differentiate g, then PLUG IN aᵀx"** - NOT "differentiate w.r.t. aᵀx." Always differentiate w.r.t. **x**. The inside is just a plug-in value.

**Trigger:** function *nested* inside another → chain rule. (Multiplication → product rule; division → quotient rule. Nesting ≠ multiplying.)

**PS0 1(d): f(x) = g(aᵀx)** (inside = aᵀx, whose gradient is **a**):
- **∇f = g'(aᵀx) · a**
- **∇²f = g''(aᵀx) · aaᵀ**   ← g'' is the scalar; **aaᵀ** (outer product, a matrix) is what makes it a proper Hessian. Two a's: one from the gradient, one from chain-ruling again.

---

## 7. PSD (positive semi-definite)

**A is PSD (A ⪰ 0) if:**
1. **A is symmetric** (A = Aᵀ), AND
2. **xᵀAx ≥ 0 for every x**

- **Intuition:** the matrix version of "x² ≥ 0" - the quadratic form never goes negative.
- **PD (positive definite):** stricter - xᵀAx > 0 for all x ≠ 0 (never even touches 0).

**The chain that connects it to Lecture 2:**
$$\text{Hessian is PSD} \;\to\; \text{function is convex} \;\to\; \text{a bowl (one global min)} \;\to\; \text{clean contour plot}$$
- PSD is the **property**; convex bowl is the **shape**; contour plot is the **picture**.
- **Why gradient descent always works on linear regression:** its Hessian is **XᵀX**, which is **PSD** → convex → single global minimum. Problem 2 proves this kind of fact.

**Proof trick for "show M is PSD":** compute xᵀMx and show it's a **square** (or sum of squares), which is always ≥ 0.
- Example (2a): xᵀ(zzᵀ)x = (xᵀz)(zᵀx) = **(xᵀz)²** ≥ 0. ✅
- Regroup with associativity, spot the "(something)²" pattern.

**Show M is symmetric:** show Mᵀ = M. (e.g. (zzᵀ)ᵀ = (zᵀ)ᵀzᵀ = zzᵀ ✅)

---

## 8. Eigenvalues (Problem 3 preview)

- **Eigenvalue/eigenvector:** Av = λv (A stretches v by factor λ, no rotation).
- Found via characteristic polynomial: det(λI − A) = 0.
- **Diagonalizable:** A = TΛT⁻¹ (Λ = diagonal of eigenvalues, T's columns = eigenvectors).
- **Spectral theorem:** if A is symmetric → A = UΛUᵀ with U orthogonal (UᵀU = I). Real eigenvalues, orthogonal eigenvectors.
- **PSD ⟺ all eigenvalues ≥ 0.** (PD ⟺ all eigenvalues > 0.) ← ties PSD and eigenvalues together.
- **ML payoff:** PCA is eigenvectors of the covariance matrix. Eigenvalues come back big later.

---

## The one-line mental models
- **It's all derivatives + matrix multiplication in disguise.** Strip the notation → familiar operations.
- **Gradient = vector of first partials. Hessian = matrix of second partials.**
- **Matrix form = compact/workable. Sum form = expand it to do the calculus, then compress back.**
- **PSD → convex → bowl → gradient descent finds the global min.**
- **Model + cost + optimizer = a supervised ML algorithm.** (Lecture 2 structure.)
