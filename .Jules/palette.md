## 2024-11-20 - Tactile Feedback and Accessibility Semantics in Flutter
**Learning:** In highly custom Flutter UI (e.g., glassmorphism, custom gradients), standard accessibility and tactile features are often omitted. Wrapping custom buttons in `Semantics` with appropriate labels and using `HapticFeedback` for selection/click actions significantly bridges the gap between a "prototype" feel and a "premium" product.
**Action:** Always inspect custom `GestureDetector` based buttons for missing `Semantics` and `HapticFeedback`. Add tooltips to any `IconButton` that lacks a label, especially in global navigation bars.

## 2024-11-21 - Semantic Summaries for List Items
**Learning:** For information-dense list items (like notification cards), wrapping the entire item in a `Semantics` widget with a summary `label` (e.g., "Unread notification: [Title]") provides a much better screen reader experience than forcing the user to navigate through multiple internal text widgets to infer the item's status.
**Action:** Use `Semantics` labels on complex cards to provide an "at-a-glance" summary for accessibility tools.

## 2026-07-05 - Enhancing Custom Cards with Material Ripples and Haptics
**Learning:** Custom cards built with  and  lack the standard Material feedback users expect. To provide a premium feel, these should be refactored to use  ->  (for decorations/gradients) ->  (for ripples). Combining this with  and  creates a fully accessible and tactilely satisfying interaction.
**Action:** When a custom card has an `onTap` handler, always prefer the `Material`/`Ink`/`InkWell` stack over `GestureDetector`/`Container`.

## 2026-07-05 - Enhancing Custom Cards with Material Ripples and Haptics
**Learning:** Custom cards built with `GestureDetector` and `Container` lack the standard Material feedback users expect. To provide a premium feel, these should be refactored to use `Material` -> `Ink` (for decorations/gradients) -> `InkWell` (for ripples). Combining this with `HapticFeedback.lightImpact()` and `Semantics(button: true)` creates a fully accessible and tactilely satisfying interaction.
**Action:** When a custom card has an `onTap` handler, always prefer the `Material`/`Ink`/`InkWell` stack over `GestureDetector`/`Container`.
