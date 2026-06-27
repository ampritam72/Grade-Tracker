import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 180,
                    height: 180,
                  ),
                )
                    .animate()
                    .scale(duration: 800.ms, curve: Curves.backOut)
                    .fadeIn(duration: 600.ms),
                const SizedBox(height: 24),
                Text(
                  'Grade Tracker',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF1E293B),
                        letterSpacing: 1.5,
                      ),
                )
                    .animate()
                    .fadeIn(delay: 400.ms)
                    .slideY(begin: 0.5, end: 0, duration: 600.ms),
                const SizedBox(height: 12),
                const SizedBox(
                  width: 40,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
                  ),
                ).animate().fadeIn(delay: 1000.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
