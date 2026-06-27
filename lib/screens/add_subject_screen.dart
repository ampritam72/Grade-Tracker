import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/subject.dart';
import '../providers/grade_provider.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({super.key});

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _markController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _markController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final mark = int.parse(_markController.text);

      Provider.of<GradeProvider>(context, listen: false).addSubject(
        Subject(name: name, mark: mark),
      );

      _nameController.clear();
      _markController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$name added successfully!'),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Text(
              'Add New Subject',
              style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: theme.colorScheme.onSurface,
                  ),
              textAlign: TextAlign.center,
            ).animate().fade(duration: 400.ms).slideY(begin: 0.2, end: 0),
            const SizedBox(height: 8),
            Text(
              'Keep track of your academic progress',
              style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
              textAlign: TextAlign.center,
            ).animate().fade(delay: 200.ms).slideY(begin: 0.2, end: 0),
            const SizedBox(height: 40),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Subject Name',
                        prefixIcon: Icon(Icons.book_outlined),
                        hintText: 'e.g. Mathematics',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a subject name';
                        }
                        return null;
                      },
                    ).animate().fade(delay: 400.ms).slideX(begin: -0.1, end: 0),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _markController,
                      decoration: const InputDecoration(
                        labelText: 'Marks obtained',
                        prefixIcon: Icon(Icons.percent_rounded),
                        hintText: '0-100',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter marks';
                        }
                        final mark = int.tryParse(value);
                        if (mark == null || mark < 0 || mark > 100) {
                          return 'Enter a valid mark (0-100)';
                        }
                        return null;
                      },
                    ).animate().fade(delay: 600.ms).slideX(begin: -0.1, end: 0),
                  ],
                ),
              ),
            ).animate().scale(delay: 300.ms, curve: Curves.easeOutBack),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Add to Records'),
            ).animate().fade(delay: 800.ms).slideY(begin: 0.5, end: 0),
          ],
        ),
      ),
    );
  }
}
