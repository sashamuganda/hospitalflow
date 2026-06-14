## 2024-05-22 - Implementing Route Guards in Flutter with GoRouter
**Vulnerability:** Unauthenticated access to sensitive clinical routes.
**Learning:** In Flutter applications using `go_router`, navigation-based authorization (route guarding) should be implemented using the `redirect` callback. It's critical to ensure the `AppState` (or any authentication state provider) is available in the `BuildContext` when the `GoRouter` instance attempts to read it. If `GoRouter` is initialized outside the `Provider` scope, `context.read<AppState>()` will fail.
**Prevention:** Wrap the `MaterialApp.router` with the necessary `Provider` in the `main.dart` file to ensure the authentication state is accessible globally during navigation transitions.

## 2024-06-12 - Hardening Clinical Input Lengths to Prevent DoS
**Vulnerability:** Missing `maxLength` constraints on critical clinical input fields (SOAP notes, chief complaints, vitals).
**Learning:** In a clinical environment, excessively large inputs in text fields can lead to application instability, memory exhaustion, or database performance degradation (Denial of Service). This app frequently suppresses the visual character counter using `counterText: ''` for aesthetic reasons, which can obscure the absence of underlying security constraints.
**Prevention:** Explicitly define `maxLength` for all `TextField` widgets accepting clinical data and include a `// Security: Limit input length to prevent DoS` comment to ensure the requirement is visible to future maintainers.

## 2024-06-25 - Securing Sensitive Routes with Role-Based Access Control
**Vulnerability:** Broken Access Control allowing non-admin staff to access hospital analytics and staff directories.
**Learning:** Authentication is not authorization. While the app had a `redirect` to ensure users were logged in, it lacked checks for specific roles. In `go_router`, the `redirect` callback is the correct place for these checks. Using the closure-captured `appState` instead of `context.read<AppState>()` within the `redirect` function is more reliable and consistent with existing patterns.
**Prevention:** Always implement a secondary authorization layer in the router for any route containing sensitive organizational or PII data. Map routes to required roles and verify against `appState.selectedRole`.
