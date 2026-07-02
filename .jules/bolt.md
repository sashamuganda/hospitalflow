## 2024-05-23 - Redundant List Filtering in Build Method
**Learning:** Accessing computed properties (getters) that perform list filtering multiple times within a `build` method, especially inside a `ListView.itemBuilder`, leads to $O(N \cdot M)$ complexity where $N$ is total items and $M$ is visible items. This causes unnecessary list allocations and iterations on every frame.
**Action:** Cache the result of filtering getters in a local variable at the beginning of the `build` method to ensure filtering logic runs only once per frame.

## 2025-01-24 - Consolidated Collection Traversal and ListView Testing
**Learning:** Consolidating multiple O(N) passes (filtering, counting, aggregation) into a single O(N) loop reduces complexity from O(K*N) to O(N) and minimizes heap allocations. Additionally, when verifying list-heavy screens in widget tests, the default test surface may prune off-screen items; increasing `tester.view.physicalSize` is necessary to find all items.
**Action:** Identify screens with multiple `.where()` or `.length` calls on the same collection and consolidate them. Use large virtual viewports in widget tests for full list verification.
