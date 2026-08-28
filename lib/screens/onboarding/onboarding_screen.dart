import 'package:flutter/material.dart';
import '../../models/schedule_item.dart';
import 'build_schedule_screen.dart';
import 'onboarding_basics_screen.dart';
import 'onboarding_completion_screen.dart';
import 'onboarding_landing_screen.dart';
import 'onboarding_steps_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  // Onboarding state
  List<ScheduleItem> _userSchedule = [];
  bool _isPriorityCompleted = false;
  bool _isScheduleCompleted = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _onSkip() {
    // Navigate directly to Auth Page (Register/Login)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Menuju Halaman Auth (Login / Register)...'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _openBuildSchedule() async {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    final result = await Navigator.of(context).push<List<ScheduleItem>>(
      MaterialPageRoute(
        builder: (context) => BuildScheduleScreen(
          initialSchedule: _userSchedule,
          onScheduleUpdated: (updatedList) {
            setState(() {
              _userSchedule = updatedList;
              _isScheduleCompleted = updatedList.isNotEmpty;
            });
          },
          onNext: () {
            setState(() {
              _isScheduleCompleted = true;
            });
            _navigateToPage(3); // Navigate to completion screen ("🎉 Selamat, tahap MABA selesai!!!")
          },
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _userSchedule = result;
        _isScheduleCompleted = result.isNotEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(), // Keep controlled via buttons
      children: [
        // Page 1 (Index 0): Landing Screen with Mascot
        OnboardingLandingScreen(
          onNext: () => _navigateToPage(1),
          onSkip: _onSkip,
        ),

        // Page 2 (Index 1): Academic Basics Screen
        OnboardingBasicsScreen(
          onNext: () => _navigateToPage(2),
          onBack: () => _navigateToPage(0),
        ),

        // Page 3 (Index 2): 3-Step Campus Checklist Screen ("Ayo siapkan kamu kuliah!")
        OnboardingStepsScreen(
          isPriorityCompleted: _isPriorityCompleted,
          isScheduleCompleted: _isScheduleCompleted,
          onBack: () => _navigateToPage(1),
          onAturPrioritas: () {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            setState(() {
              _isPriorityCompleted = true;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('✓ Rencana prioritas berhasil disimpan!'),
                backgroundColor: Color(0xFF10B981),
                duration: Duration(milliseconds: 1200),
              ),
            );
          },
          onBuildSchedule: _openBuildSchedule,
          onNext: () {
            _navigateToPage(3);
          },
        ),

        // Page 4 (Index 3): Completion Milestone Screen ("🎉 Selamat, tahap MABA selesai!!!")
        OnboardingCompletionScreen(
          onBack: () => _navigateToPage(2),
          onNext: () {
            _navigateToPage(4);
          },
        ),

        // Page 5 (Index 4): Placeholder for Next Screen (Target Goals / Auth)
        Scaffold(
          backgroundColor: const Color(0xFF0B1120),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Onboarding Halaman 5 (Target Goals)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Siap menerima screenshot Figma berikutnya! 🚀',
                  style: TextStyle(color: Color(0xFF94A3B8)),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () => _navigateToPage(3),
                      child: const Text('Kembali'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _onSkip,
                      child: const Text('Ke Auth (Login/Register)'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
