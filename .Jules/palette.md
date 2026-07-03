## 2024-11-20 - Tactile Feedback and Accessibility Semantics in Flutter
**Learning:** In highly custom Flutter UI (e.g., glassmorphism, custom gradients), standard accessibility and tactile features are often omitted. Wrapping custom buttons in `Semantics` with appropriate labels and using `HapticFeedback` for selection/click actions significantly bridges the gap between a "prototype" feel and a "premium" product.
**Action:** Always inspect custom `GestureDetector` based buttons for missing `Semantics` and `HapticFeedback`. Add tooltips to any `IconButton` that lacks a label, especially in global navigation bars.

## 2024-11-21 - Semantic Summaries for List Items
**Learning:** For information-dense list items (like notification cards), wrapping the entire item in a `Semantics` widget with a summary `label` (e.g., "Unread notification: [Title]") provides a much better screen reader experience than forcing the user to navigate through multiple internal text widgets to infer the item's status.
**Action:** Use `Semantics` labels on complex cards to provide an "at-a-glance" summary for accessibility tools.

## 2024-11-23 - Balanced Semantic Summaries
**Learning:** While `ExcludeSemantics` is useful for reducing noise, it can inadvertently hide interactive elements (like buttons) from screen readers if applied too broadly. Using `Semantics(container: true, label: '...')` on a parent provides a clean summary while still allowing assistive technologies to reach and interact with children.
**Action:** Favor `Semantics(container: true)` for card summaries over `ExcludeSemantics` when the card contains actionable buttons or links.
