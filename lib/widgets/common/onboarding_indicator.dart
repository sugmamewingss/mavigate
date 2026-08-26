import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class OnboardingIndicator extends StatelessWidget {
  final int totalDots;
  final int activeIndex;
  final Color activeColor;
  final Color inactiveColor;

  const OnboardingIndicator({
    super.key,
    this.totalDots = 5,
    required this.activeIndex,
    this.activeColor = AppColors.electricBlueLight,
    this.inactiveColor = const Color(0xFF1E293B),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalDots,
        (index) {
          final isActive = index == activeIndex;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 6,
            width: isActive ? 16 : 6,
            decoration: BoxDecoration(
              color: isActive ? activeColor : inactiveColor,
              borderRadius: BorderRadius.circular(3),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: activeColor.withValues(alpha: 0.5),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
          );
        },
      ),
    );
  }
}
