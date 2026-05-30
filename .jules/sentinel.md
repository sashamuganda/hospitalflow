## 2024-05-22 - Implementing Route Guards in Flutter with GoRouter
**Vulnerability:** Unauthenticated access to sensitive clinical routes.
**Learning:** In Flutter applications using `go_router`, navigation-based authorization (route guarding) should be implemented using the `redirect` callback. It's critical to ensure the `AppState` (or any authentication state provider) is available in the `BuildContext` when the `GoRouter` instance attempts to read it. If `GoRouter` is initialized outside the `Provider` scope, `context.read<AppState>()` will fail.
**Prevention:** Wrap the `MaterialApp.router` with the necessary `Provider` in the `main.dart` file to ensure the authentication state is accessible globally during navigation transitions.

## 2024-05-24 - Role-Based Access Control (RBAC) Implementation
**Vulnerability:** Authenticated users could bypass UI restrictions and access routes belonging to other roles (e.g., Receptionists accessing EMR) via direct navigation.
**Learning:** Centralizing authorization logic in the `GoRouter` `redirect` callback ensures that all navigation attempts (including deep links) are validated against the user's current role from `AppState`. Prefix-based path matching (`path.startsWith('/emr')`) effectively secures entire feature modules.
**Prevention:** Maintain a clear mapping of feature routes to permitted roles in the central router configuration and implement a default redirection (e.g., to `/home`) for unauthorized access attempts.
