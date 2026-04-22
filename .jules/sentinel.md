## 2024-05-22 - Implementing Route Guards in Flutter with GoRouter
**Vulnerability:** Unauthenticated access to sensitive clinical routes.
**Learning:** In Flutter applications using `go_router`, navigation-based authorization (route guarding) should be implemented using the `redirect` callback. It's critical to ensure the `AppState` (or any authentication state provider) is available in the `BuildContext` when the `GoRouter` instance attempts to read it. If `GoRouter` is initialized outside the `Provider` scope, `context.read<AppState>()` will fail.
**Prevention:** Wrap the `MaterialApp.router` with the necessary `Provider` in the `main.dart` file to ensure the authentication state is accessible globally during navigation transitions.

## 2024-05-23 - DoS Mitigation via Input Length Constraints
**Vulnerability:** Resource exhaustion (DoS) through excessively large text inputs in clinical notes and registration forms.
**Learning:** Medical applications often have large text areas (like SOAP notes) that lack default constraints. While clinical precision requires space, unbounded inputs can lead to application crashes or database performance degradation. Using Flutter's `maxLength` provides a simple client-side guard, but `counterText: ''` is required to maintain the project's clean UI aesthetic.
**Prevention:** Always implement balanced `maxLength` constraints (e.g., 5000 for notes, 8 for numeric vitals) in `TextField` widgets for all user-facing forms.
