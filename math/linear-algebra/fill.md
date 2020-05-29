# Fill

**Fill** occurs when matrix entries that are originally zero change to a non-zero value during the execution of an algorithm. This can be problematic when dealing with sparse matrices. When computing a factorization (ex: Cholesky, LU), we wish for the resulting factorization to be similarly sparse to the original matrix.

One example of a matrix that displays significant fill-in is the arrow matrix:

**arrow matrix here** **arrow matrix LU here**

To reduce fill, we can use **matrix reorderings**. By switching around rows and columns, we can reduce the **envelope** of a matrix. The **envelope** is the region in which fill can occur.

**envelope example here**

## Culthill-Mckee

We can use the Culthill-Mckee algorithm to produce a reordering of a graph. Such an ordering depends upon a graph's **level sets**, a partitioning of the graph based upon distance from a starting node. Level sets are dependent upon which node is the starting node.