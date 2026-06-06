## 2024-11-20 - Tactile Feedback and Accessibility Semantics in Flutter
**Learning:** In highly custom Flutter UI (e.g., glassmorphism, custom gradients), standard accessibility and tactile features are often omitted. Wrapping custom buttons in `Semantics` with appropriate labels and using `HapticFeedback` for selection/click actions significantly bridges the gap between a "prototype" feel and a "premium" product.
**Action:** Always inspect custom `GestureDetector` based buttons for missing `Semantics` and `HapticFeedback`. Add tooltips to any `IconButton` that lacks a label, especially in global navigation bars.

## 2024-11-21 - Semantic Summaries for List Items
**Learning:** For information-dense list items (like notification cards), wrapping the entire item in a `Semantics` widget with a summary `label` (e.g., "Unread notification: [Title]") provides a much better screen reader experience than forcing the user to navigate through multiple internal text widgets to infer the item's status.
**Action:** Use `Semantics` labels on complex cards to provide an "at-a-glance" summary for accessibility tools.

## 2024-11-23 - Tactile and Semantic Feedback for Shared Cards
**Learning:** Shared card components (GlassCard, KpiCard, MetricCard) that serve as tap targets benefit immensely from 'Semantics' (button: true) and 'HapticFeedback'. For informational cards like KpiCard, a summary label in 'Semantics' ensures screen reader users get the full context (label, value, and trend) in a single announcement, while 'excludeSemantics: true' on children prevents redundant noise.
**Action:** Always wrap interactive custom cards in Semantics with descriptive labels and provide haptic feedback on tap to maintain a premium, accessible experience.
