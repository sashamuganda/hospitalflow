## 2024-05-23 - Redundant List Filtering in Build Method
**Learning:** Accessing computed properties (getters) that perform list filtering multiple times within a `build` method, especially inside a `ListView.itemBuilder`, leads to $O(N \cdot M)$ complexity where $N$ is total items and $M$ is visible items. This causes unnecessary list allocations and iterations on every frame.
**Action:** Cache the result of filtering getters in a local variable at the beginning of the `build` method to ensure filtering logic runs only once per frame.
## 2026-07-03 - Redundant Sorting in Build Method
**Learning:** Calling a getter that performs list sorting (O(N log N)) multiple times within a build method, specifically in a ListView.itemBuilder, escalates complexity to O(M * N log N) where M is the number of rendered items.
**Action:** Cache the result of the sorting getter in a local variable at the start of the build method to ensure the operation runs only once per frame.
