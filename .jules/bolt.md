## 2025-05-14 - List Referential Identity in State Management
**Learning:** Returning a new list instance from a getter in a `ChangeNotifier` (like `AppState.navItems`) every time it is accessed causes `context.select` to trigger rebuilds even if the content hasn't changed, because the referential identity of the list is different.
**Action:** Use `const` lists for static data or memoize dynamic lists in the state object to preserve referential identity.

## 2025-05-14 - Caching Computed Getters in Build Methods
**Learning:** Accessing computed getters that perform filtering or searching (O(N)) multiple times within a `build` method (e.g., once for `itemCount` and again for each `itemBuilder` call) leads to O(N * M) complexity, which can significantly degrade performance during animations or scrolling.
**Action:** Always cache the result of expensive computed getters in a local variable at the start of the `build` method.
