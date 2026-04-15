## 2025-01-24 - Memoizing State Getters for context.select
**Learning:** In Flutter's `Provider` package, using `context.select<T, R>((state) => state.list)` will trigger a rebuild if `state.list` is a computed getter that returns a new list instance, even if the content hasn't changed. This is because `select` uses reference equality by default.
**Action:** Always memoize list-returning getters in the `ChangeNotifier` (e.g., in a private field updated only when necessary) to ensure referential identity and prevent redundant widget rebuilds.

## 2025-01-24 - Shell Layout Rebuild Optimization
**Learning:** Using `Consumer<AppState>` at the root of a `MainShell` causes the entire application structure (Sidebar, BottomNav, Page Content) to rebuild whenever *any* part of the global state changes.
**Action:** Remove broad `Consumer` widgets from shell layouts. Use `LayoutBuilder` for responsiveness and let individual sub-widgets (like `_Sidebar`) use targeted `context.select` to listen only to the specific properties they need.
