## 2024-05-22 - Implementing Route Guards in Flutter with GoRouter
**Vulnerability:** Unauthenticated access to sensitive clinical routes.
**Learning:** In Flutter applications using `go_router`, navigation-based authorization (route guarding) should be implemented using the `redirect` callback. It's critical to ensure the `AppState` (or any authentication state provider) is available in the `BuildContext` when the `GoRouter` instance attempts to read it. If `GoRouter` is initialized outside the `Provider` scope, `context.read<AppState>()` will fail.
**Prevention:** Wrap the `MaterialApp.router` with the necessary `Provider` in the `main.dart` file to ensure the authentication state is accessible globally during navigation transitions.

## 2024-06-12 - Hardening Clinical Input Lengths to Prevent DoS
**Vulnerability:** Missing `maxLength` constraints on critical clinical input fields (SOAP notes, chief complaints, vitals).
**Learning:** In a clinical environment, excessively large inputs in text fields can lead to application instability, memory exhaustion, or database performance degradation (Denial of Service). This app frequently suppresses the visual character counter using `counterText: ''` for aesthetic reasons, which can obscure the absence of underlying security constraints.
**Prevention:** Explicitly define `maxLength` for all `TextField` widgets accepting clinical data and include a `// Security: Limit input length to prevent DoS` comment to ensure the requirement is visible to future maintainers.

## 2024-10-24 - Strengthening RBAC and Router Robustness
**Vulnerability:** Authorized users (e.g., Doctors) could access administrative screens (Analytics, Staff Management) via direct URL manipulation because only authentication was checked, not specific roles.
**Learning:** Authentication is not Authorization. In GoRouter, the redirect callback is the correct place to enforce both. Using the appState instance passed to the factory function is more reliable than context.read<AppState>() because the router configuration might be initialized before the Provider is fully available in the widget tree, leading to ProviderNotFoundException during tests.
**Prevention:** Always check both isAuthenticated and userRole for restricted routes in the router's redirect logic. Prefer direct dependency injection of the state object into the router factory to ensure it's always accessible.
