## 2024-04-14 - Unauthorized Navigation Access (Auth Bypass)
**Vulnerability:** Clinical and internal routes were accessible via direct URL navigation without authentication.
**Learning:** `GoRouter` in a web environment allows users to bypass intended UI flows by manually entering paths if a `redirect` guard is not explicitly configured.
**Prevention:** Implement a centralized `redirect` callback in the `GoRouter` configuration that checks the global `AppState` and use `refreshListenable` to ensure the guard re-evaluates on state changes.

## 2024-04-14 - Sensitive Data Leakage in Input Fields
**Vulnerability:** Login fields lacked length limits and sensitive fields (password) could have their values cached by mobile keyboards.
**Learning:** Default `TextField` behavior on mobile/web may include autocorrect and suggestions, which can leak sensitive data to the system's keyboard cache.
**Prevention:** Always set `autocorrect: false` and `enableSuggestions: false` for password fields, and enforce `maxLength` on all authentication-related inputs.
