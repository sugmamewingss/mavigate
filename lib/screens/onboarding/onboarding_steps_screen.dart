import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/common/locked_animated_button.dart';
import '../../widgets/common/onboarding_indicator.dart';
import '../../widgets/stepper/onboarding_step_card.dart';

class OnboardingStepsScreen extends StatelessWidget {
  final bool isPriorityCompleted;
  final bool isScheduleCompleted;
  final VoidCallback? onBack;
  final VoidCallback? onAturPrioritas;
  final VoidCallback? onBuildSchedule;
  final VoidCallback? onNext;

  const OnboardingStepsScreen({
    super.key,
    this.isPriorityCompleted = true, // Default to true or controlled by state
    this.isScheduleCompleted = false,
    this.onBack,
    this.onAturPrioritas,
    this.onBuildSchedule,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final allCompleted = isPriorityCompleted && isScheduleCompleted;

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

                  const SizedBox(height: 12),

                  // Stepper Content
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ayo siapkan kamu kuliah!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: -0.4,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '3 langkah sederhana membantu memulai kehidupan kampus dengan rencana lebih jelas.',
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textSecondaryDark,
                              height: 1.45,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Step 01: Kamu resmi MABA!
                          const OnboardingStepCard(
                            stepNumber: '01',
                            icon: Icons.school_outlined,
                            status: StepStatus.completed,
                            title: 'Kamu resmi MABA!',
                            highlightText: 'Selamat datang di kehidupan kampus!',
                            description:
                                'Kamu telah mempelajari dasar-dasar KRS, SKS, jadwal, dan kurikulum. Sekarang, mari kita praktikkan pengetahuan tersebut.',
                          ),

                          // Step 02: Atur Prioritasmu!
                          OnboardingStepCard(
                            stepNumber: '02',
                            icon: Icons.star_outline_rounded,
                            status: isPriorityCompleted
                                ? StepStatus.completed
                                : StepStatus.active,
                            title: 'Atur Prioritasmu!',
                            highlightText: 'Tentukan apa yang paling penting',
                            description:
                                'Kuliah terdiri dari berbagai kelas, tugas, kegiatan, dan waktu pribadi. Belajarlah menentukan kegiatan yang patut mendapat perhatian kamu dulu.',
                            actionButtonText: isPriorityCompleted ? null : 'Atur Prioritas',
                            onActionButtonPressed: onAturPrioritas,
                          ),

                          // Step 03: Buat Jadwal Kelasmu!
                          OnboardingStepCard(
                            stepNumber: '03',
                            icon: isScheduleCompleted
                                ? Icons.check_circle_outline_rounded
                                : (isPriorityCompleted
                                    ? Icons.calendar_today_outlined
                                    : Icons.lock_outline_rounded),
                            status: isScheduleCompleted
                                ? StepStatus.completed
                                : (isPriorityCompleted
                                    ? StepStatus.active
                                    : StepStatus.locked),
                            title: 'Buat Jadwal Kelasmu!',
                            highlightText: 'Ubah kelas menjadi rencana nyata.',
                            description:
                                'Jadwal perkuliahan bisa jadi fleksibel. Masukkan jadwal kelas ke dalam kalender agar kamu tahu bagaimana waktu kamu digunakan.',
                            actionButtonText: isScheduleCompleted
                                ? null
                                : (isPriorityCompleted ? 'Buat Jadwal' : null),
                            onActionButtonPressed: onBuildSchedule,
                            isLast: true,
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),

                  // Button with Shake Animation when Locked
                  LockedAnimatedButton(
                    text: 'Ayo Tentukan Targetmu',
                    isLocked: !allCompleted,
                    onPressed: onNext,
                    lockedMessage: 'Selesaikan semua langkah terlebih dahulu! 🔒',
                  ),

                  const SizedBox(height: 20),

                  // Indicator (Dot 3 active)
                  const Center(
                    child: OnboardingIndicator(
                      totalDots: 5,
                      activeIndex: 2,
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
