import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/schedule_item.dart';

class ScheduleClassCard extends StatelessWidget {
  final ScheduleItem item;
  final VoidCallback? onDelete;

  const ScheduleClassCard({
    super.key,
    required this.item,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.borderDark,
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          // Class Icon Badge
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.electricBlue.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(
                Icons.menu_book_rounded,
                size: 20,
                color: AppColors.electricBlueLight,
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Details: Name & Day Time
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.courseName,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.schedule_rounded,
                      size: 13,
                      color: AppColors.textSecondaryDark,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${item.day}, ${item.time}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondaryDark,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Delete action
          if (onDelete != null)
            IconButton(
              icon: const Icon(
                Icons.delete_outline_rounded,
                size: 20,
                color: Color(0xFF94A3B8),
              ),
              onPressed: onDelete,
              splashRadius: 20,
              tooltip: 'Hapus kelas',
            ),
        ],
      ),
    );
  }
}
