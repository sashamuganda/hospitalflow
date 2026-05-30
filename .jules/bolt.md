## 2024-05-23 - Redundant List Filtering in Build Method
**Learning:** Accessing computed properties (getters) that perform list filtering multiple times within a `build` method, especially inside a `ListView.itemBuilder`, leads to $O(N \cdot M)$ complexity where $N$ is total items and $M$ is visible items. This causes unnecessary list allocations and iterations on every frame.
**Action:** Cache the result of filtering getters in a local variable at the beginning of the `build` method to ensure filtering logic runs only once per frame.

## 2024-05-24 - Redundant Sorting of Static Mock Data in Build
**Learning:** Performing O(N log N) sorting operations on static mock data within a build method (or via a getter called from build) causes unnecessary CPU load and allocations on every rebuild.
**Action:** For static or infrequently changing data in a StatefulWidget, perform sorting once in initState and store the result in a state variable (e.g., using late final).
