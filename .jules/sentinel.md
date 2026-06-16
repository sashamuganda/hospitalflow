## 2024-05-22 - Implementing Route Guards in Flutter with GoRouter
**Vulnerability:** Unauthenticated access to sensitive clinical routes.
**Learning:** In Flutter applications using `go_router`, navigation-based authorization (route guarding) should be implemented using the `redirect` callback. It's critical to ensure the `AppState` (or any authentication state provider) is available in the `BuildContext` when the `GoRouter` instance attempts to read it. If `GoRouter` is initialized outside the `Provider` scope, `context.read<AppState>()` will fail.
**Prevention:** Wrap the `MaterialApp.router` with the necessary `Provider` in the `main.dart` file to ensure the authentication state is accessible globally during navigation transitions.

## 2024-06-12 - Hardening Clinical Input Lengths to Prevent DoS
**Vulnerability:** Missing `maxLength` constraints on critical clinical input fields (SOAP notes, chief complaints, vitals).
**Learning:** In a clinical environment, excessively large inputs in text fields can lead to application instability, memory exhaustion, or database performance degradation (Denial of Service). This app frequently suppresses the visual character counter using `counterText: ''` for aesthetic reasons, which can obscure the absence of underlying security constraints.
**Prevention:** Explicitly define `maxLength` for all `TextField` widgets accepting clinical data and include a `// Security: Limit input length to prevent DoS` comment to ensure the requirement is visible to future maintainers.

## 2024-06-25 - Strengthening RBAC with Direct State Access in GoRouter
**Vulnerability:** Inconsistent authorization checks for administrative routes.
**Learning:** Relying on `context.read<AppState>()` inside the `GoRouter` redirect callback can be flaky if the context is not yet fully updated during high-frequency navigation. Passing the `AppState` directly into the `createRouter` factory and accessing it from the closure ensures that the redirect logic always operates on the most current, reliable state.
**Prevention:** Implement a standard RBAC guard in the central router that checks `appState.selectedRole` against a whitelist of allowed roles for sensitive routes like `/analytics` and `/staff`.
