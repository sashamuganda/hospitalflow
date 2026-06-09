## 2024-05-23 - Redundant List Filtering in Build Method
**Learning:** Accessing computed properties (getters) that perform list filtering multiple times within a `build` method, especially inside a `ListView.itemBuilder`, leads to $O(N \cdot M)$ complexity where $N$ is total items and $M$ is visible items. This causes unnecessary list allocations and iterations on every frame.
**Action:** Cache the result of filtering getters in a local variable at the beginning of the `build` method to ensure filtering logic runs only once per frame.

## 2024-05-24 - Redundant String Transformations in Filter Closures
**Learning:** Performing string transformations like `toLowerCase()` on the filter query inside a `.where()` closure causes $O(N)$ redundant operations. For a list of 100 items, the query is transformed 100 times instead of once.
**Action:** Hoist query transformations outside of the filtering loop to maintain $O(N)$ efficiency and prevent unnecessary allocations.
