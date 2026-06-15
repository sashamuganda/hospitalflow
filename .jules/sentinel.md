## 2024-05-22 - Implementing Route Guards in Flutter with GoRouter
**Vulnerability:** Unauthenticated access to sensitive clinical routes.
**Learning:** In Flutter applications using `go_router`, navigation-based authorization (route guarding) should be implemented using the `redirect` callback. It's critical to ensure the `AppState` (or any authentication state provider) is available in the `BuildContext` when the `GoRouter` instance attempts to read it. If `GoRouter` is initialized outside the `Provider` scope, `context.read<AppState>()` will fail.
**Prevention:** Wrap the `MaterialApp.router` with the necessary `Provider` in the `main.dart` file to ensure the authentication state is accessible globally during navigation transitions.

## 2024-06-12 - Hardening Clinical Input Lengths to Prevent DoS
**Vulnerability:** Missing `maxLength` constraints on critical clinical input fields (SOAP notes, chief complaints, vitals).
**Learning:** In a clinical environment, excessively large inputs in text fields can lead to application instability, memory exhaustion, or database performance degradation (Denial of Service). This app frequently suppresses the visual character counter using `counterText: ''` for aesthetic reasons, which can obscure the absence of underlying security constraints.
**Prevention:** Explicitly define `maxLength` for all `TextField` widgets accepting clinical data and include a `// Security: Limit input length to prevent DoS` comment to ensure the requirement is visible to future maintainers.

## 2024-06-15 - Enforcing RBAC for Sensitive Admin Routes in GoRouter
**Vulnerability:** Authorization bypass via direct URL navigation to hidden admin routes (`/analytics`, `/staff`).
**Learning:** Hiding navigation items in the UI for specific roles is insufficient for security; route-level guards must be enforced in the `GoRouter.redirect` callback. When implementing these guards, it is safer to pass the `AppState` directly to `createRouter` and use it within the closure rather than relying on `context.read<AppState>()`, which may be unavailable during early navigation phases or within certain test environments.
**Prevention:** Always verify that restricted routes have explicit role checks in the central router configuration and implement integration tests that specifically attempt unauthorized navigation to these routes.
