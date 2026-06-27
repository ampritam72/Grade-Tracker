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
          content: Text('$name added to records'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Center(
              child: Hero(
                tag: 'app-logo',
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(0.2),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 110,
                      height: 110,
                    ),
                  ),
                ),
              ),
            ).animate().scale(duration: 800.ms, curve: Curves.elasticOut),
            const SizedBox(height: 32),
            Text(
              'Academic Intake',
              style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: theme.colorScheme.onSurface,
                  ),
            ).animate().fade(delay: 200.ms).slideY(begin: 0.2, end: 0),
            const SizedBox(height: 32),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      style: TextStyle(color: theme.colorScheme.onSurface),
                      decoration: const InputDecoration(
                        labelText: 'Subject Name',
                        prefixIcon: Icon(Icons.menu_book_rounded),
                        hintText: 'e.g. Computer Science',
                      ),
                      validator: (value) =>
                          (value == null || value.isEmpty) ? 'Enter subject name' : null,
                    ).animate().fade(delay: 400.ms).slideX(begin: -0.05, end: 0),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _markController,
                      style: TextStyle(color: theme.colorScheme.onSurface),
                      decoration: const InputDecoration(
                        labelText: 'Points Earned',
                        prefixIcon: Icon(Icons.stars_rounded),
                        hintText: 'Range 0-100',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Enter marks';
                        final m = int.tryParse(value);
                        return (m == null || m < 0 || m > 100) ? 'Range 0-100' : null;
                      },
                    ).animate().fade(delay: 600.ms).slideX(begin: -0.05, end: 0),
                  ],
                ),
              ),
            ).animate().scale(delay: 300.ms, curve: Curves.easeOutQuad),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('Add to Grade List'),
              ),
            ).animate().fade(delay: 800.ms).slideY(begin: 0.5, end: 0),
          ],
        ),
      ),
    );
  }
}
