import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class SubJourneyCompletionDialog extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final String mascotAsset;
  final VoidCallback onContinue;

  const SubJourneyCompletionDialog({
    super.key,
    this.title = 'Sub-Journey 1.1 selesai! 🎉',
    this.description =
        'Kamu sudah mengenal beberapa hal penting untuk memulai kehidupan perkuliahan.',
    this.buttonText = 'Lanjutkan →',
    this.mascotAsset = 'assets/images/Pose 16.png',
    required this.onContinue,
  });

  static Future<bool?> show(
    BuildContext context, {
    String title = 'Sub-Journey 1.1 selesai! 🎉',
    String description =
        'Kamu sudah mengenal beberapa hal penting untuk memulai kehidupan perkuliahan.',
    String buttonText = 'Lanjutkan →',
    String mascotAsset = 'assets/images/Pose 16.png',
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.75),
      builder: (context) => SubJourneyCompletionDialog(
        title: title,
        description: description,
        buttonText: buttonText,
        mascotAsset: mascotAsset,
        onContinue: () {
          Navigator.of(context).pop(true);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        decoration: BoxDecoration(
          color: const Color(0xFF131D31),
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: AppColors.borderDark,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Mascot Owl (Pose 16.png)
            SizedBox(
              width: 115,
              height: 105,
              child: Image.asset(
                mascotAsset,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      color: AppColors.surfaceDark,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.celebration_rounded,
                        color: AppColors.electricBlue,
                        size: 48,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 18),

            // Title "Sub-Journey 1.1 selesai! 🎉"
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18.5,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.3,
              ),
            ),

            const SizedBox(height: 10),

            // Subtitle Description
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondaryDark,
                height: 1.45,
              ),
            ),

            const SizedBox(height: 24),

            // Button: "Lanjutkan →"
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: onContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.electricBlue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
