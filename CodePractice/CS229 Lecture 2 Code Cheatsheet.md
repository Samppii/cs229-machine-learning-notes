# CS229 Lecture 2 Code Cheatsheet

Connect-the-dots reference tying the **Lecture 2 math** to the **numpy implementation** in [[Lecture_2_Linear_Regression_Code_Practice]]. Companion to [[CS229 Math Cheatsheet]] and the lecture hub [[CS229 Lecture 2]]. True rule: $y = 5 + 2x + \text{noise}$, so the target is $\theta \approx [5, 2]$.

## Math ↔ code map

| Math (lecture notation) | Plain meaning | Code |
|---|---|---|
| $h_\theta(x) = \sum_j \theta_j x_j = \theta^T x$ | the model's prediction | `predictions = X @ theta` |
| $J(\theta) = \frac{1}{2m} \sum_i \big(h_\theta(x^{(i)}) - y^{(i)}\big)^2$ | how wrong, averaged over examples | `cost = (1/(2*m)) * (errors**2).sum()` |
| $\dfrac{\partial J}{\partial \theta_j} = \frac{1}{m} \sum_i \big(h_\theta(x^{(i)}) - y^{(i)}\big) x_j^{(i)}$ | the gradient (slope of the cost) | `gradient = (1/m) * X.T @ errors` |
| $\theta_j := \theta_j - \alpha \dfrac{\partial J}{\partial \theta_j}$ | step downhill | `theta = theta - alpha * gradient` |
| $\theta := \theta - \alpha (h_\theta(x^{(i)}) - y^{(i)}) x^{(i)}$ (SGD, one example) | step using a single point | `theta = theta - alpha * (xi.T @ error)` |
| $\theta = (X^T X)^{-1} X^T y$ | exact solve, no iteration | `theta = np.linalg.inv(X.T @ X) @ X.T @ y` |

## Shape reference

`m` = number of examples, `n` = number of features. **#params = #columns of `X` = n+1** (the +1 is the intercept column). For any `A @ B`, the inner dims must match and the shared dim is what gets summed away.

| Array | Shape | Why |
|---|---|---|
| `X` | `(m, n+1)` = `(100, 2)` | examples × (features + intercept column of 1s) |
| `y` | `(m, 1)` = `(100, 1)` | one target per example |
| `theta` | `(n+1, 1)` = `(2, 1)` | one parameter per column of `X` |
| `predictions` | `(m, 1)` = `(100, 1)` | `(m, n+1) @ (n+1, 1)` - one prediction per example |
| `errors` | `(m, 1)` = `(100, 1)` | `predictions - y`, element-wise, one residual per example |
| `gradient` | `(n+1, 1)` = `(2, 1)` | `(n+1, m) @ (m, 1)` - one partial derivative per parameter |
| `xi` / `yi` (SGD) | `(1, n+1)` / `(1, 1)` | one row kept 2D via `X[i:i+1]` (not `X[i]`, which collapses to `(2,)`) |

## The two summations (don't confuse them)

There are two different $\sum$ in this lecture, over two different indices:

- **Sum over features, index $j$** - lives *inside* the hypothesis $h_\theta(x) = \sum_j \theta_j x_j$. Combines a single example's features into **one** prediction. In code this is the inner dim of `X @ theta` (the shared `n+1`).
- **Sum over examples, index $i$** - lives *inside* the cost and gradient. Aggregates across the **whole dataset**. In code this is `.sum()` (cost) or the `m` inner dim of `X.T @ errors` (gradient).

Keep `m` (examples, the $i$ sum) and `n` (features, the $j$ sum) distinct - they are different axes of `X`.

## When `@` sums for you vs when you need `.sum()`

- **`@` (matmul / dot product)** already does *multiply-and-sum* over the shared inner dimension. So `X @ theta` and `X.T @ errors` need **no** `.sum()` - the sum is baked in. That's why the gradient line has an `X.T @ errors` and no separate `.sum()`.
- **Element-wise ops** (`errors ** 2`, `predictions - y`) do **not** sum - they return an array the same shape. To collapse them to a scalar you must call `.sum()` yourself, as in the cost `(errors ** 2).sum()`.

Rule of thumb: if the reduction is a *dot product structure* ($\sum a_k b_k$), let `@` do it. If it's *square-then-add* or any non-dot reduction, you need `.sum()`.

## Why `X.T` in the gradient

The formula multiplies each residual $(h-y)^{(i)}$ by that example's feature $x_j^{(i)}$ and sums over examples. In `X`, features sit in **columns** and examples in **rows**. Transposing to `X.T` `(n+1, m)` puts features in rows so that `X.T @ errors` = `(n+1, m) @ (m, 1) -> (n+1, 1)`: the matmul lines up each parameter's feature column against the residuals and sums over the `m` examples in one shot - exactly $\sum_i (h-y)^{(i)} x_j^{(i)}$ for every $j$ at once.

## Batch vs Stochastic vs Normal equation

| | Data per step | Convergence | Tradeoff |
|---|---|---|---|
| **Batch GD** | **all** $m$ examples (`X @ theta`, `X.T @ errors`) | smooth, monotonic cost drop | accurate but each step touches the whole dataset (slow for huge $m$) |
| **Stochastic GD** | **one** example (`xi @ theta`) | jittery, never fully settles | fast, cheap steps; lands *slightly off* the optimum (sampling noise - shrink $\alpha$ to tighten) |
| **Normal equation** | n/a - closed form | exact, one shot, no $\alpha$, no loop | must invert $X^T X$ `(n×n)`: $O(n^3)$, infeasible for large $n$, and **fails when $X^T X$ isn't invertible** |

Batch GD and the normal equation land on the **same** $\theta$ (both reach the global optimum of the convex bowl - proof that GD converges). This is why large-scale ML and deep learning use gradient descent instead of the normal equation: at scale the $O(n^3)$ inverse is a non-starter, and non-convex losses have no closed form anyway.

## Why the column of 1s

`X = np.c_[np.ones((m,1)), x]` glues a column of 1s in front of the data. That sets $x_0 = 1$ for every example, so the intercept $\theta_0$ is learned **inside the same matrix multiply** ($\theta_0 x_0 = \theta_0 \cdot 1 = \theta_0$) - no separate bias term to track. This is why `theta` has `n+1` rows, not `n`.

## No `1/m` in SGD

Batch GD averages the gradient over $m$ examples, so it carries a `1/m`. SGD's inner loop uses a **single** example, not an average - so there is **no** `1/m` factor (`gradient = xi.T @ error`). The inner loop `for i in range(m)` iterates over **examples**, not parameters.
