import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ProgressSummaryCard extends StatelessWidget {
  final String title;
  final String statusText;
  final double progress; // 0.0 to 1.0
  final List<String> completedItems;

  const ProgressSummaryCard({
    super.key,
    this.title = 'Progres',
    this.statusText = '3 / 3 Selesai',
    this.progress = 1.0,
    this.completedItems = const [
      'Dasar Kampus',
      'Rencana Prioritas',
      'Jadwal Kelas',
    ],
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
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Text(
                statusText,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF10B981),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: const Color(0xFF1E293B),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
            ),
          ),

          const SizedBox(height: 16),

          // Completed Items List
          ...completedItems.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_rounded,
                    size: 18,
                    color: Color(0xFF10B981),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    item,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
