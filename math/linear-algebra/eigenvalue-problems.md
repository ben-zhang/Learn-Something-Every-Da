# Eigenvalue Problems

## QR Iteration

Using this method, we aim to find *more than one* eigenvector/eigenvalue pair at the same time.

**Definition:** Two matrices A and B are **similar** if $$B = X^{-1}AX$$ for some non-singular $$X$$.

**Definition**: If $$X \in \mathbb{R}^{nxn}$$ is nonsingular, then $$A -> X^{-1}AX$$ is called a **similarity transformation**  of A. 

**Theorem:** If $$A$$ and $$B$$ are similar, they have the same characteristic polynomial, and hence the same eigenvalues.

*Proof: Exercise for the reader (check Wikipedia, it was too much to Latex.)*

For the **QR Iteration**, we apply a series of similarity transformations to $$A$$ to converge on a diagonal matrix. The diagonal of a diagonal matrix is its eigenvalues.

Like the name suggests, we use the QR factorization of A to achieve this. The following is a key property of the algorithm:

Given $$A^{(k-1)}$$ with factors $$Q^k$$ and $$R^k$$, we have $$R^k = (Q^k)^TA^{k-1}$$. Hence, we have

$$ A^k \equiv R^kQ^k = (Q^k)^TA^{k-1}Q^k$$ 

We thus have that $$A^k$$ and $$A^{(k-1)}$$ are similar. The QR Iteration repeats the process until it achieves the desired result.

