import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AchieverJourneyCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress; // 0.0 to 1.0 (e.g. 0.40)
  final String progressText;
  final String footerText;

  const AchieverJourneyCard({
    super.key,
    this.title = 'Achiever Journey',
    this.subtitle =
        'Kembangkan keterampilanmu, jelajahi peluang, dan manfaatkan masa kuliahmu sebaik-baiknya.',
    this.progress = 0.40,
    this.progressText = '40% selesai',
    this.footerText = 'Mulai perjalanan mu!',
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Section with Trophy and Mascot (Pose 15.png)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Trophy Circle Icon
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Color(0xFF38202A),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.emoji_events_rounded,
                    color: Color(0xFFF87171),
                    size: 24,
                  ),
                ),
              ),

              // Owl Mascot (Pose 15.png)
              SizedBox(
                width: 92,
                height: 84,
                child: Image.asset(
                  'assets/images/Pose 15.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.school_rounded,
                        size: 52,
                        color: AppColors.electricBlue,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Title "Achiever Journey"
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.3,
            ),
          ),

          const SizedBox(height: 6),

          // Subtitle
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondaryDark,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 16),

          // Progress label "40% selesai"
          Text(
            progressText,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF10B981),
            ),
          ),

          const SizedBox(height: 6),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 5.5,
              backgroundColor: const Color(0xFF1E293B),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
            ),
          ),

          const SizedBox(height: 8),

          // Footer Text "Mulai perjalanan mu!"
          Text(
            footerText,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}
