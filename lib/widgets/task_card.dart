import 'package:flutter/material.dart';
import '../models/task.dart';
import 'simple_date_picker.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final Function(Task) onStartTask;
  final Function(Task) onCompleteTask;
  final Function(Task, DateTime) onUpdateDueDate;
  final Function(Task, DateTime) onUpdateStartDate;

  const TaskCard({
    super.key,
    required this.task,
    required this.onStartTask,
    required this.onCompleteTask,
    required this.onUpdateDueDate,
    required this.onUpdateStartDate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left side - Task info
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Task identifier and menu
                  Row(
                    children: [
                      Text(
                        task.taskIdentifier,
                        style: TextStyle(
                          color: task.identifierColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.more_vert,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Task title
                  Text(
                    task.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  
                  // Assignee and priority
                  Row(
                    children: [
                      Text(
                        task.assignee,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      if (task.isHighPriority) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'High Priority',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            
            // Right side - Status and actions
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Status text
                  Text(
                    task.statusText,
                    style: TextStyle(
                      color: task.statusColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // Start date or due date with edit functionality
                                     if (task.startDateText != null)
                     Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         Text(
                           task.startDateText!,
                           style: const TextStyle(
                             fontSize: 12,
                             color: Colors.grey,
                           ),
                         ),
                         if (task.status == TaskStatus.notStarted) ...[
                           const SizedBox(width: 4),
                           GestureDetector(
                             onTap: () => _showDatePicker(context, isStartDate: true),
                             child: Container(
                               padding: const EdgeInsets.all(2),
                               decoration: BoxDecoration(
                                 color: Colors.blue.withOpacity(0.1),
                                 borderRadius: BorderRadius.circular(4),
                                 border: Border.all(color: Colors.blue.withOpacity(0.3)),
                               ),
                               child: const Icon(
                                 Icons.edit,
                                 size: 12,
                                 color: Colors.blue,
                               ),
                             ),
                           ),
                         ],
                       ],
                     )
                  else if (task.dueDateText != null)
                    GestureDetector(
                      onTap: () => _showDatePicker(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: (task.status == TaskStatus.notStarted || task.status == TaskStatus.started) 
                              ? Colors.blue.withOpacity(0.1) 
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                          border: (task.status == TaskStatus.notStarted || task.status == TaskStatus.started)
                              ? Border.all(color: Colors.blue.withOpacity(0.3))
                              : null,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              task.dueDateText!,
                              style: TextStyle(
                                fontSize: 12,
                                color: (task.status == TaskStatus.notStarted || task.status == TaskStatus.started)
                                    ? Colors.blue
                                    : Colors.grey,
                                fontWeight: (task.status == TaskStatus.notStarted || task.status == TaskStatus.started)
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                              ),
                            ),
                            if (task.status == TaskStatus.notStarted || task.status == TaskStatus.started) ...[
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.edit,
                                size: 12,
                                color: Colors.blue,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  
                  const SizedBox(height: 8),
                  
                  // Action button
                  if (task.status == TaskStatus.notStarted)
                    _buildStartButton()
                  else if (task.status == TaskStatus.started)
                    _buildCompleteButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStartButton() {
    return GestureDetector(
      onTap: () => onStartTask(task),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.circle,
              color: Colors.white,
              size: 12,
            ),
            SizedBox(width: 4),
            Text(
              'Start Task',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompleteButton() {
    return GestureDetector(
      onTap: () => onCompleteTask(task),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check,
              color: Colors.white,
              size: 12,
            ),
            SizedBox(width: 4),
            Text(
              'Mark as complete',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context, {bool isStartDate = false}) {
    final DateTime now = DateTime.now();
    final DateTime firstDate = DateTime(now.year, now.month, now.day);
    
    // Ensure initial date is not before first date
    DateTime initialDate = isStartDate 
        ? (task.startDate ?? now)
        : (task.dueDate ?? now);
    
    if (initialDate.isBefore(firstDate)) {
      initialDate = firstDate;
    }
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isStartDate ? 'Select Start Date' : 'Select Due Date'),
          content: SimpleDatePicker(
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: firstDate.add(const Duration(days: 365)),
            onDateSelected: (DateTime newDate) {
              if (isStartDate) {
                onUpdateStartDate(task, newDate);
              } else {
                onUpdateDueDate(task, newDate);
              }
            },
          ),
        );
      },
    );
  }
}
