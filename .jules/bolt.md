## 2024-05-23 - Redundant List Filtering in Build Method
**Learning:** Accessing computed properties (getters) that perform list filtering multiple times within a `build` method, especially inside a `ListView.itemBuilder`, leads to $O(N \cdot M)$ complexity where $N$ is total items and $M$ is visible items. This causes unnecessary list allocations and iterations on every frame.
**Action:** Cache the result of filtering getters in a local variable at the beginning of the `build` method to ensure filtering logic runs only once per frame.

## 2024-05-24 - Consolidating Multiple List Traversals
**Learning:** Calculating multiple independent metrics from the same collection (e.g., filtered lists, status counts, and category breakdowns) using separate `.where()` calls or loops results in $O(N \cdot K)$ complexity where $K$ is the number of metrics. In screens like `QueueHomeScreen`, this can lead to 8+ redundant passes over the same data.
**Action:** Use a single `for` loop to compute all required collection-based values in one pass, reducing complexity to $O(N)$.
