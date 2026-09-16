import 'package:flutter/material.dart';
import '../models/task.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  String filter = 'All';

  final List<StudyTask> tasks = [
    StudyTask(
      title: 'Algorithm Analysis Report',
      subject: 'CS Algorithms',
      dueDate: 'Nov 28, 2024',
      priority: Priority.high,
      progress: 0.65,
    ),
    StudyTask(
      title: 'Statistics Problem Set 5',
      subject: 'Statistical Methods',
      dueDate: 'Dec 1, 2024',
      priority: Priority.medium,
      progress: 0.30,
    ),
    StudyTask(
      title: 'Physics Lab Report',
      subject: 'Physics Fundamentals',
      dueDate: 'Nov 29, 2024',
      priority: Priority.high,
      progress: 0.0,
    ),
    StudyTask(
      title: 'Math Integration Exercises',
      subject: 'Advanced Mathematics',
      dueDate: 'Dec 5, 2024',
      priority: Priority.low,
      progress: 0.80,
    ),
    StudyTask(
      title: 'Research Essay Draft',
      subject: 'Academic Writing',
      dueDate: 'Dec 3, 2024',
      priority: Priority.medium,
      progress: 0.10,
    ),
  ];

  List<StudyTask> get filteredTasks {
    if (filter == 'Pending') return tasks.where((t) => !t.isDone).toList();
    if (filter == 'Completed') return tasks.where((t) => t.isDone).toList();
    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    final pendingCount = tasks.where((t) => !t.isDone).length;
    final doneCount = tasks.where((t) => t.isDone).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add Task form goes here')),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Tasks',
                  style:
                      TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('$pendingCount pending  ·  $doneCount done',
                  style: const TextStyle(color: Colors.grey, fontSize: 13)),
              const SizedBox(height: 16),
              _buildFilterChips(),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: filteredTasks.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final task = filteredTasks[index];
                    return _buildTaskCard(task);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final options = ['All', 'Pending', 'Completed'];
    return Row(
      children: options.map((option) {
        final selected = filter == option;
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ChoiceChip(
            label: Text(option),
            selected: selected,
            onSelected: (_) => setState(() => filter = option),
            selectedColor: Colors.deepPurple,
            backgroundColor: Colors.white,
            labelStyle: TextStyle(
              color: selected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide.none,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTaskCard(StudyTask task) {
    Color priorityColor = task.priority == Priority.high
        ? Colors.red
        : task.priority == Priority.medium
            ? Colors.orange
            : Colors.green;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 3))
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => setState(() => task.isDone = !task.isDone),
            child: Icon(
              task.isDone
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: task.isDone ? Colors.deepPurple : Colors.grey,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(task.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              decoration: task.isDone
                                  ? TextDecoration.lineThrough
                                  : null)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: priorityColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(task.priorityLabel,
                          style: TextStyle(
                              color: priorityColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(task.subject,
                        style: const TextStyle(
                            color: Colors.deepPurple, fontSize: 12)),
                    const SizedBox(width: 8),
                    const Icon(Icons.access_time,
                        size: 12, color: Colors.grey),
                    const SizedBox(width: 2),
                    Text(task.dueDate,
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: task.progress,
                          minHeight: 6,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: const AlwaysStoppedAnimation(
                              Colors.deepPurple),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text('${(task.progress * 100).round()}%',
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
