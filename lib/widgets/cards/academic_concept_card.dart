import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AcademicConceptCard extends StatelessWidget {
  final IconData icon;
  final Color accentColor;
  final Color? iconBackgroundColor;
  final String tag;
  final String title;
  final String description;

  const AcademicConceptCard({
    super.key,
    required this.icon,
    required this.accentColor,
    this.iconBackgroundColor,
    required this.tag,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = iconBackgroundColor ?? accentColor.withValues(alpha: 0.15);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.borderDark,
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Icon + Tag
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 20,
                    color: accentColor,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  tag,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: accentColor,
                    letterSpacing: 0.1,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Main Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 6),

          // Subtitle / Description
          Text(
            description,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondaryDark,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
