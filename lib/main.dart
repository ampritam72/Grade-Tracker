import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animations/animations.dart';
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

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  final List<Widget> _screens = const [
    AddSubjectScreen(),
    SubjectListScreen(),
    SummaryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GradeProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // Global Gradient Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          // Subtle overlay for better readability in dark mode
          if (provider.isDarkMode)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          // Main Content
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                AppBar(
                  title: const Text('GradeMaster'),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                      ),
                      icon: Icon(
                        provider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                        color: theme.colorScheme.primary,
                      ),
                      onPressed: () => provider.toggleTheme(),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                Expanded(
                  child: PageTransitionSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
                      return FadeThroughTransition(
                        animation: primaryAnimation,
                        secondaryAnimation: secondaryAnimation,
                        child: child,
                      );
                    },
                    child: _screens[provider.currentNavigationIndex],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withOpacity(provider.isDarkMode ? 0.8 : 0.6),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: NavigationBar(
            selectedIndex: provider.currentNavigationIndex,
            onDestinationSelected: (index) {
              provider.setNavigationIndex(index);
            },
            backgroundColor: Colors.transparent,
            indicatorColor: theme.colorScheme.primary.withOpacity(0.2),
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.add_rounded, color: theme.colorScheme.primary),
                label: 'Add',
              ),
              NavigationDestination(
                icon: Icon(Icons.list_alt_rounded, color: theme.colorScheme.primary),
                label: 'Subjects',
              ),
              NavigationDestination(
                icon: Icon(Icons.analytics_rounded, color: theme.colorScheme.primary),
                label: 'Summary',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
