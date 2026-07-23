---
dateCreated: 2026-07-22 00:00:00
dateModified: 2026-07-22 00:00:00
tags: index
title: CS229 PS1 - Problem 5 LWR
status: draft
units:
  - "[[CS229]]"
up:
  - "[[CS229]]"
---

# CS229 PS1 - Problem 5 LWR

Worked solutions to **CS229 Problem Set 1, Problem 5** - locally weighted linear regression. Puts the [[CS229 Lecture 3]] theory into practice: derive the weighted [[Normal equations]], read it as [[Maximum likelihood estimation]] with per-example variance, then implement and tune it. See [[NumPy Matplotlib Cheatsheet]] for the numpy reference this problem drills, [[CS229 Lecture 3 Cheatsheet]] for the lecture quick-ref, and [[CS229 Math Cheatsheet]] for the matrix-calculus formulas.

> [!warning] Draft - in progress
> **5(a) complete, 5(b) code working. 5(c) (tau sweep) not yet done.** 5(b)'s under/overfitting answer is tentative pending the sweep. This note is appended to on the next pass - do not create a second PS1 Problem 5 note.

> [!info] Concepts used
> [[Locally weighted regression]], [[Bandwidth]], [[Normal equations]], [[Maximum likelihood estimation]], [[Gaussian distribution]], [[Quadratic Form]], [[Design matrix]], [[Parametric vs non-parametric]], [[Cost function]].

---

## 5(a)(i) - Matrix form of the weighted cost

Show that $J(\theta) = \tfrac{1}{2}\sum_{i=1}^{m} w^{(i)}(\theta^Tx^{(i)} - y^{(i)})^2$ equals $(X\theta - y)^TW(X\theta - y)$, and specify $W$.

**Answer:**
$$\boxed{W = \tfrac{1}{2}\,\text{diag}\!\left(w^{(1)}, \dots, w^{(m)}\right) \in \mathbb{R}^{m \times m}}$$
i.e. $W_{ij} = \tfrac{1}{2}w^{(i)}$ when $i=j$, and $0$ otherwise.

**Reasoning.** Let $e = X\theta - y$ (shape $m \times 1$), so $e_i = \theta^Tx^{(i)} - y^{(i)}$ is the error on example $i$. Then:

- Expanding the matrix form is a [[Quadratic Form]]: $e^TWe = \sum_i\sum_j W_{ij}e_ie_j$ - a **double** sum, because sandwiching a matrix between two vectors pairs every entry with every entry.
- The target, with the $\tfrac{1}{2}$ pushed inside the sum: $J(\theta) = \sum_i \left(\tfrac{1}{2}w^{(i)}\right)e_i^2$ - only $e_i^2$ terms, **no cross terms** $e_ie_j$ for $i \neq j$.
- Matching term by term: the $e_i^2$ coefficient forces $W_{ii} = \tfrac{1}{2}w^{(i)}$; the absence of cross terms forces $W_{ij} = 0$ for $i \neq j$.

**Key ideas.**

- The $\tfrac{1}{2}$ and $w^{(i)}$ merge into a single coefficient per example, and that coefficient *is* $W_{ii}$.
- **Diagonal, not identity.** The identity has all 1s; here the diagonal entries differ per example - that difference is what "weighted" means. If all $w^{(i)} = 1$, $W$ becomes $\tfrac{1}{2}I$ and this collapses to plain least squares (the ordinary [[Cost function]]).
- Diagonality encodes independence: each example's error only interacts with itself. Off-diagonals would couple different examples, which $J$ never does.
- **Why bother with matrix form at all:** you cannot do matrix calculus on a $\Sigma$. This part is setup for (ii).

## 5(a)(ii) - The weighted normal equation

**Answer:**
$$\boxed{\theta = (X^TWX)^{-1}X^TWy}$$

**Derivation.** With $u = X\theta - y$, $J(\theta) = u^TWu$. By the quadratic-form gradient (see [[CS229 PS0 - Solutions]] Problem 1) plus the [[Chain Rule]], and using $\partial u/\partial\theta = X$:
$$\nabla_\theta J = 2X^TW(X\theta - y)$$
(The 2 cancels against the $\tfrac{1}{2}$ inside $W$; either way it vanishes when set to zero.) Setting to zero and distributing $X^TW$ across **both** terms in the parentheses:
$$X^TWX\theta - X^TWy = 0 \;\Longrightarrow\; X^TWX\theta = X^TWy$$
Left-multiply by $(X^TWX)^{-1}$ (matrices have no division; "divide on the left" = left-multiply by the inverse):
$$\theta = (X^TWX)^{-1}X^TWy$$

**Key ideas.**

- $W$ appears in **both** places - $(X^TWX)$ *and* $X^TWy$. Dropping the second one does not crash; it silently produces wrong predictions. (This actually happened during implementation: MSE was 18.26 instead of 0.33, with edge predictions exploding to $-20$.)
- Compare to the unweighted [[Normal equations]] $\theta = (X^TX)^{-1}X^Ty$ - identical structure, $W$ inserted wherever $X$ meets $X$ or $y$.
- Sanity check: all $w^{(i)} = 1 \Rightarrow W = \tfrac{1}{2}I$, the halves cancel, and the plain normal equation is recovered.

## 5(a)(iii) - Weighted LR as MLE with per-example variance

