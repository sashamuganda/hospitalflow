## 2024-11-20 - Tactile Feedback and Accessibility Semantics in Flutter
**Learning:** In highly custom Flutter UI (e.g., glassmorphism, custom gradients), standard accessibility and tactile features are often omitted. Wrapping custom buttons in `Semantics` with appropriate labels and using `HapticFeedback` for selection/click actions significantly bridges the gap between a "prototype" feel and a "premium" product.
**Action:** Always inspect custom `GestureDetector` based buttons for missing `Semantics` and `HapticFeedback`. Add tooltips to any `IconButton` that lacks a label, especially in global navigation bars.

## 2024-11-21 - Consolidating Interaction Logic for Semantics
**Learning:** When adding `HapticFeedback` and `Semantics` to custom widgets, consolidating the logic into a local `handleTap` callback within the `build` method ensures that the exact same behavior is triggered whether the interaction comes from a physical tap (detected by `GestureDetector`) or an assistive technology action (detected by the `Semantics` layer). This prevents "out of sync" behavior and code duplication.
**Action:** Use a local `handleTap` function to wrap `HapticFeedback` and the original `onTap` callback, then pass this function to the `GestureDetector.onTap`.
