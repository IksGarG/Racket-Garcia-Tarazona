# Activity 3.1 - Regular languages

Reference for math symbols:
https://www.overleaf.com/learn/latex/List_of_Greek_letters_and_math_symbols

## Names:
- name1
- name2


## Exercises:

1. Let $X$ be a finite set. Give a recursive definition of the set of subsets
    of $X$ (the Power set of $X$) $P(X)$.
    Use union as the operator on the definition

    _**SOLUTION:**_

    $P(X) = \{ A \cup \{x\} \mid A \in P(X), x \in X \} \cup P(X)$



2. Prove by induction on $n$ that:

    $\sum_{i=0}^{n}i^3 = \frac{n^2(n+1)^2}{4}$

    _**SOLUTION:**_:e
    
    I. Basis: if $n=0$ then $\sum_{i=0}^{0}i^3 = \frac{0^2(0+1)^2}{4} = 0$

    II. Inductive Hypothesis: if $n=k$ then it holds that:

    $\sum_{i=0}^{k}i^3=\frac{k^2(k+1)^2}{4}$

    III. Inductive Step: For $n=(k+1)$

    $\sum_{i=0}^{k+1}i^3=\frac{(k+1)^2((k+1)+1)^2}{4}$

    $\sum_{i=0}^{k}i^3 + (k+1)^3=\frac{(k+1)^2((k+1)+1)^2}{4}$

    $\frac{k^2(k+1)^2}{4} + (k+1)^3 =\frac{(k+1)^2((k+1)+1)^2}{4}$

    $\frac{k^2(k+1)^2}{4} + \frac{4(k+1)^3}{4} =\frac{(k+1)^2((k+1)+1)^2}{4}$

    $\frac{k^2(k+1)^2+4(k+1)^3}{4}=\frac{(k+1)^2((k+1)+1)^2}{4}$

    $\frac{(k^2+4k+4)(k+1)^2}{4}=\frac{(k+1)^2((k+1)+1)^2}{4}$

    $\frac{(k+2)^2(k+1)^2}{4}=\frac{(k+1)^2((k+1)+1)^2}{4}$

    $\frac{(k+1)^2((k+1)+1)^2}{4}=\frac{(k+1)^2((k+1)+1)^2}{4}$

Then, we can infer that the sum applies for all $n$




3. Using the tree below, give the values of each of the items:
![Tree image](sample_tree.png)

    a. the depth of the tree

    The tree is 5 levels deep.

    b. the ancestors of x18

    x18 has the following ancestors: {x15, x10, x4, x1}.

    c. the internal nodes of the tree

    The internal nodes of the tree are: {x2, x3, x4, x5, x6, x7, x13, x10, x15}

    d. the length of the path from x3 to x14

    The length of the path from x3 to x14 is 2.

    e. the vertex that is the parent of x16

    The vertex that is the parent of x16 is x15.

    f. the vertices children of x7

    The vertices children of x7 are {x13, x14}.
