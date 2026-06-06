## 2024-05-23 - Redundant List Filtering in Build Method
**Learning:** Accessing computed properties (getters) that perform list filtering multiple times within a `build` method, especially inside a `ListView.itemBuilder`, leads to $O(N \cdot M)$ complexity where $N$ is total items and $M$ is visible items. This causes unnecessary list allocations and iterations on every frame.
**Action:** Cache the result of filtering getters in a local variable at the beginning of the `build` method to ensure filtering logic runs only once per frame.

## 2024-05-24 - Expensive Sorting in Build Getters
**Learning:** Using a getter that performs an (N \log N)$ sort operation every time it's accessed, especially when used for both 'itemCount' and inside 'itemBuilder' of a ListView, creates (M \cdot N \log N)$ complexity (where $ is visible items). Repeatedly calling 'toLowerCase()' and performing string comparisons inside the sort comparator further increases overhead and allocations.
**Action:** Use 'initState' to sort static or initial data once into a 'late final' state variable. For sorting logic, use a 'static const' weight map to transform categories into integers, avoiding redundant string operations during comparison.
