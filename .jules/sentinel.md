## 2024-05-22 - Implementing Route Guards in Flutter with GoRouter
**Vulnerability:** Unauthenticated access to sensitive clinical routes.
**Learning:** In Flutter applications using `go_router`, navigation-based authorization (route guarding) should be implemented using the `redirect` callback. It's critical to ensure the `AppState` (or any authentication state provider) is available in the `BuildContext` when the `GoRouter` instance attempts to read it. If `GoRouter` is initialized outside the `Provider` scope, `context.read<AppState>()` will fail.
**Prevention:** Wrap the `MaterialApp.router` with the necessary `Provider` in the `main.dart` file to ensure the authentication state is accessible globally during navigation transitions.

## 2024-05-23 - Role-Based Access Control (RBAC) in GoRouter
**Vulnerability:** Authenticated users could bypass UI restrictions and access sensitive clinical or administrative routes via direct URL manipulation.
**Learning:** While basic authentication guards prevent external access, RBAC is necessary to enforce the principle of least privilege within the application. Using `GoRouter`'s `redirect` callback with `AppState.selectedRole` allows for centralized and declarative access control.
**Prevention:** Always implement path-based role checks in the router configuration for all sensitive route prefixes, redirecting unauthorized users to a safe default like `/home`.
