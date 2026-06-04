## 2024-11-20 - Tactile Feedback and Accessibility Semantics in Flutter
**Learning:** In highly custom Flutter UI (e.g., glassmorphism, custom gradients), standard accessibility and tactile features are often omitted. Wrapping custom buttons in `Semantics` with appropriate labels and using `HapticFeedback` for selection/click actions significantly bridges the gap between a "prototype" feel and a "premium" product.
**Action:** Always inspect custom `GestureDetector` based buttons for missing `Semantics` and `HapticFeedback`. Add tooltips to any `IconButton` that lacks a label, especially in global navigation bars.

## 2024-11-21 - Semantic Summaries for List Items
**Learning:** For information-dense list items (like notification cards), wrapping the entire item in a `Semantics` widget with a summary `label` (e.g., "Unread notification: [Title]") provides a much better screen reader experience than forcing the user to navigate through multiple internal text widgets to infer the item's status.
**Action:** Use `Semantics` labels on complex cards to provide an "at-a-glance" summary for accessibility tools.

## 2024-11-22 - Preventing Redundant Semantics and preserving data in summarized cards
**Learning:** When using `Semantics` with a custom `label` on a widget that has `Text` children, setting `excludeSemantics: true` is vital to prevent screen readers from reading the same information twice (once for the summary label and once for the individual text widgets). However, when summarizing, ensure that all critical information (like trend data in a subtitle) is concatenated into the summary label, otherwise that data becomes invisible to screen reader users.
**Action:** Always use `excludeSemantics: true` when providing a summary label for a widget tree containing text, and ensure the label is comprehensive of all data points in that tree.
