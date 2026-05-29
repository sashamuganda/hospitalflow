# Palette's UX Journal

## 2025-05-23 - [Accessible Interactive Elements Pattern]
**Learning:** Consolidate interaction logic (HapticFeedback + the onTap callback) into a single VoidCallback? local variable (e.g., handleTap) within the build method. Apply this same callback to both the Semantics and GestureDetector layers. For custom interactive elements containing text, use `excludeSemantics: true` on the Semantics widget to prevent redundant announcements while ensuring accessibility.
**Action:** Apply this pattern to all custom buttons, chips, and cards to ensure consistent feedback and screen reader behavior.
