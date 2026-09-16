import 'package:flutter/material.dart';
import '../models/task.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final classes = [
      ClassSession(
        title: 'Advanced Mathematics',
        code: 'MATH301',
        time: '09:00',
        room: 'Room B204',
      ),
      ClassSession(
        title: 'Statistical Methods',
        code: 'STAT205',
        time: '14:00',
        room: 'Room C301',
      ),
    ];

    final priorityTask = StudyTask(
      title: 'Algorithm Analysis Report',
      subject: 'CS Algorithms',
      dueDate: 'Nov 28, 2024',
      priority: Priority.high,
      progress: 0.65,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildProgressCard(),
              const SizedBox(height: 24),
              _buildSectionHeader("Today's Classes", "See all"),
              const SizedBox(height: 12),
              _buildClassesRow(classes),
              const SizedBox(height: 24),
              _buildSectionHeader("Priority Task", "All tasks"),
              const SizedBox(height: 12),
              _buildPriorityTaskCard(priorityTask),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monday, Nov 27, 2024',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            SizedBox(height: 4),
            Text(
              'Good Morning, Alex! 👋',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Stack(
          children: [
            CircleAvatar(
              backgroundColor: Colors.deepPurple.shade50,
              radius: 22,
              child: const Icon(Icons.notifications_none, color: Colors.deepPurple),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple.shade400, Colors.deepPurple.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Semester Progress',
                      style: TextStyle(color: Colors.white70, fontSize: 13)),
                  SizedBox(height: 6),
                  Text('44%',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold)),
                  Text('0/5 tasks complete',
                      style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
              SizedBox(
                width: 56,
                height: 56,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: 0.44,
                      strokeWidth: 5,
                      backgroundColor: Colors.white24,
                      valueColor: const AlwaysStoppedAnimation(Colors.white),
                    ),
                    const Text('44%',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _statChip('2', 'Due Today'),
              const SizedBox(width: 10),
              _statChip('5', 'This Week'),
              const SizedBox(width: 10),
              _statChip('0', 'Completed'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statChip(String number, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(number,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(color: Colors.white70, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String actionLabel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text('$actionLabel >',
            style: const TextStyle(color: Colors.deepPurple, fontSize: 13)),
      ],
    );
  }

  Widget _buildClassesRow(List<ClassSession> classes) {
    return SizedBox(
      height: 130,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: classes.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final c = classes[index];
          return Container(
            width: 180,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 3))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.deepPurple.shade50,
                  radius: 16,
                  child: const Icon(Icons.menu_book,
                      color: Colors.deepPurple, size: 16),
                ),
                const SizedBox(height: 10),
                Text(c.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Text(c.code,
                    style: const TextStyle(
                        color: Colors.deepPurple, fontSize: 11)),
                const SizedBox(height: 6),
                Text('${c.time}  •  ${c.room}',
                    style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPriorityTaskCard(StudyTask task) {
    Color priorityColor = task.priority == Priority.high
        ? Colors.red
        : task.priority == Priority.medium
            ? Colors.orange
            : Colors.green;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(task.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15)),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: priorityColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                          color: priorityColor, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 5),
                    Text(task.priorityLabel,
                        style: TextStyle(
                            color: priorityColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(task.subject,
              style: const TextStyle(color: Colors.deepPurple, fontSize: 12)),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.access_time, size: 13, color: Colors.grey),
              const SizedBox(width: 4),
              Text('Due ${task.dueDate}',
                  style: const TextStyle(color: Colors.grey, fontSize: 12)),
              const Spacer(),
              Text('${(task.progress * 100).round()}%',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: task.progress,
              minHeight: 6,
              backgroundColor: Colors.grey.shade200,
              valueColor:
                  const AlwaysStoppedAnimation(Colors.deepPurple),
            ),
          ),
        ],
      ),
    );
  }
}
