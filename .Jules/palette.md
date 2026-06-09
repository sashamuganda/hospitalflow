## 2024-11-20 - Tactile Feedback and Accessibility Semantics in Flutter
**Learning:** In highly custom Flutter UI (e.g., glassmorphism, custom gradients), standard accessibility and tactile features are often omitted. Wrapping custom buttons in `Semantics` with appropriate labels and using `HapticFeedback` for selection/click actions significantly bridges the gap between a "prototype" feel and a "premium" product.
**Action:** Always inspect custom `GestureDetector` based buttons for missing `Semantics` and `HapticFeedback`. Add tooltips to any `IconButton` that lacks a label, especially in global navigation bars.

## 2024-11-21 - Semantic Summaries for List Items
**Learning:** For information-dense list items (like notification cards), wrapping the entire item in a `Semantics` widget with a summary `label` (e.g., "Unread notification: [Title]") provides a much better screen reader experience than forcing the user to navigate through multiple internal text widgets to infer the item's status.
**Action:** Use `Semantics` labels on complex cards to provide an "at-a-glance" summary for accessibility tools.

## 2024-11-22 - Semantic KPI Headers and Tooltips in Workflow Screens
**Learning:** In workflow-heavy screens (like Pharmacy or Lab), using `Semantics(header: true)` on screen titles and providing aggregated summary labels for KPI cards (e.g., "12 Pending prescriptions") creates a more navigable and efficient experience for screen reader users. Additionally, `Tooltip` widgets on primary action buttons in lists provide essential clarity on the intent of the action.
**Action:** Apply `Semantics(header: true)` to page titles and use `Tooltip` for contextual actions in list items to guide users.
