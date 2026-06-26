# Student Grade Tracker App

A modern Flutter application designed for students to track their academic performance across various subjects. Built with a focus on clean UI, smooth animations, and robust state management.

## Features

- **Add Subjects**: Intuitive form with validation for subject names and marks (0-100).
- **Subject List**: View all added subjects with their respective marks and calculated grades (A, B, C, F).
- **Live Summary**: Real-time updates for total subjects, average mark, and overall grade.
- **Swipe-to-Delete**: Easy removal of subjects using swipe gestures.
- **Theme Support**: Seamless switching between custom Light and Dark modes.
- **Grade Calculation**:
  - A: ≥ 80
  - B: ≥ 65
  - C: ≥ 50
  - F: < 50

## Technical Implementation

- **State Management**: Fully implemented using the `Provider` package. Zero `setState` calls for cross-screen state consistency.
- **Custom Themes**: Bespoke `ThemeData` for both light and dark modes, utilizing `GoogleFonts` (Poppins).
- **Requirement Compliance**: 
  - Uses `List<Subject>` with `.where()`/`.fold()` for data processing.
  - Private fields and getters in the model class.
  - Form validation for empty names and invalid marks.
  - `ListView.builder` for efficient list rendering.
  - All colors derived from `Theme.of(context)`.

## How to Run

1.  **Prerequisites**: Ensure you have Flutter installed and configured.
2.  **Clone the Repository**:
    ```bash
    git clone https://github.com/your-username/student-grade-tracker.git
    cd student-grade-tracker
    ```
3.  **Install Dependencies**:
    ```bash
    flutter pub get
    ```
4.  **Run the App**:
    ```bash
    flutter run
    ```

## Project Structure

```text
lib/
├── models/
│   └── subject.dart       # Subject model with grade logic
├── providers/
│   └── grade_provider.dart # State management using Provider
├── screens/
│   ├── add_subject_screen.dart
│   ├── subject_list_screen.dart
│   └── summary_screen.dart
├── theme/
│   └── app_theme.dart     # Light and Dark theme definitions
└── main.dart              # App entry point and navigation
```
