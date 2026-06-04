## 2024-05-22 - Implementing Route Guards in Flutter with GoRouter
**Vulnerability:** Unauthenticated access to sensitive clinical routes.
**Learning:** In Flutter applications using `go_router`, navigation-based authorization (route guarding) should be implemented using the `redirect` callback. It's critical to ensure the `AppState` (or any authentication state provider) is available in the `BuildContext` when the `GoRouter` instance attempts to read it. If `GoRouter` is initialized outside the `Provider` scope, `context.read<AppState>()` will fail.
**Prevention:** Wrap the `MaterialApp.router` with the necessary `Provider` in the `main.dart` file to ensure the authentication state is accessible globally during navigation transitions.

## 2024-06-12 - Hardening Clinical Input Lengths to Prevent DoS
**Vulnerability:** Missing `maxLength` constraints on critical clinical input fields (SOAP notes, chief complaints, vitals).
**Learning:** In a clinical environment, excessively large inputs in text fields can lead to application instability, memory exhaustion, or database performance degradation (Denial of Service). This app frequently suppresses the visual character counter using `counterText: ''` for aesthetic reasons, which can obscure the absence of underlying security constraints.
**Prevention:** Explicitly define `maxLength` for all `TextField` widgets accepting clinical data and include a `// Security: Limit input length to prevent DoS` comment to ensure the requirement is visible to future maintainers.

## 2024-06-25 - Enforcing Granular RBAC at the Router Level
**Vulnerability:** Authorized but non-privileged users accessing sensitive administrative routes (e.g., Analytics) via direct URL entry.
**Learning:** While basic authentication guards prevent external access, they don't inherently enforce Role-Based Access Control (RBAC). In `go_router`, the `redirect` callback should be used to inspect the current user's role from `AppState` and compare it against a map of restricted routes before allowing navigation.
**Prevention:** Maintain a centralized or clearly defined map of route-to-role requirements and enforce this in the router's global `redirect` logic to ensure "Least Privilege" access across the application.
