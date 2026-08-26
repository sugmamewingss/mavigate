import 'package:flutter/material.dart';
import '../../models/schedule_item.dart';
import 'build_schedule_screen.dart';
import 'onboarding_basics_screen.dart';
import 'onboarding_landing_screen.dart';
import 'onboarding_steps_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Onboarding state
  List<ScheduleItem> _userSchedule = [];
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
            _navigateToPage(3);
          },
        ),
      ),
    );

    if (result != null) {
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
      onPageChanged: (index) {
        setState(() => _currentPage = index);
      },
      children: [
        // Page 1: Landing Screen
        OnboardingLandingScreen(
          onNext: () => _navigateToPage(1),
          onSkip: _onSkip,
        ),

        // Page 2: Academic Basics Screen
        OnboardingBasicsScreen(
          onNext: () => _navigateToPage(2),
          onBack: () => _navigateToPage(0),
        ),

        // Page 3: 3-Step Campus Checklist Screen
        OnboardingStepsScreen(
          isScheduleCompleted: _isScheduleCompleted,
          onBack: () => _navigateToPage(1),
          onBuildSchedule: _openBuildSchedule,
          onNext: () {
            _navigateToPage(3);
          },
        ),

        // Placeholders for Page 4 & 5 (Ready for next Figma screenshots)
        ...List.generate(
          2,
          (index) => Scaffold(
            backgroundColor: const Color(0xFF0B1120),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Onboarding Halaman ${index + 4}',
                    style: const TextStyle(
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
                        onPressed: () => _navigateToPage(index + 2),
                        child: const Text('Kembali'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {
                          if (_currentPage < 4) {
                            _navigateToPage(_currentPage + 1);
                          } else {
                            _onSkip();
                          }
                        },
                        child: const Text('Lanjut'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
