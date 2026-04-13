## 2026-04-13 - [Navigation Security Guards & Test Stabilization]
**Vulnerability:** Unprotected internal routes allowed direct access to clinical data via URL manipulation (e.g., manually typing /home).
**Learning:** Implementing GoRouter redirects for authentication requires the router to be a refreshListenable of the AppState. Additionally, the presence of long-running timers in the SplashScreen (used during the initial redirect flow) can cause pre-existing Flutter smoke tests to fail with "Timer is still pending" errors if they don't explicitly pumpAndSettle.
**Prevention:** Always use refreshListenable in the router config for reactive auth. Ensure widget smoke tests include pumpAndSettle or pump(duration) to clear animations and splash timers when testing the full app entry point.
