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
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 130),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Academic Summary',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: theme.colorScheme.onSurface,
            ),
          ).animate().fade().slideX(begin: -0.1, end: 0),
          const SizedBox(height: 32),
          
          Center(
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primary.withOpacity(0.05),
                border: Border.all(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: CircularProgressIndicator(
                      value: provider.averageMark / 100,
                      strokeWidth: 14,
                      backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                      color: theme.colorScheme.primary,
                      strokeCap: StrokeCap.round,
                    ).animate(onPlay: (c) => c.forward(from: 0)).custom(
                      duration: 2000.ms,
                      curve: Curves.easeOutExpo,
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
                          letterSpacing: -2,
                        ),
                      ),
                      Text(
                        'Global Average',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ).animate().scale(duration: 1000.ms, curve: Curves.backOut),
          
          const SizedBox(height: 48),
          
          _buildStatCard(
            context,
            'Total Modules',
            provider.totalSubjects.toString(),
            Icons.category_rounded,
            const Color(0xFF6366F1),
            0,
          ),
          
          _buildStatCard(
            context,
            'Final standing',
            provider.overallGrade,
            Icons.verified_rounded,
            _getGradeColor(provider.overallGrade),
            1,
          ),
          
          _buildStatCard(
            context,
            'Outcome',
            provider.averageMark >= 50 ? 'DISTINCTION' : 'UNDERPERFORMING',
            provider.averageMark >= 50 ? Icons.check_circle_rounded : Icons.info_rounded,
            provider.averageMark >= 50 ? const Color(0xFF10B981) : const Color(0xFFF43F5E),
            2,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
    int index,
  ) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.5),
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (500 + (index * 150)).ms).slideY(begin: 0.1, end: 0);
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
