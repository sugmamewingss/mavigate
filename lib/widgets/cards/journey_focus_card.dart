import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class JourneyFocusCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onContinue;
  final bool isAllCompleted;

  const JourneyFocusCard({
    super.key,
    required this.title,
    required this.description,
    required this.onContinue,
    this.isAllCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isAllCompleted
              ? const Color(0xFF065F46)
              : const Color(0xFF1E3A8A),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Compass Icon & "ACTION REQUIRED" Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Color(0xFF1E2A44),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    isAllCompleted
                        ? Icons.check_circle_rounded
                        : Icons.explore_outlined,
                    color: isAllCompleted
                        ? const Color(0xFF10B981)
                        : const Color(0xFF60A5FA),
                    size: 22,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: isAllCompleted
                      ? const Color(0xFF064E3B)
                      : const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isAllCompleted
                        ? const Color(0xFF059669)
                        : const Color(0xFF2563EB),
                    width: 1,
                  ),
                ),
                child: Text(
                  isAllCompleted ? 'COMPLETED' : 'ACTION REQUIRED',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: isAllCompleted
                        ? const Color(0xFF34D399)
                        : const Color(0xFF60A5FA),
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.3,
            ),
          ),

          const SizedBox(height: 6),

          // Description
          Text(
            description,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondaryDark,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 18),

          // Action Button: "Lanjutkan >"
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: isAllCompleted
                    ? const Color(0xFF10B981)
                    : AppColors.electricBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isAllCompleted ? 'Buka Kembali Misi' : 'Lanjutkan',
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.chevron_right_rounded, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
