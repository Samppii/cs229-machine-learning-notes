# NumPy / Matplotlib Cheatsheet

A coding reference built from the locally weighted regression implementation in [[CS229 PS1 - Problem 5 LWR]]. This is the *code* companion - distinct from [[CS229 Math Cheatsheet]] (matrix calculus) and [[CS229 Lecture 3 Cheatsheet]] (lecture content). See [[CS229 Lecture 3]] for the theory and [[Locally weighted regression]] for the algorithm.

---

## Loading data

```python
x_train, y_train = util.load_dataset('data/ds5_train.csv', add_intercept=True)
```

Returns two arrays: features `(300, 2)` and labels `(300,)`. `add_intercept=True` prepends a column of `1.`s (the $x_0 = 1$ trick), so column 0 is the dummy intercept and column 1 the real feature.

Without util: `np.loadtxt('file.csv', delimiter=',', skiprows=1)`

## Shapes

```python
a.shape        # (300, 2) - tuple of dimensions
a.shape[0]     # rows
a.shape[1]     # columns
a.ndim         # number of dimensions
```

`(300,)` is a flat 1-D array; `(300, 1)` is a 2-D column matrix. Both hold 300 numbers but behave differently. Labels come back as `(300,)` and work fine in matrix multiplication.

## Slicing - `[rows, columns]`

```python
a[:3]        # first 3 rows
a[0]         # row 0
a[-1]        # last row
a[:, 0]      # all rows, column 0
a[:, -1]     # all rows, last column   <- used for plotting (skips the intercept)
```

## Creation

```python
np.zeros(5)          np.zeros((3, 2))     np.ones(5)
np.eye(3)            np.array([1, 2, 3])
np.arange(0, 10, 2)  np.linspace(0, 1, 5)
```

`np.zeros(m)` pre-allocates an output array to fill in a loop.

## Elementwise math

```python
a + b   a - b   a * b   a / b   a ** 2
np.exp(a)   np.log(a)   np.sqrt(a)   np.abs(a)
```

`*` is **elementwise**, not matrix multiply. Use `@` for matrix multiply.

## Broadcasting

```python
self.x - x[i]     # (300, 2) - (2,) -> (300, 2)
```

The single row is subtracted from every row. No loop needed.

## Reductions and `axis`

```python
np.sum(a)             # everything -> one number
np.sum(a, axis=0)     # collapse rows -> one value per column
np.sum(a, axis=1)     # collapse columns -> one value per row
np.mean(a)   np.min(a)   np.max(a)
np.argmin(a)  np.argmax(a)   # INDEX of min/max, not the value
```

**`axis` = the dimension that disappears.** `axis=1` gives one number per example.

## Matrix operations

```python
A @ B                  # matrix multiply
A.T                    # transpose
np.linalg.inv(A)       # inverse
np.linalg.solve(A, b)  # solves Ax=b - preferable to inv where possible
np.diag(v)             # 1-D array -> diagonal matrix
np.diag(M)             # matrix -> its diagonal as 1-D (same function both ways)
np.linalg.norm(a, axis=1)   # row-wise magnitudes
```

The weighted [[Normal equations]] `theta = inv(X.T @ W @ X) @ X.T @ W @ y` is a direct transcription of $\theta = (X^TWX)^{-1}X^TWy$; `np.diag(w)` builds the weight matrix $W$ from the 1-D weight vector.

## Model class pattern (`fit` / `predict`)

```python
class MyModel:
    def __init__(self, hyperparam):   # settings you choose; no data yet
        self.hyperparam = hyperparam
        self.x = None
    def fit(self, x, y):              # learn from training data
        ...
    def predict(self, x):             # x-values in, y-guesses out
        return preds
```

`self` = this specific object; it is how `fit` stores something `predict` reads later. Without `self.`, a variable vanishes when the function returns. This is the scikit-learn convention every model follows, which is why models are interchangeable in code. (For LWR, `fit` just stores the data because the model is [[Parametric vs non-parametric|non-parametric]].)

## Metrics

```python
mse  = np.mean((y_pred - y_true)**2)
rmse = np.sqrt(mse)
mae  = np.mean(np.abs(y_pred - y_true))
acc  = np.mean(y_pred == y_true)
```

## Dictionaries (hyperparameter sweeps)

```python
results = {}
results[tau] = mse
min(results, key=results.get)    # KEY with the smallest value
for k, v in results.items(): ...
```

Used for the [[Bandwidth]] $\tau$ sweep in PS1 Problem 5(c).

## f-strings

```python
print(f'tau={tau}: MSE={mse:.4f}')   # :.4f = 4 decimals, :.2e = scientific
```

## matplotlib

```python
plt.figure(figsize=(8, 5))
plt.plot(x, y, 'bx', label='train')          # blue crosses
plt.plot(x2, y2, 'ro', label='predictions')  # red circles
plt.xlabel('x');  plt.ylabel('y');  plt.legend()
plt.title(f'tau={tau}, MSE={mse:.4f}')
plt.show()
```

Format string = colour + marker. Colours `b r g k m`; markers `x o . - --`.
Call `plt.figure()` at the start of each loop iteration or plots stack onto one figure.

## Colab

```python
from google.colab import drive; drive.mount('/content/drive')
%cd /content/drive/MyDrive/cs229      # magic command
!ls   !cat file.py   !cp -r src dst   # shell commands
import sys; sys.path.append('.../src')  # so imports resolve
%%writefile src/file.py                 # write cell contents to a file
```

`/content/` is a temporary VM - wiped when the runtime dies. Work out of Drive or push to GitHub. **Editing a cell does nothing until you re-run it** - a common trap when changing a class.

## Debugging shapes

Print shapes at every step; most numpy bugs are shape bugs. Expected for LWR (m=300, n=2):

| variable | shape |
|---|---|
| `self.x` | (300, 2) |
| `x[i]` | (2,) |
| `diff` | (300, 2) |
| `sq_dist` | (300,) |
| `w` | (300,) |
| `W` | (300, 300) |
| `theta` | (2,) |
| `preds[i]` | scalar |
