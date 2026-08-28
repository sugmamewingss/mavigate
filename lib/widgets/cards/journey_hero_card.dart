import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class JourneyHeroCard extends StatelessWidget {
  final String title;
  final String description;
  final int percentage; // 0, 40, 80, 100
  final double progress; // 0.0 to 1.0

  const JourneyHeroCard({
    super.key,
    this.title = 'HALO MABA Journey',
    this.description =
        'Panduan langkah demi langkah untuk beradaptasi dan sukses di dunia perkuliahan.',
    required this.percentage,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final isComplete = percentage >= 100;

    String noteText;
    if (percentage == 0) {
      noteText = '🚀 Ayo mulai langkah pertamamu!';
    } else if (percentage < 100) {
      noteText = '✨ Sedikit lagi!';
    } else {
      noteText = '✨ Journey selesai!';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isComplete
              ? const Color(0xFF065F46)
              : AppColors.borderDark,
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Maroon Icon Box
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFF38202A),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Icon(
                isComplete
                    ? Icons.school_rounded
                    : Icons.auto_stories_rounded,
                color: const Color(0xFFF87171),
                size: 24,
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Title "HALO MABA Journey"
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.3,
            ),
          ),

          if (isComplete) ...[
            const SizedBox(height: 4),
            const Text(
              'SELESAI',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: Color(0xFF10B981),
                letterSpacing: 0.6,
              ),
            ),
          ] else ...[
            const SizedBox(height: 6),
            Text(
              description,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondaryDark,
                height: 1.4,
              ),
            ),
          ],

          const SizedBox(height: 20),

          // Status & Percentage Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isComplete ? '3/3 SELESAI' : 'JOURNEY STATUS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: isComplete
                      ? const Color(0xFF94A3B8)
                      : const Color(0xFF94A3B8),
                  letterSpacing: 0.6,
                ),
              ),
              Text(
                '$percentage%',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: isComplete
                      ? const Color(0xFF10B981)
                      : const Color(0xFF60A5FA),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: const Color(0xFF1E293B),
              valueColor: AlwaysStoppedAnimation<Color>(
                isComplete
                    ? const Color(0xFF10B981)
                    : const Color(0xFF3B82F6),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Note Text (e.g. "✨ Journey selesai!")
          Text(
            noteText,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: isComplete
                  ? const Color(0xFFFBBF24)
                  : const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}
