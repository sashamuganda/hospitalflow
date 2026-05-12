## 2024-05-23 - Redundant List Filtering in Build Method
**Learning:** Accessing computed properties (getters) that perform list filtering multiple times within a `build` method, especially inside a `ListView.itemBuilder`, leads to $O(N \cdot M)$ complexity where $N$ is total items and $M$ is visible items. This causes unnecessary list allocations and iterations on every frame.
**Action:** Cache the result of filtering getters in a local variable at the beginning of the `build` method to ensure filtering logic runs only once per frame.

## 2024-05-24 - Unintended Dependency Regressions in pubspec.lock
**Learning:** Running `flutter test` or `flutter analyze` in a sandbox environment with a different Dart/Flutter SDK version than the one used to generate the lockfile can lead to unintended dependency downgrades in `pubspec.lock`. These regressions are often blocking in review.
**Action:** Always check `git status` for modified lockfiles before submitting. If `pubspec.lock` was modified without intent, use `git restore --staged pubspec.lock && git restore pubspec.lock` to revert environmental regressions while keeping intended code changes.
