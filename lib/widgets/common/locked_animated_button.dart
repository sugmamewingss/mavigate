import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';

class LockedAnimatedButton extends StatefulWidget {
  final String text;
  final bool isLocked;
  final VoidCallback? onPressed;
  final String lockedMessage;
  final bool showChevron;

  const LockedAnimatedButton({
    super.key,
    required this.text,
    required this.isLocked,
    this.onPressed,
    this.lockedMessage = 'Selesaikan step "Buat Jadwal" terlebih dahulu! 🔒',
    this.showChevron = true,
  });

  @override
  State<LockedAnimatedButton> createState() => _LockedAnimatedButtonState();
}

class _LockedAnimatedButtonState extends State<LockedAnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _triggerLockedAnimation() {
    HapticFeedback.lightImpact();
    _shakeController.forward(from: 0.0);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.lock_outline_rounded, color: Colors.white, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                widget.lockedMessage,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.5,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1E293B),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1800),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.borderDark, width: 1),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLocked = widget.isLocked;

    return AnimatedBuilder(
      animation: _shakeController,
      builder: (context, child) {
        // Sine wave shake offset
        final sineValue = math.sin(_shakeController.value * math.pi * 5);
        final shakeOffset = sineValue * 8.0 * (1.0 - _shakeController.value);

        return Transform.translate(
          offset: Offset(shakeOffset, 0),
          child: child,
        );
      },
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: Material(
          color: isLocked ? const Color(0xFF162032) : AppColors.electricBlue,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: () {
              if (isLocked) {
                _triggerLockedAnimation();
              } else {
                widget.onPressed?.call();
              }
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isLocked ? const Color(0xFF222F48) : Colors.transparent,
                  width: 1.2,
                ),
                boxShadow: isLocked
                    ? null
                    : [
                        BoxShadow(
                          color: AppColors.electricBlue.withValues(alpha: 0.35),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      widget.text,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: isLocked ? const Color(0xFF64748B) : Colors.white,
                        letterSpacing: 0.2,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (widget.showChevron) ...[
                    const SizedBox(width: 6),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 20,
                      color: isLocked ? const Color(0xFF64748B) : Colors.white,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
