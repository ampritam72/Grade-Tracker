import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/grade_provider.dart';
import 'theme/app_theme.dart';
import 'screens/add_subject_screen.dart';
import 'screens/subject_list_screen.dart';
import 'screens/summary_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GradeProvider(),
      child: const StudentGradeApp(),
    ),
  );
}

class StudentGradeApp extends StatelessWidget {
  const StudentGradeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final gradeProvider = Provider.of<GradeProvider>(context);

    return MaterialApp(
      title: 'Student Grade Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: gradeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const AddSubjectScreen(),
    const SubjectListScreen(),
    const SummaryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GradeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grade Tracker'),
        actions: [
          IconButton(
            icon: Icon(provider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => provider.toggleTheme(),
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Subjects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            label: 'Summary',
          ),
        ],
      ),
    );
  }
}
