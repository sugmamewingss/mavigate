import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/cards/progress_summary_card.dart';
import '../../widgets/common/onboarding_button.dart';
import '../../widgets/common/onboarding_indicator.dart';

class OnboardingCompletionScreen extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onNext;

  const OnboardingCompletionScreen({
    super.key,
    this.onBack,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
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
                      onPressed: onBack,
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

                  const SizedBox(height: 8),

                  // Scrollable Content
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Mascot Image (Pose 14.png)
                          Center(
                            child: SizedBox(
                              width: 180,
                              height: 180,
                              child: Image.asset(
                                'assets/images/Pose 14.png',
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.surfaceDark,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.celebration_rounded,
                                        size: 72,
                                        color: AppColors.electricBlueLight,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Celebration Headline
                          const Text(
                            '🎉 Selamat, tahap MABA\nselesai!!!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              height: 1.25,
                              letterSpacing: -0.3,
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Subtitle
                          const Text(
                            'Kamu telah mempelajari dasar-dasarnya,\nmenetapkan prioritas, dan menyusun jadwal\nkelas pertama kamu.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textSecondaryDark,
                              height: 1.45,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Progress Summary Card (3 / 3 Selesai)
                          const ProgressSummaryCard(
                            title: 'Progres',
                            statusText: '3 / 3 Selesai',
                            progress: 1.0,
                            completedItems: [
                              'Dasar Kampus',
                              'Rencana Prioritas',
                              'Jadwal Kelas',
                            ],
                          ),

                          const SizedBox(height: 20),

                          // Footer note
                          const Text(
                            'Kamu sudah membuat kalendermu. Sekarang, kita cari tahu apa yang menjadi target kamu.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textSecondaryDark,
                              height: 1.4,
                            ),
                          ),

                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Action Button: "Ayo Tentukan Targetmu >"
                  OnboardingButton(
                    text: 'Ayo Tentukan Targetmu',
                    onPressed: onNext ?? () {},
                  ),

                  const SizedBox(height: 20),

                  // Page Indicator (5 Dots, index 3 aktif)
                  const Center(
                    child: OnboardingIndicator(
                      totalDots: 5,
                      activeIndex: 3,
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
