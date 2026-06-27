import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/grade_provider.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GradeProvider>(context);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance Overview',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ).animate().fade().slideX(begin: -0.2, end: 0),
          const SizedBox(height: 24),
          
          // Average Score Circular Indicator
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primary.withOpacity(0.05),
                border: Border.all(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  width: 2,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 160,
                    height: 160,
                    child: CircularProgressIndicator(
                      value: provider.averageMark / 100,
                      strokeWidth: 12,
                      backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                      color: theme.colorScheme.primary,
                      strokeCap: StrokeCap.round,
                    ).animate(onPlay: (controller) => controller.forward(from: 0)).custom(
                      duration: 1500.ms,
                      curve: Curves.easeOutQuart,
                      builder: (context, value, child) => child,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        provider.averageMark.toStringAsFixed(1),
                        style: theme.textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Text(
                        'Avg. Mark',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ).animate().scale(duration: 800.ms, curve: Curves.easeOutBack),
          
          const SizedBox(height: 40),
          
          _buildAnimatedSummaryCard(
            context,
            'Total Subjects',
            provider.totalSubjects.toString(),
            Icons.book_rounded,
            const Color(0xFF6366F1),
            0,
          ),
          
          _buildAnimatedSummaryCard(
            context,
            'Overall Grade',
            provider.overallGrade,
            Icons.auto_awesome_rounded,
            _getGradeColor(provider.overallGrade),
            1,
          ),
          
          _buildAnimatedSummaryCard(
            context,
            'Status',
            provider.averageMark >= 50 ? 'PASSING' : 'FAILING',
            provider.averageMark >= 50 ? Icons.check_circle_rounded : Icons.warning_rounded,
            provider.averageMark >= 50 ? const Color(0xFF10B981) : const Color(0xFFEF4444),
            2,
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedSummaryCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
    int index,
  ) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  value,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (400 + (index * 150)).ms).slideY(begin: 0.2, end: 0);
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A': return const Color(0xFF10B981);
      case 'B': return const Color(0xFF3B82F6);
      case 'C': return const Color(0xFFF59E0B);
      case 'F': return const Color(0xFFEF4444);
      default: return Colors.grey;
    }
  }
}
