## 2024-05-22 - Implementing Route Guards in Flutter with GoRouter
**Vulnerability:** Unauthenticated access to sensitive clinical routes.
**Learning:** In Flutter applications using `go_router`, navigation-based authorization (route guarding) should be implemented using the `redirect` callback. It's critical to ensure the `AppState` (or any authentication state provider) is available in the `BuildContext` when the `GoRouter` instance attempts to read it. If `GoRouter` is initialized outside the `Provider` scope, `context.read<AppState>()` will fail.
**Prevention:** Wrap the `MaterialApp.router` with the necessary `Provider` in the `main.dart` file to ensure the authentication state is accessible globally during navigation transitions.

## 2024-05-23 - Clinical Input Hardening and DoS Mitigation
**Vulnerability:** Missing input length limits on clinical data entry forms (SOAP notes, Vitals, Prescriptions).
**Learning:** In medical applications, unconstrained text fields can lead to resource exhaustion (DoS) or UI crashes when handling excessively large clinical notes or malformed numeric inputs. Modern Flutter `TextField`s should explicitly define `maxLength` to bound data at the edge. Using `counterText: ''` allows enforcing these limits without cluttering the clinical interface with character counters.
**Prevention:** Implement a standard security hardening check for all `TextField` widgets in clinical modules, enforcing limits such as 5000 chars for SOAP notes and 8 chars for numeric vital signs.
