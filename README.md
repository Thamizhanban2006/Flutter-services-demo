# Flutter Architecture & Dart Essentials

## 1. Stateless vs. StatefulWidget
* **StatelessWidget:** Immutable. The configuration is set once and never changes during its lifetime. Example: An Icon or a Text label.
* **StatefulWidget:** Mutable. It maintains a "State" object that can change over time. When `setState()` is called, the widget rebuilds to reflect the new data. Example: A Checkbox or a Counter.

## 2. The Widget Tree & Reactive UI
Flutter uses a tree of widgets to build the UI. When the state changes (e.g., a counter increments):
1.  We call `setState()`.
2.  Flutter marks the widget as "dirty."
3.  The `build()` method runs again.
4.  Flutter compares the new widget tree with the old one and strictly updates only the pixels that changed. This makes it incredibly fast.

## 3. Why Dart?
Dart is the secret weapon of Flutter because:
* **JIT (Just In Time) Compilation:** Allows for "Hot Reload" during development, letting us see changes in milliseconds.
* **AOT (Ahead Of Time) Compilation:** Compiles to native machine code for the final release, making the app run smoothly (60fps) on mobile devices.
