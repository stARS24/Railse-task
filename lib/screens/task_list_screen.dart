import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_card.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late List<Task> tasks;

  @override
  void initState() {
    super.initState();
    _initializeTasks();
  }

  void _initializeTasks() {
    tasks = [
      // Overdue/Started Tasks
      Task(
        id: '1043',
        title: 'Arrange Pickup',
        assignee: 'Sandhya',
        type: TaskType.order,
        isHighPriority: true,
        status: TaskStatus.started,
        startDate: DateTime(2024, 8, 10),
        dueDate: DateTime(2024, 8, 15),
      ),
      Task(
        id: '2559',
        title: 'Adhoc Task',
        assignee: 'Arman',
        type: TaskType.entity,
        status: TaskStatus.started,
        startDate: DateTime(2024, 8, 12),
        dueDate: DateTime(2024, 8, 14),
      ),
      Task(
        id: '1020',
        title: 'Collect Payment',
        assignee: 'Sandhya',
        type: TaskType.order,
        isHighPriority: true,
        status: TaskStatus.started,
        startDate: DateTime(2024, 8, 11),
        dueDate: DateTime(2024, 8, 13),
      ),
      
      // Completed Tasks
      Task(
        id: '194',
        title: 'Arrange Delivery',
        assignee: 'Prashant',
        type: TaskType.order,
        status: TaskStatus.completed,
        startDate: DateTime(2024, 8, 20),
        completedDate: DateTime(2024, 8, 21),
      ),
      Task(
        id: '2184',
        title: 'Share Company Profile',
        assignee: 'Asif Khan K',
        type: TaskType.entity,
        status: TaskStatus.completed,
        startDate: DateTime(2024, 8, 22),
        completedDate: DateTime(2024, 8, 23),
      ),
      Task(
        id: '472',
        title: 'Add Followup',
        assignee: 'Avik',
        type: TaskType.entity,
        status: TaskStatus.completed,
        startDate: DateTime(2024, 8, 25),
        completedDate: DateTime(2024, 8, 26),
      ),
      
      // Not Started Tasks
      Task(
        id: '3563',
        title: 'Convert Enquiry',
        assignee: 'Prashant',
        type: TaskType.enquiry,
        status: TaskStatus.notStarted,
        dueDate: DateTime(2024, 8, 30),
      ),
      Task(
        id: '176',
        title: 'Arrange Pickup',
        assignee: 'Prashant',
        type: TaskType.order,
        isHighPriority: true,
        status: TaskStatus.notStarted,
        dueDate: DateTime(2024, 8, 29),
      ),
    ];
  }

  void _startTask(Task task) {
    setState(() {
      task.startTask();
    });
  }

  void _completeTask(Task task) {
    setState(() {
      task.completeTask();
    });
  }

  void _updateDueDate(Task task, DateTime newDate) {
    setState(() {
      task.updateDueDate(newDate);
    });
  }

  void _updateStartDate(Task task, DateTime newDate) {
    setState(() {
      task.updateStartDate(newDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TaskCard(
              task: tasks[index],
              onStartTask: _startTask,
              onCompleteTask: _completeTask,
              onUpdateDueDate: _updateDueDate,
              onUpdateStartDate: _updateStartDate,
            ),
          );
        },
      ),
    );
  }
}
