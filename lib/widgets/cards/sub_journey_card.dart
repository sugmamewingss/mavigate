import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/journey_model.dart';

class SubJourneyCard extends StatelessWidget {
  final SubJourneyItem item;
  final VoidCallback? onContinue;

  const SubJourneyCard({
    super.key,
    required this.item,
    this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = item.status == SubJourneyStatus.completed;
    final isActive = item.status == SubJourneyStatus.active;
    final isLocked = item.status == SubJourneyStatus.locked;

    Color iconCircleBg;
    Color iconColor;
    IconData statusIcon;
    String statusBadgeText;
    Color statusBadgeColor;

    if (isCompleted) {
      iconCircleBg = const Color(0xFF064E3B);
      iconColor = const Color(0xFF10B981);
      statusIcon = Icons.check_rounded;
      statusBadgeText = 'SELESAI';
      statusBadgeColor = const Color(0xFF10B981);
    } else if (isActive) {
      iconCircleBg = const Color(0xFF1E2A44);
      iconColor = const Color(0xFF60A5FA);
      statusIcon = Icons.explore_outlined;
      statusBadgeText = 'ACTIVE';
      statusBadgeColor = const Color(0xFF3B82F6);
    } else {
      iconCircleBg = const Color(0xFF1E293B);
      iconColor = const Color(0xFF64748B);
      statusIcon = Icons.lock_outline_rounded;
      statusBadgeText = 'LOCKED';
      statusBadgeColor = const Color(0xFF64748B);
    }

    final percentageDisplay = (item.progress * 100).toInt();

    return GestureDetector(
      onTap: isLocked
          ? () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${item.title} masih terkunci. Selesaikan misi sebelumnya! 🔒'),
                  duration: const Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          : onContinue,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive
                ? const Color(0xFF1E3A8A)
                : AppColors.borderDark,
            width: 1.2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Icon, Step/Title, Status Badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Circular Icon Box
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconCircleBg,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      statusIcon,
                      size: 20,
                      color: iconColor,
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.stepNumber,
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: isCompleted
                              ? const Color(0xFF94A3B8)
                              : (isActive
                                  ? const Color(0xFF60A5FA)
                                  : const Color(0xFF64748B)),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: isLocked
                              ? const Color(0xFF94A3B8)
                              : Colors.white,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.description,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: isLocked
                              ? const Color(0xFF64748B)
                              : AppColors.textSecondaryDark,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),

                // Status Badge in Top Right
                Text(
                  statusBadgeText,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: statusBadgeColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Progress Bar & Percentage Row
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                      value: item.progress,
                      minHeight: 4.5,
                      backgroundColor: const Color(0xFF1E293B),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isCompleted
                            ? const Color(0xFF10B981)
                            : const Color(0xFF3B82F6),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '$percentageDisplay%',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: isCompleted
                        ? const Color(0xFF10B981)
                        : (isActive
                            ? const Color(0xFF60A5FA)
                            : const Color(0xFF64748B)),
                  ),
                ),
              ],
            ),

            // "Lanjutkan >" link if Active
            if (isActive && !isCompleted) ...[
              const SizedBox(height: 12),
              GestureDetector(
                onTap: onContinue,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Lanjutkan',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF3B82F6),
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 16,
                      color: Color(0xFF3B82F6),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
