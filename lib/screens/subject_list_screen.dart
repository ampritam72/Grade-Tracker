import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/grade_provider.dart';

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gradeProvider = Provider.of<GradeProvider>(context);
    final subjects = gradeProvider.subjects;

    if (subjects.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No subjects added yet!',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects[index];
        return Dismissible(
          key: Key('${subject.name}_$index'),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.redAccent,
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) {
            gradeProvider.removeSubject(index);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${subject.name} deleted')),
            );
          },
          child: Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: _getGradeColor(subject.grade),
                child: Text(
                  subject.grade,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                subject.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Marks: ${subject.mark}'),
              trailing: const Icon(Icons.swipe_left, size: 16, color: Colors.grey),
            ),
          ),
        );
      },
    );
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A':
        return Colors.green;
      case 'B':
        return Colors.blue;
      case 'C':
        return Colors.orange;
      case 'F':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
