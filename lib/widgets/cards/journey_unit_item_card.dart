import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

enum JourneyItemStatus { completed, inProgress, locked }

class JourneyUnitItemCard extends StatelessWidget {
  final String stepNumber;
  final String title;
  final String description;
  final JourneyItemStatus status;
  final double progress; // 0.0 to 1.0
  final VoidCallback? onTap;

  const JourneyUnitItemCard({
    super.key,
    required this.stepNumber,
    required this.title,
    required this.description,
    this.status = JourneyItemStatus.completed,
    this.progress = 1.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = status == JourneyItemStatus.completed;
    final isInProgress = status == JourneyItemStatus.inProgress;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isInProgress
                ? const Color(0xFF1E3A8A)
                : AppColors.borderDark,
            width: 1.2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status Icon Box
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? const Color(0xFF064E3B)
                        : (isInProgress
                            ? const Color(0xFF1E3A8A)
                            : const Color(0xFF1E293B)),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      isCompleted
                          ? Icons.check_rounded
                          : (isInProgress
                              ? Icons.explore_outlined
                              : Icons.lock_outline_rounded),
                      size: 18,
                      color: isCompleted
                          ? const Color(0xFF10B981)
                          : (isInProgress
                              ? const Color(0xFF60A5FA)
                              : const Color(0xFF64748B)),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Step Number
                      Text(
                        stepNumber,
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: isCompleted
                              ? const Color(0xFF94A3B8)
                              : (isInProgress
                                  ? const Color(0xFF60A5FA)
                                  : const Color(0xFF64748B)),
                        ),
                      ),

                      const SizedBox(height: 2),

                      // Title
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: -0.2,
                        ),
                      ),

                      const SizedBox(height: 4),

                      // Description
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondaryDark,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),

                if (isInProgress)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Icon(
                      Icons.chevron_right_rounded,
                      size: 20,
                      color: Color(0xFF60A5FA),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 12),

            // Mini Progress Line Indicator
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 4,
                backgroundColor: const Color(0xFF1E293B),
                valueColor: AlwaysStoppedAnimation<Color>(
                  isCompleted
                      ? const Color(0xFF10B981)
                      : const Color(0xFF3B82F6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
