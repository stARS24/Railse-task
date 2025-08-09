# Task Manager UI - Flutter Assignment

A Flutter application that implements an interactive task list screen based on the provided UI design. This application demonstrates task management functionality with different task statuses and interactive features.

## Features

### Core Functionality
- **Task List Display**: Shows a list of tasks with different statuses (Not Started, Started, Completed)
- **Visual Status Indicators**: Each task card changes appearance based on its status
- **Interactive Buttons**: 
  - "Start Task" button for Not Started tasks
  - "Mark as Complete" button for Started tasks
- **Date Editing**: Edit deadline functionality with date picker for active tasks
- **Priority Indicators**: High priority tasks are clearly marked

### Task Types
- **Orders** (blue identifier)
- **Entities** (blue identifier) 
- **Enquiries** (purple identifier)

### Task Statuses
1. **Not Started**: Orange status text, "Start Task" button
2. **Started**: Red status text (with overdue calculation), "Mark as Complete" button
3. **Completed**: Green status text, no action button

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── task.dart            # Task model with status management
├── screens/
│   └── task_list_screen.dart # Main task list screen
└── widgets/
    └── task_card.dart       # Individual task card widget
```

## Getting Started

### Prerequisites
- Flutter SDK (version 3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extension

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd task_manager_ui
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:
```bash
flutter run
```

## Usage

### Task Interactions

1. **Start a Task**: 
   - Tap the "• Start Task" button on any Not Started task
   - The task status will change to "Started" and show the start date

2. **Complete a Task**:
   - Tap the "✓ Mark as complete" button on any Started task
   - The task status will change to "Completed"

3. **Edit Deadline**:
   - Tap the date text (highlighted in blue) on any active task (Not Started or Started)
   - A custom calendar dialog will open to select a new deadline
   - The task's due date will be updated and UI refreshes
4. **Edit Start Date**:
   - Tap the edit icon (highlighted in blue) next to the start date on Not Started tasks
   - A custom calendar dialog will open to select a new start date
   - The task's start date will be updated and UI refreshes

### Sample Data

The application comes with sample tasks that demonstrate all the different statuses and features:

- **Overdue/Started Tasks**: Order-1043, Entity-2559, Order-1020
- **Completed Tasks**: Order-194, Entity-2184, Entity-472  
- **Not Started Tasks**: Enquiry-3563, Order-176

## Technical Implementation

### Key Components

1. **Task Model** (`lib/models/task.dart`):
   - Manages task state and status transitions
   - Calculates overdue times and status text
   - Handles date formatting and color coding

2. **TaskListScreen** (`lib/screens/task_list_screen.dart`):
   - Main screen with sample data
   - Manages task state updates
   - Handles user interactions

3. **TaskCard Widget** (`lib/widgets/task_card.dart`):
   - Renders individual task cards
   - Implements interactive buttons
   - Shows status-specific UI elements

### State Management
- Uses Flutter's built-in `setState` for state management
- Task status changes trigger UI updates
- Date picker integration for deadline editing

## Dependencies

- `flutter`: Core Flutter framework
- `cupertino_icons`: iOS-style icons
- `intl`: Internationalization and date formatting

## Screenshots

The application implements the exact UI design from the assignment with:
- Task cards with left-side information (identifier, title, assignee, priority)
- Right-side status information with appropriate colors
- Interactive buttons that change based on task status
- Edit functionality for task deadlines

## Assignment Requirements Met

✅ **Build a screen that displays a list of tasks**  
✅ **Task card appearance changes based on status**  
✅ **Start Task button for Not Started tasks**  
✅ **Mark as Complete button for Started tasks**  
✅ **Edit Deadline functionality with date picker**  
✅ **Edit icon for start date on Not Started tasks**  
✅ **Tap date text to edit deadline for active tasks**  
✅ **Dart and Flutter implementation**

## License

This project is created for the Railse Flutter Developer Assignment.
