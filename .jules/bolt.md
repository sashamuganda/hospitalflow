## 2024-05-23 - Redundant List Filtering in Build Method
**Learning:** Accessing computed properties (getters) that perform list filtering multiple times within a `build` method, especially inside a `ListView.itemBuilder`, leads to $O(N \cdot M)$ complexity where $N$ is total items and $M$ is visible items. This causes unnecessary list allocations and iterations on every frame.
**Action:** Cache the result of filtering getters in a local variable at the beginning of the `build` method to ensure filtering logic runs only once per frame.

## 2024-05-24 - Combining Traversals for Multiple Computed States
**Learning:** When a screen requires multiple derived states from the same source list (e.g., a filtered list and a global count), performing separate `where` or `length` operations leads to multiple (N)$ traversals.
**Action:** Use a single-pass for-loop at the start of the `build` method to collect all required derived values in (N)$, especially when these values are used in high-frequency areas like `ListView.itemBuilder`.
