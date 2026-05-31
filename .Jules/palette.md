## 2024-11-20 - Tactile Feedback and Accessibility Semantics in Flutter
**Learning:** In highly custom Flutter UI (e.g., glassmorphism, custom gradients), standard accessibility and tactile features are often omitted. Wrapping custom buttons in `Semantics` with appropriate labels and using `HapticFeedback` for selection/click actions significantly bridges the gap between a "prototype" feel and a "premium" product.
**Action:** Always inspect custom `GestureDetector` based buttons for missing `Semantics` and `HapticFeedback`. Add tooltips to any `IconButton` that lacks a label, especially in global navigation bars.

## 2024-11-20 - Redundant Semantics in Custom Card Labels
**Learning:** When applying a descriptive `Semantics` label to a container (like a KPI card) that also contains child text widgets, screen readers will announce the custom label AND then traverse the children, leading to redundant information being read (e.g., "Patients: 120. 120. Patients.").
**Action:** Always set `excludeSemantics: true` on a `Semantics` widget when providing a comprehensive custom `label` that summarizes its contents to ensure a cleaner screen reader experience.
