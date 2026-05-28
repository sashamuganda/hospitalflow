## 2024-05-23 - Redundant List Filtering in Build Method
**Learning:** Accessing computed properties (getters) that perform list filtering multiple times within a `build` method, especially inside a `ListView.itemBuilder`, leads to $O(N \cdot M)$ complexity where $N$ is total items and $M$ is visible items. This causes unnecessary list allocations and iterations on every frame.
**Action:** Cache the result of filtering getters in a local variable at the beginning of the `build` method to ensure filtering logic runs only once per frame.

## 2026-05-28 - Inefficient List Filtering in Build Method (Part 2)
**Learning:** Even when query transformations (like `.toLowerCase()`) are hoisted outside the `where` closure, redundant calls to a filtering getter still cause multiple $O(N)$ iterations and list allocations per build cycle.
**Action:** Always cache computed/filtered lists in a local variable at the start of the `build` method if they are accessed more than once (e.g., for empty checks, length display, and `ListView` initialization).
