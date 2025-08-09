import 'package:flutter/material.dart';

enum TaskStatus { notStarted, started, completed }

enum TaskType { order, entity, enquiry }

class Task {
  final String id;
  final String title;
  final String assignee;
  final bool isHighPriority;
  final TaskType type;
  TaskStatus status;
  DateTime? startDate;
  DateTime? dueDate;
  DateTime? completedDate;

  Task({
    required this.id,
    required this.title,
    required this.assignee,
    required this.type,
    this.isHighPriority = false,
    this.status = TaskStatus.notStarted,
    this.startDate,
    this.dueDate,
    this.completedDate,
  });

  String get taskIdentifier {
    switch (type) {
      case TaskType.order:
        return 'Order-$id';
      case TaskType.entity:
        return 'Entity-$id';
      case TaskType.enquiry:
        return 'Enquiry-$id';
    }
  }

  Color get identifierColor {
    switch (type) {
      case TaskType.order:
      case TaskType.entity:
        return Colors.blue;
      case TaskType.enquiry:
        return Colors.purple;
    }
  }

  String get statusText {
    switch (status) {
      case TaskStatus.notStarted:
        if (dueDate != null) {
          final now = DateTime.now();
          final difference = dueDate!.difference(now);
          if (difference.inDays == 0) {
            return 'Due Today';
          } else if (difference.inDays == 1) {
            return 'Due Tomorrow';
          } else if (difference.inDays > 1) {
            return 'Due in ${difference.inDays} days';
          } else {
            return 'Overdue';
          }
        }
        return 'Not Started';
      case TaskStatus.started:
        if (startDate != null) {
          final now = DateTime.now();
          if (dueDate != null && now.isAfter(dueDate!)) {
            final overdue = now.difference(dueDate!);
            return 'Overdue - ${overdue.inHours}h ${overdue.inMinutes % 60}m';
          }
        }
        return 'Started';
      case TaskStatus.completed:
        return 'Completed';
    }
  }

  Color get statusColor {
    switch (status) {
      case TaskStatus.notStarted:
        return Colors.orange;
      case TaskStatus.started:
        return Colors.red;
      case TaskStatus.completed:
        return Colors.green;
    }
  }

  String? get startDateText {
    if (startDate != null) {
      return 'Started: ${_formatDate(startDate!)}';
    }
    return null;
  }

  String? get dueDateText {
    if (dueDate != null) {
      return 'Start: ${_formatDate(dueDate!)}';
    }
    return null;
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}';
  }

  void startTask() {
    if (status == TaskStatus.notStarted) {
      status = TaskStatus.started;
      startDate = DateTime.now();
    }
  }

  void completeTask() {
    if (status == TaskStatus.started) {
      status = TaskStatus.completed;
      completedDate = DateTime.now();
    }
  }

  void updateDueDate(DateTime newDueDate) {
    dueDate = newDueDate;
  }

  void updateStartDate(DateTime newStartDate) {
    startDate = newStartDate;
  }
}
