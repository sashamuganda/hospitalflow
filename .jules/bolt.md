## 2024-05-23 - Redundant List Filtering in Build Method
**Learning:** Accessing computed properties (getters) that perform list filtering multiple times within a `build` method, especially inside a `ListView.itemBuilder`, leads to $O(N \cdot M)$ complexity where $N$ is total items and $M$ is visible items. This causes unnecessary list allocations and iterations on every frame.
**Action:** Cache the result of filtering getters in a local variable at the beginning of the `build` method to ensure filtering logic runs only once per frame.

## 2026-06-12 - Consolidated Single-Pass Traversal
**Learning:** Derived state in Flutter 'build' methods often involves multiple independent filters/scans (e.g., counts, filtered lists) over the same data source. Consolidating these into a single O(N) traversal reduces CPU overhead and intermediate list allocations significantly as the data set grows.
**Action:** Use a single loop to calculate all metrics and filter the main display list simultaneously when multiple 'where' or 'length' calls are present on the same collection.
