## 2024-11-20 - Tactile Feedback and Accessibility Semantics in Flutter
**Learning:** In highly custom Flutter UI (e.g., glassmorphism, custom gradients), standard accessibility and tactile features are often omitted. Wrapping custom buttons in `Semantics` with appropriate labels and using `HapticFeedback` for selection/click actions significantly bridges the gap between a "prototype" feel and a "premium" product.
**Action:** Always inspect custom `GestureDetector` based buttons for missing `Semantics` and `HapticFeedback`. Add tooltips to any `IconButton` that lacks a label, especially in global navigation bars.

## 2024-11-21 - Semantic Summaries for List Items
**Learning:** For information-dense list items (like notification cards), wrapping the entire item in a `Semantics` widget with a summary `label` (e.g., "Unread notification: [Title]") provides a much better screen reader experience than forcing the user to navigate through multiple internal text widgets to infer the item's status.
**Action:** Use `Semantics` labels on complex cards to provide an "at-a-glance" summary for accessibility tools.

## 2024-11-22 - Avoiding Semantic Redundancy
**Learning:** When wrapping a widget that already contains visible text (like a chip or a button) in a `Semantics` widget with a custom `label`, setting `excludeSemantics: true` is crucial. Without it, screen readers may read the content twice—once for the `Semantics` label and once for the child `Text` widget—creating a noisy and confusing experience for users.
**Action:** Always use `excludeSemantics: true` when providing a high-level summary `label` for widgets that contain child text elements that should not be read independently.
