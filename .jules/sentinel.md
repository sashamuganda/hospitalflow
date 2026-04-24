## 2024-05-22 - Implementing Route Guards in Flutter with GoRouter
**Vulnerability:** Unauthenticated access to sensitive clinical routes.
**Learning:** In Flutter applications using `go_router`, navigation-based authorization (route guarding) should be implemented using the `redirect` callback. It's critical to ensure the `AppState` (or any authentication state provider) is available in the `BuildContext` when the `GoRouter` instance attempts to read it. If `GoRouter` is initialized outside the `Provider` scope, `context.read<AppState>()` will fail.
**Prevention:** Wrap the `MaterialApp.router` with the necessary `Provider` in the `main.dart` file to ensure the authentication state is accessible globally during navigation transitions.

## 2024-05-24 - Input Length Hardening for Clinical Forms
**Vulnerability:** Potential Denial of Service (DoS) via resource exhaustion in multi-line clinical text areas and vitals inputs.
**Learning:** Large text areas (like SOAP notes) and repeated numeric inputs (vitals) without length constraints can be exploited to crash the app or bloat backend storage. Standardizing on clinical-appropriate limits (5000 chars for notes, 8 for numeric vitals) balances utility with security.
**Prevention:** Always implement `maxLength` on `TextField` widgets. Use `counterText: ''` in `InputDecoration` to maintain UI cleanliness while enforcing limits. Verified through automated widget tests targeting the `maxLength` property.
