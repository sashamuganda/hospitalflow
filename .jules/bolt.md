## 2024-05-23 - Redundant List Filtering in Build Method
**Learning:** Accessing computed properties (getters) that perform list filtering multiple times within a `build` method, especially inside a `ListView.itemBuilder`, leads to $O(N \cdot M)$ complexity where $N$ is total items and $M$ is visible items. This causes unnecessary list allocations and iterations on every frame.
**Action:** Cache the result of filtering getters in a local variable at the beginning of the `build` method to ensure filtering logic runs only once per frame.

## 2024-05-24 - Expensive Sorting in Build Method
**Learning:** Performing O(N log N) sorting operations within a build method or a getter accessed by ListView.itemBuilder leads to redundant computations on every rebuild. For static or mock data, this is entirely avoidable.
**Action:** Move sorting or heavy transformations of static data to initState and store the result in a late variable. Use a static const weight map for categorical sorting to avoid repeated allocations and logic branches.
