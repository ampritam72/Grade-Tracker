import 'package:flutter/foundation.dart';
import '../models/subject.dart';

class GradeProvider with ChangeNotifier {
  final List<Subject> _subjects = [];
  bool _isDarkMode = false;
  int _currentNavigationIndex = 0;

  List<Subject> get subjects => List.unmodifiable(_subjects);
  bool get isDarkMode => _isDarkMode;
  int get currentNavigationIndex => _currentNavigationIndex;

  void setNavigationIndex(int index) {
    _currentNavigationIndex = index;
    notifyListeners();
  }

  void addSubject(Subject subject) {
    _subjects.add(subject);
    notifyListeners();
  }

  void removeSubject(int index) {
    _subjects.removeAt(index);
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  int get totalSubjects => _subjects.length;

  double get averageMark {
    if (_subjects.isEmpty) return 0.0;
    final total = _subjects.fold(0, (sum, item) => sum + item.mark);
    return total / _subjects.length;
  }

  String get overallGrade {
    final avg = averageMark;
    if (avg >= 80) return 'A';
    if (avg >= 65) return 'B';
    if (avg >= 50) return 'C';
    return 'F';
  }

  List<Subject> get passingSubjects {
    // Requirement: Use .map() or .where() at least once
    return _subjects.where((subject) => subject.grade != 'F').toList();
  }
}
