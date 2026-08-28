import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

enum StepStatus { completed, active, locked }

class OnboardingStepCard extends StatelessWidget {
  final String stepNumber;
  final IconData icon;
  final StepStatus status;
  final String title;
  final String highlightText;
  final String description;
  final String? actionButtonText;
  final VoidCallback? onActionButtonPressed;
  final bool isLast;

  const OnboardingStepCard({
    super.key,
    required this.stepNumber,
    required this.icon,
    required this.status,
    required this.title,
    required this.highlightText,
    required this.description,
    this.actionButtonText,
    this.onActionButtonPressed,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    Color getAccentColor() {
      switch (status) {
        case StepStatus.completed:
          return const Color(0xFF10B981); // Emerald Green
        case StepStatus.active:
          return const Color(0xFF60A5FA); // Bright Blue
        case StepStatus.locked:
          return const Color(0xFF475569); // Slate Muted
      }
    }

    Color getNodeBorderColor() {
      switch (status) {
        case StepStatus.completed:
          return const Color(0xFF10B981);
        case StepStatus.active:
          return AppColors.electricBlue;
        case StepStatus.locked:
          return const Color(0xFF334155);
      }
    }

    final accentColor = getAccentColor();
    final nodeBorderColor = getNodeBorderColor();

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Stepper Timeline Column
          SizedBox(
            width: 58,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      stepNumber,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: status == StepStatus.locked
                            ? const Color(0xFF475569)
                            : accentColor,
                      ),
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.surfaceDark,
                        border: Border.all(color: nodeBorderColor, width: 2),
                        boxShadow: status == StepStatus.active
                            ? [
                                BoxShadow(
                                  color: AppColors.electricBlue.withValues(alpha: 0.4),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                              ]
                            : null,
                      ),
                      child: Center(
                        child: Icon(
                          icon,
                          size: 16,
                          color: status == StepStatus.locked
                              ? const Color(0xFF475569)
                              : accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.only(left: 36),
                      decoration: BoxDecoration(
                        color: status == StepStatus.completed
                            ? const Color(0xFF10B981)
                            : const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Right Content Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: status == StepStatus.completed
                        ? const Color(0xFF065F46).withValues(alpha: 0.5)
                        : (status == StepStatus.active
                            ? AppColors.electricBlue.withValues(alpha: 0.5)
                            : AppColors.borderDark),
                    width: 1.2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: status == StepStatus.locked
                            ? const Color(0xFF94A3B8)
                            : Colors.white,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Highlight Subtitle
                    Text(
                      highlightText,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: accentColor,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // Description
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: status == StepStatus.locked
                            ? const Color(0xFF475569)
                            : AppColors.textSecondaryDark,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Footer Action / Badge
                    if (status == StepStatus.completed)
                      const Row(
                        children: [
                          Text(
                            'Selesai',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF10B981),
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.check_rounded, color: Color(0xFF10B981), size: 16),
                        ],
                      )
                    else if (status == StepStatus.active && actionButtonText != null)
                      SizedBox(
                        height: 38,
                        child: ElevatedButton(
                          onPressed: onActionButtonPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.electricBlue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                actionButtonText!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.chevron_right_rounded, size: 18),
                            ],
                          ),
                        ),
                      )
                    else if (status == StepStatus.locked)
                      const Row(
                        children: [
                          Text(
                            'Terkunci',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF64748B),
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.lock_outline_rounded,
                              color: Color(0xFF64748B), size: 14),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
