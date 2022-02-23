This has been a much more difficult problem than what I anticipated.

Mostly I picked it up because I recently had this situation popup at work, where a crude heuristic was more than enough, but I wanted to know what it would take to get an optimal solution. And of course it's an NP-Hard?Complete? problem.

Now I'm going through and optimizing my brute force method.

## Optimizations
1. Don't save the whole tree to memory. -- exhaustiveTree1 -> exhaustiveTree2
2. Use combinations not permutaitons. -- exhaustiveTree2 -> combinations
3. Don't generate everything, exit early. -- combinations -> combinationsFastDFS
4. [TODO] Use BFS so we can avoid the expensively numerious end leafs
