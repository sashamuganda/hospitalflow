## 2024-05-22 - Implementing Route Guards in Flutter with GoRouter
**Vulnerability:** Unauthenticated access to sensitive clinical routes.
**Learning:** In Flutter applications using `go_router`, navigation-based authorization (route guarding) should be implemented using the `redirect` callback. It's critical to ensure the `AppState` (or any authentication state provider) is available in the `BuildContext` when the `GoRouter` instance attempts to read it. If `GoRouter` is initialized outside the `Provider` scope, `context.read<AppState>()` will fail.
**Prevention:** Wrap the `MaterialApp.router` with the necessary `Provider` in the `main.dart` file to ensure the authentication state is accessible globally during navigation transitions.

## 2026-05-29 - Robust Role-Based Access Control in Flutter
**Vulnerability:** Authenticated users accessing clinical or administrative routes restricted to other roles.
**Learning:** Route-based authorization should be centralized in the router's `redirect` logic. Relying on `context.read<AppState>()` within the `redirect` callback can lead to `ProviderNotFoundException` during certain navigation events or tests.
**Prevention:** Pass the `AppState` instance directly to the router creation function and use it within the `redirect` closure. Define a clear mapping of route prefixes to required roles and enforce this mapping globally.
