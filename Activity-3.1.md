# Activity 3.1 - Regular languages

Reference for math symbols:
https://www.overleaf.com/learn/latex/List_of_Greek_letters_and_math_symbols

## Names:
- Andres Tarazona Solloa
- Iker Garcia German


## Exercises:

1. Give a recursive definition of the set of strings over $\{a, b\}$ that
    contain at least one $b$ and have an even number of $a$’s before the
    first $b$.
    For example: $aab$, $bab$ and $aaaabbabababa$ are in the set,
    but $abb$, $aaab$ and $aa$ are not

    _**SOLUTION:**_

    Let S be the set of strings over $\{a, b\}$ that contain at least one bb and have an even number of aa's before the first $bb$.

    Base cases:

    "$bb$" is in $S$.

    "$abb$" is not in $S$.

    Recursive cases:

    If a string starts with "$a$", then it must be followed by another "$a$" to maintain an even number of "$a$"s before the first "$bb$". After the two "$a$"s, any string in $S$ can follow.

    If a string starts with "$b$", then any string in $S$ can follow.
    Therefore, we can define $S$ recursively as follows:

    Base case 1: "$bb$" is in $S$.
    Base case 2: "$abb$" is not in $S$.
    Recursive case 1: if $s = a + a + t$, where $t$ is any string in $S$, then $s$ is in $S$.
    Recursive case 2: if $s = b + t$, where $t$is any string in $S$, then $s$ is in $S$.



2. Let $X = \{aa, bb\}$ and $Y = \{\lambda, b, ab\}$.

    a. List the strings in set $XY$

    #|string|#|string|#|string|#|string
    -|-|-|-|-|-|-|-
    1|$aab$|2|$abb$|3|$baa$|4|$bbb$

    b. How many strings of length 6 are there in $X^*$?

    To find the number of strings of length 6 in $X^*$, we need to consider all possible combinations of strings from $X$ that have a total length of 6.

    - If we choose two $aa$ 's, we get the string $aaaaaa$ , which has length 6.
    - If we choose three $bb$ 's, we get the string $bbbbbb$ , which has length 6.
    - If we choose one $aa$ and one $bb$, we get two possibilities: $aabbaa$ and $abbbaa$, both of which have length 6.
    
    Therefore, there are three distinct strings of length 6 in $X^*$: $aaaaa$, $bbbbbb$, and $aabbaa/abbbaa$. The strings $aaabbb$ and $bbaaaa$ are not in $X^*$ since they cannot be formed by concatenating strings in $X$.

    c. List the strings in set $Y^*$ of length three or less

    #|string|#|string|#|string|#|string|#|string
    -|-|-|-|-|-|-|-|-|-
    1|$b$|2|$ab$|3|$aab$|4|$bab$|5|$ba$



    d. List the strings in set $X^* Y^*$ of length four or less

    #|string|#|string|#|string|#|string|#|string
    -|-|-|-|-|-|-|-|-|-
    1|$\lambda$|2|$a$|3|$b$|4|$ab$|5|$aab$
    6|$aba$|7|$abb$|8|$aabb$|9|$baa$|10|$bab$
    11|$bba$|12|$bb$|13|$aaa$|14|$aab$|15|$abb$
    16|$bbb$|17|$aaab$|18|$aabb$|19|$abab$|20|$abbb$
    21|$baa$|22|$baab$|23|$babb$|24|$bbbb$

3.  Give a recursive definition of the set $\{ a^ib^j | 0 ≤ i ≤ j ≤ 2i\}$

    _**SOLUTION:**_

    - Base case: The empty string $\lambda$ is in the set, i.e., $\lambda \in \{ a^ib^j | 0 \leq i \leq j \leq 2i \}$.
    - Recursive cases:

        - If $i = j$, then $a^ib^j = a^jb^j$ is in the set if and only if $j \leq 2i$. This case can be expressed as $a^jb^j \in \{ a^ib^j | 0 \leq i \leq j \leq 2i \}$ if $j \leq 2i$.
        - If $i < j$, then $a^ib^j$ is in the set if and only if $a^{\{i\}}b^{\{j-1\}}$ is in the set and $j \leq 2i$. This case can be expressed as $a^ib^j \in \{ a^ib^j | 0 \leq i \leq j \leq 2i \}$ if $a^{\{i\}}b^{\{j-1\}} \in \{ a^ib^j | 0 \leq i \leq j \leq 2i \}$ and $j \leq 2i$.

    - Therefore, using these base and recursive cases, we can recursively define the set $\{ a^ib^j | 0 \leq i \leq j \leq 2i \}$.


4. Let $L$ be the set of strings over $\{a, b\}$ generated by the recursive
   definition

    **I. Basis:** $b \in L$

    **II. Recursive Step**: If $u \in L$ then $ub \in L$, $uab \in L$, $uba \in
    L$ and $bua \in L$

    **III. Closure**: A string $u \in L$ only if it can be obtained from the
    basis using a finite number of applications of the recursive step.

    **a.** List the elements in the sets $L_0, L_1, L_2$


    **b.** Is the string $bbaaba$ in $L$? If so, trace how it is produced.
    If not, explain why not.


    **c.** Is the string $bbaaaabb$ in $L$? If so, trace how it is produced.
    If not, explain why not


5. Prove, using induction on the length of a string, that $(w^R)^R = w$ for all string $w \in \Sigma$

    _**SOLUTION:**_

    a. List the elements in the sets $L_0, L_1, L_2$

    $L_0 = {b}$

    $L_1 = {ba, ab, bb, bba, bab, abb}$

    $L_2 = {baa, aba, baaab, baba, baabb, babab, abbba, ababb, abbab, babba, babaa, bbaa, babbba, bababa, baabab, baabba}$

    b. Is the string $bbaaba$ in $L$? If so, trace how it is produced. If not, explain why not.

    Yes, the string $bbaaba$ is in $L$. It can be produced as follows:
    $$b \in L \Rightarrow bb \in L \Rightarrow bb \text{ }a \in L \Rightarrow bba \text{ }a \in L \Rightarrow bbaa \text{ }b \in L \Rightarrow bbaab \text{ }a \in L$$

    c. Is the string $bbaaaabb$ in $L$? If so, trace how it is produced. If not, explain why not.

    No, the string $bbaaaabb$ is not in $L$. To see why, note that any string in $L$ can be written in the form $w = u_1u_2\cdots u_n$ where each $u_i$ is one of $b$, $ba$, $ab$, $uba$ or $bau$ for some $n\geq 0$. However, $bbaaaabb$ cannot be written in this form. Specifically, any such representation of $bbaaaabb$ would have to end with either $b$ or $ba$, which is not the case. Therefore, $bbaaaabb \notin L$.

    Proof of $(w^R)^R = w$ by induction on the length of $w$

    Base case: If $w$ is the empty string, then $(w^R)^R = (\lambda^R)^R = \lambda^R = \lambda = w$, so the property holds.

    Inductive step: Assume that $(u^R)^R = u$ for all strings $u$ of length at most $n$. Let $w$ be a string of length $n+1$. Then we can write $w$ as $w = xu$ for some non-empty string $u$ and symbol $x$. Note that $w^R = ux^R$ and $(u^R)^R = u$, so we have:

    $$(w^R)^R = (ux^R)^R = x^{RR}u^{RR} = xu = w$$

    Thus, $(w^R)^R = w$ for a
