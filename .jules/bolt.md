## 2024-05-23 - Redundant List Filtering in Build Method
**Learning:** Accessing computed properties (getters) that perform list filtering multiple times within a `build` method, especially inside a `ListView.itemBuilder`, leads to $O(N \cdot M)$ complexity where $N$ is total items and $M$ is visible items. This causes unnecessary list allocations and iterations on every frame.
**Action:** Cache the result of filtering getters in a local variable at the beginning of the `build` method to ensure filtering logic runs only once per frame.

## 2024-05-24 - Redundant List Sorting in Build Method
**Learning:** Performing a sort operation inside a getter that is accessed multiple times during a `build` cycle (e.g., for `itemCount` and within `itemBuilder`) leads to $O(M \cdot N \log N)$ complexity. Sorting is significantly more expensive than simple filtering.
**Action:** Always hoist sorting logic out of the `itemBuilder` loop by caching the sorted list in a local variable at the start of the `build` method.
