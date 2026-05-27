## 2024-05-23 - Redundant List Filtering in Build Method
**Learning:** Accessing computed properties (getters) that perform list filtering multiple times within a `build` method, especially inside a `ListView.itemBuilder`, leads to $O(N \cdot M)$ complexity where $N$ is total items and $M$ is visible items. This causes unnecessary list allocations and iterations on every frame.
**Action:** Cache the result of filtering getters in a local variable at the beginning of the `build` method to ensure filtering logic runs only once per frame.

## 2024-05-24 - Efficient Categorical Sorting
**Learning:** Using nested ternary operators or complex conditional logic inside `list.sort` for categorical data (e.g., priorities) is inefficient and scales poorly. String transformations (like `toLowerCase()`) inside the comparator further degrade performance.
**Action:** Implement a `static const` weight map for categorical priorities and use the null-aware operator (`??`) to provide default weights. This reduces the comparator to a simple map lookup and integer comparison.
