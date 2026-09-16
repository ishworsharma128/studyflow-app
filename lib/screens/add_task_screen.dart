import 'package:flutter/material.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  final Function(StudyTask) onAdd;

  const AddTaskScreen({super.key, required this.onAdd});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _subjectController = TextEditingController();
  DateTime? _dueDate;
  Priority _priority = Priority.medium;

  @override
  void dispose() {
    _titleController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 3)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _dueDate = picked);
    }
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_dueDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a due date')),
      );
      return;
    }

    final newTask = StudyTask(
      title: _titleController.text.trim(),
      subject: _subjectController.text.trim(),
      dueDate: _formatDate(_dueDate!),
      priority: _priority,
      progress: 0.0,
    );

    widget.onAdd(newTask);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F3FF),
        elevation: 0,
        title: const Text('Add Task',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text('Task Title',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _titleController,
                decoration: _inputDecoration('e.g. Essay Draft'),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'Title is required'
                    : null,
              ),
              const SizedBox(height: 18),
              const Text('Subject',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _subjectController,
                decoration: _inputDecoration('e.g. Academic Writing'),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'Subject is required'
                    : null,
              ),
              const SizedBox(height: 18),
              const Text('Due Date',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 6),
              InkWell(
                onTap: _pickDate,
                child: InputDecorator(
                  decoration: _inputDecoration('Select date'),
                  child: Text(
                    _dueDate == null ? 'Tap to select' : _formatDate(_dueDate!),
                    style: TextStyle(
                        color: _dueDate == null ? Colors.grey : Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text('Priority',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 6),
              Row(
                children: Priority.values.map((p) {
                  final selected = _priority == p;
                  final label = p == Priority.high
                      ? 'High'
                      : p == Priority.medium
                          ? 'Medium'
                          : 'Low';
                  final color = p == Priority.high
                      ? Colors.red
                      : p == Priority.medium
                          ? Colors.orange
                          : Colors.green;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(label),
                      selected: selected,
                      onSelected: (_) => setState(() => _priority = p),
                      selectedColor: color.withOpacity(0.85),
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Add Task',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
