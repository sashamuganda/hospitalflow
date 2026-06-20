## 2024-05-23 - Redundant List Filtering in Build Method
**Learning:** Accessing computed properties (getters) that perform list filtering multiple times within a `build` method, especially inside a `ListView.itemBuilder`, leads to $O(N \cdot M)$ complexity where $N$ is total items and $M$ is visible items. This causes unnecessary list allocations and iterations on every frame.
**Action:** Cache the result of filtering getters in a local variable at the beginning of the `build` method to ensure filtering logic runs only once per frame.

## 2026-06-20 - Expensive Sorting in Build Method
**Learning:** Calling a getter that performs a list sort ((N \log N)$) multiple times inside a `build` method (e.g., once for `itemCount` and once for each item in `ListView.itemBuilder`) leads to (M \cdot N \log N)$ complexity, where $ is the number of visible items.
**Action:** Cache sorting or filtering results in a local variable at the start of the `build` method to ensure the operation runs exactly once per build cycle.
