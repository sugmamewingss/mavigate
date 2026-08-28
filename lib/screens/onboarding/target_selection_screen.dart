import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/cards/target_goal_card.dart';
import '../../widgets/common/locked_animated_button.dart';
import '../../widgets/common/onboarding_indicator.dart';

class TargetSelectionScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final ValueChanged<String>? onTargetSelected;
  final VoidCallback? onNext;

  const TargetSelectionScreen({
    super.key,
    this.onBack,
    this.onTargetSelected,
    this.onNext,
  });

  @override
  State<TargetSelectionScreen> createState() => _TargetSelectionScreenState();
}

class _TargetSelectionScreenState extends State<TargetSelectionScreen> {
  String? _selectedTarget;

  @override
  Widget build(BuildContext context) {
    final hasSelection = _selectedTarget != null;

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back (Kembali) Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: widget.onBack,
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.textSecondaryDark,
                        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                        alignment: Alignment.centerLeft,
                      ),
                      child: const Text(
                        'Kembali',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondaryDark,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Content Scrollable
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Headline
                          const Text(
                            'Seperti apa pengalaman kuliah yang kamu inginkan?',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              height: 1.25,
                              letterSpacing: -0.4,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Subtitle
                          const Text(
                            'Tidak ada jawaban benar atau salah. Pilihlah yang paling sesuai dengan dirimu.',
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textSecondaryDark,
                              height: 1.45,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Option 1: Intensive
                          TargetGoalCard(
                            title: 'Intensive',
                            description:
                                'Saya ingin memanfaatkan masa kuliah sebaik-baiknya, mengembangkan keterampilan, mengejar peluang, dan mencapai tujuan yang bermakna.',
                            icon: Icons.emoji_events_outlined,
                            iconColor: const Color(0xFFF87171),
                            iconBgColor: const Color(0xFF38202A),
                            tags: const ['Focus', 'Growth', 'Achievement'],
                            tagColor: const Color(0xFFF87171),
                            isSelected: _selectedTarget == 'Intensive',
                            onTap: () {
                              setState(() {
                                _selectedTarget = 'Intensive';
                              });
                              widget.onTargetSelected?.call('Intensive');
                            },
                          ),

                          const SizedBox(height: 16),

                          // Option 2: Balanced
                          TargetGoalCard(
                            title: 'Balanced',
                            description:
                                'Saya ingin berkembang secara akademis sembari meluangkan waktu untuk diri sendiri, teman-teman, dan pengalaman lainnya.',
                            icon: Icons.balance_rounded,
                            iconColor: const Color(0xFF34D399),
                            iconBgColor: const Color(0xFF14352A),
                            tags: const ['Balance', 'Wellbeing', 'Experience'],
                            tagColor: const Color(0xFF34D399),
                            isSelected: _selectedTarget == 'Balanced',
                            onTap: () {
                              setState(() {
                                _selectedTarget = 'Balanced';
                              });
                              widget.onTargetSelected?.call('Balanced');
                            },
                          ),

                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Button: "Ayo Tentukan Targetmu >"
                  LockedAnimatedButton(
                    key: const Key('target_selection_next_button'),
                    text: 'Ayo Tentukan Targetmu',
                    isLocked: !hasSelection,
                    onPressed: widget.onNext,
                    lockedMessage: 'Pilih salah satu target pengalaman kuliahmu! 🎯',
                  ),

                  const SizedBox(height: 20),

                  // Page Indicator (5 Dots, index 4 aktif - dot terakhir)
                  const Center(
                    child: OnboardingIndicator(
                      totalDots: 5,
                      activeIndex: 4,
                    ),
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
