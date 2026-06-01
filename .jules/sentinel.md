## 2024-05-22 - Implementing Route Guards in Flutter with GoRouter
**Vulnerability:** Unauthenticated access to sensitive clinical routes.
**Learning:** In Flutter applications using `go_router`, navigation-based authorization (route guarding) should be implemented using the `redirect` callback. It's critical to ensure the `AppState` (or any authentication state provider) is available in the `BuildContext` when the `GoRouter` instance attempts to read it. If `GoRouter` is initialized outside the `Provider` scope, `context.read<AppState>()` will fail.
**Prevention:** Wrap the `MaterialApp.router` with the necessary `Provider` in the `main.dart` file to ensure the authentication state is accessible globally during navigation transitions.

## 2024-06-12 - Hardening Clinical Inputs Against DoS
**Vulnerability:** Missing input length limits on clinical data entry fields.
**Learning:** Medical dashboards often have large text areas (SOAP notes, instructions) that, if left unrestricted, can be exploited to cause memory exhaustion or database bloat (DoS). Consistent use of 'maxLength' coupled with 'counterText: ""' ensures security without degrading the specialized UI.
**Prevention:** Always enforce 'maxLength' on all 'TextField' widgets, especially those handling free-form clinical data. Centralize verification in hardening tests to ensure limits are not regressed during UI refactors.
