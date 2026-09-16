enum Priority { high, medium, low }

class StudyTask {
  final String title;
  final String subject;
  final String dueDate;
  final Priority priority;
  final double progress; // 0.0 to 1.0
  bool isDone;

  StudyTask({
    required this.title,
    required this.subject,
    required this.dueDate,
    required this.priority,
    required this.progress,
    this.isDone = false,
  });

  String get priorityLabel {
    switch (priority) {
      case Priority.high:
        return 'High';
      case Priority.medium:
        return 'Medium';
      case Priority.low:
        return 'Low';
    }
  }
}

class ClassSession {
  final String title;
  final String code;
  final String time;
  final String room;

  ClassSession({
    required this.title,
    required this.code,
    required this.time,
    required this.room,
  });
}
