## 2024-05-23 - Redundant List Filtering in Build Method
**Learning:** Accessing computed properties (getters) that perform list filtering multiple times within a `build` method, especially inside a `ListView.itemBuilder`, leads to $O(N \cdot M)$ complexity where $N$ is total items and $M$ is visible items. This causes unnecessary list allocations and iterations on every frame.
**Action:** Cache the result of filtering getters in a local variable at the beginning of the `build` method to ensure filtering logic runs only once per frame.

## 2026-06-23 - Consolidating Multiple O(N) Traversals
**Learning:** In the Medflow codebase, screens like `QueueHomeScreen` often perform multiple independent `where` or `length` calls on the same mock data list to calculate different metrics (e.g., waiting counts, triage counts, and filtering). This results in (K \cdot N)$ complexity where $ is the number of metrics.
**Action:** Consolidate these into a single `for` loop pass at the top of the `build` method to calculate all statistics and the filtered list in (N)$ time.
