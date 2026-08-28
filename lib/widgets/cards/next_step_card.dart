import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class NextStepCard extends StatelessWidget {
  final String tag;
  final String title;
  final String description;
  final VoidCallback onContinue;

  const NextStepCard({
    super.key,
    this.tag = 'FOKUS SAAT INI',
    this.title = 'Goals',
    this.description = 'Tentukan satu tujuan yang ingin kamu mulai kejar.',
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.borderDark,
          width: 1.2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Compass Circle Icon
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0xFF1E2A44),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.explore_outlined,
                color: Color(0xFF60A5FA),
                size: 22,
              ),
            ),
          ),

          const SizedBox(width: 14),

          // Content Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tag "FOKUS SAAT INI"
                Text(
                  tag,
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF3B82F6),
                    letterSpacing: 0.6,
                  ),
                ),

                const SizedBox(height: 4),

                // Title "Goals"
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15.5,
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

                const SizedBox(height: 12),

                // Action Link "Lanjutkan Journey >"
                GestureDetector(
                  onTap: onContinue,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Lanjutkan Journey',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF3B82F6),
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 18,
                        color: Color(0xFF3B82F6),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
