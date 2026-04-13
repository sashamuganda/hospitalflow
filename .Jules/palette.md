## 2025-05-15 - Enhancing Interactive Tactility and A11y
**Learning:** In a clinical/staff-facing app, tactile feedback (haptics) and clear accessibility labels (tooltips/semantics) are crucial for high-efficiency usage and reducing cognitive load during repetitive tasks like login and role selection.
**Action:** Always wrap custom interactive cards in `Semantics` and provide `Tooltip` for icon-only buttons. Use `HapticFeedback.lightImpact()` for primary actions and `selectionClick()` for toggle/selection states.
