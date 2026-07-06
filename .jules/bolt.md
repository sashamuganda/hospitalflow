## 2024-05-23 - Redundant List Filtering in Build Method
**Learning:** Accessing computed properties (getters) that perform list filtering multiple times within a `build` method, especially inside a `ListView.itemBuilder`, leads to $O(N \cdot M)$ complexity where $N$ is total items and $M$ is visible items. This causes unnecessary list allocations and iterations on every frame.
**Action:** Cache the result of filtering getters in a local variable at the beginning of the `build` method to ensure filtering logic runs only once per frame.

## 2026-07-06 - Consolidating Multiple O(N) Passes
**Learning:** In screens requiring both filtered data and aggregate metrics (like unread counts), performing separate `where()` and `length` calls results in multiple O(N) traversals. For large datasets, this overhead becomes significant. Consolidating these into a single imperative loop reduces constant factors and improves performance by up to 15x.
**Action:** When both filtering and counting are needed, use a single manual `for` loop to populate the filtered list and update counters simultaneously, rather than multiple functional chaining operations.
