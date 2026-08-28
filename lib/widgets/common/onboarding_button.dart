import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class OnboardingButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool showChevron;
  final Color backgroundColor;
  final Color textColor;

  const OnboardingButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.showChevron = true,
    this.backgroundColor = AppColors.electricBlue,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 4,
          shadowColor: backgroundColor.withValues(alpha: 0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                  letterSpacing: 0.2,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (showChevron) ...[
              const SizedBox(width: 6),
              Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: textColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