Given $p(y^{(i)}|x^{(i)};\theta) = \frac{1}{\sqrt{2\pi}\sigma^{(i)}}\exp\!\left(-\frac{(y^{(i)} - \theta^Tx^{(i)})^2}{2(\sigma^{(i)})^2}\right)$, show MLE reduces to weighted least squares and identify $w^{(i)}$.

**Answer:**
$$\boxed{w^{(i)} = \frac{1}{(\sigma^{(i)})^2}}$$

**Reasoning.** Same [[Maximum likelihood estimation]] recipe as the [[CS229 Lecture 3]] probabilistic interpretation, but each example now has its own variance. The [[Log-likelihood]]'s $\theta$-dependent part is $-\sum_i \frac{(y^{(i)} - \theta^Tx^{(i)})^2}{2(\sigma^{(i)})^2}$, so maximizing it means minimizing $\sum_i \frac{1}{(\sigma^{(i)})^2}(y^{(i)} - \theta^Tx^{(i)})^2$ - a weighted least squares problem with weight $1/(\sigma^{(i)})^2$.

**Intuition.** Weight is inversely proportional to variance: a noisy (high-variance) example is unreliable and gets a small weight; a precise (low-variance) one gets a large weight. This is what makes weighting *principled* rather than ad hoc - it falls out of MLE when examples have differing noise levels. Note the [[Gaussian distribution]] here is a genuine density (unlike the LWR distance weight, which only borrows the bell shape).

---

## 5(b) - Implementation

Trained on `ds5_train.csv` (m=300, n=2 with intercept), evaluated on `ds5_valid.csv` (200 points), with [[Bandwidth]] $\tau = 0.5$.

**Result: validation MSE = 0.3305.**

```python
import numpy as np

class LocallyWeightedRegression:
    def __init__(self, tau):
        self.tau = tau
        self.x = None
        self.y = None

    def fit(self, x, y):
        # non-parametric: nothing to learn, just keep the data
        self.x = x
        self.y = y

    def predict(self, x):
        m_query = x.shape[0]
        preds = np.zeros(m_query)

        for i in range(m_query):
            diff = self.x - x[i]                          # (300, 2)
            sq_dist = np.sum(diff**2, axis=1)             # (300,)
            w = np.exp(-sq_dist / (2 * self.tau**2))      # (300,)
            W = np.diag(w)                                # (300, 300)
            theta = np.linalg.inv(self.x.T @ W @ self.x) @ self.x.T @ W @ self.y
            preds[i] = theta @ x[i]

        return preds
```

**Notes on the implementation.**

- `fit()` is nearly empty because LWR is **non-parametric** (see [[Parametric vs non-parametric]]) - there is no single $\theta$, so nothing can be learned up front. The data *is* the model, and storage grows with the training set.
- All the work is in `predict()`: one complete weighted fit per query point. 200 query points = 200 separate matrix inversions, each using all 300 training examples.
- The [[Normal equations]] (rather than [[Gradient descent]]) is the right optimizer here precisely *because* of that repetition - a closed form solved 200 times beats 200 gradient-descent runs. With only 2 parameters the inverse is trivially cheap.
- Everything inside the loop except `preds[i] = ...` is temporary and discarded each iteration.
- The `1.` column in `x` is the intercept (the [[Design matrix]] $x_0 = 1$ trick), added by `util.load_dataset(..., add_intercept=True)`. It cancels in `diff`, so it correctly contributes nothing to distance.

**Under- or overfitting?** *Tentative: overfitting* - the fitted curve shows several distinct wiggles while the training data is very noisy ($\pm 1.2$ spread at most $x$), suggesting it may be tracking noise clumps rather than real structure. **To be confirmed by the 5(c) sweep:** if a larger $\tau$ lowers validation MSE, overfitting is confirmed; if a smaller $\tau$ wins, it was actually underfitting.

## 5(c) - Tuning tau - NOT YET DONE

> [!todo] Placeholder - to be added next pass
> Sweep $\tau \in \{0.03, 0.05, 0.1, 0.5, 1.0, 10\}$ (values from `run.py`), pick the lowest validation MSE, then report test-set MSE with that $\tau$.

**Direction of $\tau$ (worth recording now, since it was initially confused):** $\tau$ is the [[Bandwidth]] - the *width* of the weighting bell curve, and it sits in the denominator of the exponent.

- **Small $\tau$** produces weights that collapse quickly with distance, a narrow neighbourhood, a jagged fit, hence **overfitting**.
- **Large $\tau$** keeps weights high far away, a wide neighbourhood, a smooth near-flat fit, hence **underfitting**.
- At $\tau = 10$, effectively all weights $\approx 1$, so $W \approx I$ and LWR degenerates into plain linear regression.

---

## Train / validation / test

- **train** - the model sees both $x$ and $y$; this is the only knowledge it has.
- **validation** - the model sees $x$ only. `x_valid` is a list of *locations* to be asked about, carrying no answers into the model. `y_valid` is withheld and used solely to compute MSE afterward.
- **test** - opened once, at the very end, after $\tau$ is chosen. Because $\tau$ is tuned against validation, the validation score is optimistic; the test set gives an honest final number.

---

See also: [[Locally weighted regression]] (the atom this problem implements), [[Bandwidth]] (the $\tau$ dial 5(c) tunes), and [[NumPy Matplotlib Cheatsheet]] (the numpy patterns used in the code).
