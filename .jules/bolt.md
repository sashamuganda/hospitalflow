## 2026-04-13 - [O(N^2) Build Pattern in Flutter Builders]
**Learning:** Using computed getters that perform O(N) filtering inside Flutter build methods leads to O(N^2) complexity when those getters are accessed multiple times (e.g., once for itemCount and once for every itemBuilder call).
**Action:** Always cache filtered or sorted lists in local variables at the start of the build method to ensure O(N) complexity during the build cycle.

## 2026-04-13 - [Redundant Rebuilds with Provider]
**Learning:** Using context.watch<AppState>() in high-level widgets (like HomeScreen) causes the entire widget tree to rebuild on any state change, even if the change is irrelevant to that specific screen.
**Action:** Use context.select<AppState, T>() to target only the specific properties required by the widget, minimizing unnecessary rebuilds.
