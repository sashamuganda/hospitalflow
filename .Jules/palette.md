## 2024-11-20 - Tactile Feedback and Accessibility Semantics in Flutter
**Learning:** In highly custom Flutter UI (e.g., glassmorphism, custom gradients), standard accessibility and tactile features are often omitted. Wrapping custom buttons in `Semantics` with appropriate labels and using `HapticFeedback` for selection/click actions significantly bridges the gap between a "prototype" feel and a "premium" product.
**Action:** Always inspect custom `GestureDetector` based buttons for missing `Semantics` and `HapticFeedback`. Add tooltips to any `IconButton` that lacks a label, especially in global navigation bars.

## 2024-11-21 - Consolidating Semantics for Complex Interactive Cards
**Learning:** For interactive cards containing multiple text elements (like KPI or Metric cards), standard screen reader behavior often reads every child element individually, which can be noisy. Consolidating the information into a single `Semantics` label and using `excludeSemantics: true` on the parent provides a much cleaner experience. However, for generic containers like `GlassCard` that hold arbitrary content, `excludeSemantics` should be avoided to ensure all child content remains discoverable.
**Action:** Use summary labels + `excludeSemantics` for well-defined card components; use basic `Semantics` wrapping for generic layout containers.
