## 2024-11-20 - Tactile Feedback and Accessibility Semantics in Flutter
**Learning:** In highly custom Flutter UI (e.g., glassmorphism, custom gradients), standard accessibility and tactile features are often omitted. Wrapping custom buttons in `Semantics` with appropriate labels and using `HapticFeedback` for selection/click actions significantly bridges the gap between a "prototype" feel and a "premium" product.
**Action:** Always inspect custom `GestureDetector` based buttons for missing `Semantics` and `HapticFeedback`. Add tooltips to any `IconButton` that lacks a label, especially in global navigation bars.

## 2024-11-21 - Semantic Summaries for List Items
**Learning:** For information-dense list items (like notification cards), wrapping the entire item in a `Semantics` widget with a summary `label` (e.g., "Unread notification: [Title]") provides a much better screen reader experience than forcing the user to navigate through multiple internal text widgets to infer the item's status.
**Action:** Use `Semantics` labels on complex cards to provide an "at-a-glance" summary for accessibility tools.

## 2026-07-07 - Preserving Card Animations with Material Feedback
**Learning:** When adding Material ripple feedback (`InkWell`) to custom `AnimatedContainer` cards, keep the `AnimatedContainer` as the parent for decorations. Wrapping the `AnimatedContainer` content in `Material(color: Colors.transparent, clipBehavior: Clip.antiAlias)` and then an `InkWell` ensures ripples are correctly clipped to the card's shape while preserving smooth background/border animations.
**Action:** Use the pattern `Semantics` -> `AnimatedContainer` -> `Material` -> `InkWell` for accessible, interactive cards with background animations.
