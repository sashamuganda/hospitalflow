## 2024-05-22 - Implementing Route Guards in Flutter with GoRouter
**Vulnerability:** Unauthenticated access to sensitive clinical routes.
**Learning:** In Flutter applications using `go_router`, navigation-based authorization (route guarding) should be implemented using the `redirect` callback. It's critical to ensure the `AppState` (or any authentication state provider) is available in the `BuildContext` when the `GoRouter` instance attempts to read it. If `GoRouter` is initialized outside the `Provider` scope, `context.read<AppState>()` will fail.
**Prevention:** Wrap the `MaterialApp.router` with the necessary `Provider` in the `main.dart` file to ensure the authentication state is accessible globally during navigation transitions.

## 2024-05-24 - Input Length Hardening for Clinical Data Entry
**Vulnerability:** Missing `maxLength` constraints on sensitive clinical input fields (SOAP notes, prescriptions, triage, patient registration).
**Learning:** In medical applications, unconstrained text inputs pose a Denial of Service (DoS) risk through data overflow and can lead to database performance issues or UI crashes. Even if backend validation exists, frontend enforcement provides immediate feedback and prevents malicious or accidental massive data payloads from being sent.
**Prevention:** Always implement `maxLength` on `TextField` widgets for clinical data. Use `counterText: ''` in `InputDecoration` to suppress the default character counter UI when it's not desirable for the design, while still maintaining the hard limit.
