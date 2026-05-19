## 2024-05-23 - Redundant List Filtering in Build Method
**Learning:** Accessing computed properties (getters) that perform list filtering multiple times within a `build` method, especially inside a `ListView.itemBuilder`, leads to $O(N \cdot M)$ complexity where $N$ is total items and $M$ is visible items. This causes unnecessary list allocations and iterations on every frame.
**Action:** Cache the result of filtering getters in a local variable at the beginning of the `build` method to ensure filtering logic runs only once per frame.

## 2026-05-19 - Optimized Categorical Sorting in Build Loops
**Learning:** Using conditional string comparisons and transformations (e.g., `toLowerCase()`) inside a sort comparator within a `build` method or `ListView.itemBuilder` leads to redundant (N \log N)$ operations every time the list is accessed. This is especially costly when the getter is called multiple times (e.g., for `itemCount` and `itemBuilder`).
**Action:** Use a constant weight map and the null-aware operator to perform categorical sorting efficiently. Always hoist the sorted list computation to a local variable at the start of the `build` method.
