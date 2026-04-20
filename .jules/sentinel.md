## 2024-05-22 - Implementing Route Guards in Flutter with GoRouter
**Vulnerability:** Unauthenticated access to sensitive clinical routes.
**Learning:** In Flutter applications using `go_router`, navigation-based authorization (route guarding) should be implemented using the `redirect` callback. It's critical to ensure the `AppState` (or any authentication state provider) is available in the `BuildContext` when the `GoRouter` instance attempts to read it. If `GoRouter` is initialized outside the `Provider` scope, `context.read<AppState>()` will fail.
**Prevention:** Wrap the `MaterialApp.router` with the necessary `Provider` in the `main.dart` file to ensure the authentication state is accessible globally during navigation transitions.

## 2024-05-23 - Mitigation of DoS via Input Length Constraints in Medical Forms
**Vulnerability:** Missing `maxLength` constraints on clinical and administrative `TextField` widgets (SOAP notes, Vitals, Patient details).
**Learning:** In a clinical environment, large unsanitized inputs in high-traffic forms (like triage or EMR) can lead to resource exhaustion (DoS) or database performance degradation. While Flutter's `TextField` handles UI rendering, the lack of client-side constraints can lead to unexpected payloads being sent to the backend.
**Prevention:** Always implement `maxLength` on `TextField` widgets for data-heavy fields. In this project, use `counterText: ''` in `InputDecoration` to hide character counters while maintaining the hard limit for a cleaner medical UI.
