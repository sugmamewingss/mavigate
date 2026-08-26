import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class MavigateLogo extends StatelessWidget {
  final double fontSize;
  final Color textColor;
  final Color sparkleColor;

  const MavigateLogo({
    super.key,
    this.fontSize = 24,
    this.textColor = Colors.white,
    this.sparkleColor = AppColors.electricBlueLight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 'M' with sparkle badge
        Stack(
          clipBehavior: Clip.none,
          children: [
            Text(
              'M',
              style: TextStyle(
                fontSize: fontSize * 1.1,
                fontWeight: FontWeight.w900,
                color: textColor,
                height: 1.0,
                letterSpacing: -0.5,
              ),
            ),
            Positioned(
              top: -2,
              right: -5,
              child: Text(
                '✦',
                style: TextStyle(
                  fontSize: fontSize * 0.55,
                  color: sparkleColor,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 4),
        Text(
          'avigate',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w800,
            color: textColor,
            letterSpacing: -0.3,
            height: 1.0,
          ),
        ),
      ],
    );
  }
}
