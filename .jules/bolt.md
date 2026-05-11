## 2024-05-23 - Redundant List Filtering in Build Method
**Learning:** Accessing computed properties (getters) that perform list filtering multiple times within a `build` method, especially inside a `ListView.itemBuilder`, leads to $O(N \cdot M)$ complexity where $N$ is total items and $M$ is visible items. This causes unnecessary list allocations and iterations on every frame.
**Action:** Cache the result of filtering getters in a local variable at the beginning of the `build` method to ensure filtering logic runs only once per frame.

## 2024-05-24 - Expensive Sorting in Build Methods
**Learning:** List sorting ((N \log N)$) is significantly more expensive than simple filtering ((N)$). When implemented in a getter and called multiple times within a `build` method (e.g., for `itemCount` and in `itemBuilder`), it can cause noticeable frame drops as the list grows, due to redundant heavy computations and memory allocations.
**Action:** Prioritize caching sorted lists in local variables at the start of the `build` method. This is especially critical for screens like `LabHomeScreen` where the sort logic involves string comparisons and multi-level priority weighting.
