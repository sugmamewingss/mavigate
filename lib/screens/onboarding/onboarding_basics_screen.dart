import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/cards/academic_concept_card.dart';
import '../../widgets/common/onboarding_button.dart';
import '../../widgets/common/onboarding_indicator.dart';

class OnboardingBasicsScreen extends StatelessWidget {
  final VoidCallback? onNext;
  final VoidCallback? onBack;

  const OnboardingBasicsScreen({
    super.key,
    this.onNext,
    this.onBack,
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
                  // Top Row: Back (Kembali) Button
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

                  // Headline & Description (Scrollable Area)
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Headline
                          const Text(
                            'Ayo pahami dulu dasarnya!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: -0.4,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Subtitle
                          const Text(
                            'Jangan khawatir, kamu tidak harus memahami semuanya, tapi mari kita ketahui dasarnya!',
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textSecondaryDark,
                              height: 1.45,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Card 1: KRS & SKS
                          const AcademicConceptCard(
                            icon: Icons.layers_outlined,
                            accentColor: Color(0xFFFBBF24),
                            tag: 'KRS & SKS',
                            title: 'Semester dimulai dengan berbagai pilihan.',
                            description:
                                'Pilih mata kuliah yang akan diambil dalam satu semester. SKS menunjukkan besarnya beban studi untuk setiap mata kuliah.',
                          ),

                          const SizedBox(height: 14),

                          // Card 2: Jadwal Bisa Fleksibel
                          const AcademicConceptCard(
                            icon: Icons.calendar_month_outlined,
                            accentColor: Color(0xFF60A5FA),
                            tag: 'Jadwal Bisa Fleksibel.',
                            title: 'Jadwalmu mungkin tidak sama setiap harinya.',
                            description:
                                'Berbeda dengan sekolah, jadwal kuliah bisa bervariasi antar-mahasiswa. Kamu mungkin memiliki kelas, jeda waktu, kegiatan, dan waktu luang yang berbeda-beda sepanjang minggu.',
                          ),

                          const SizedBox(height: 14),

                          // Card 3: Kurikulum adalah Peta
                          const AcademicConceptCard(
                            icon: Icons.map_outlined,
                            accentColor: Color(0xFFF87171),
                            tag: 'Kurikulum adalah Peta',
                            title: 'You don\'t have to take every course at once.',
                            description:
                                'Kurikulum menampilkan mata kuliah dan jalur pembelajaran yang akan ditempuh selama program studi kamu.',
                          ),

                          const SizedBox(height: 20),

                          // Footer Info Text
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                'Kamu sudah mempelajari dasar-dasarnya. Sekarang, kita cari tahu apa yang kamu inginkan.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textSecondaryDark,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Action Button: "Ayo Siapkan Jadwal >"
                  OnboardingButton(
                    text: 'Ayo Siapkan Jadwal',
                    onPressed: onNext ?? () {},
                  ),

                  const SizedBox(height: 20),

                  // Page Indicator (5 Dots, index 1 aktif)
                  const Center(
                    child: OnboardingIndicator(
                      totalDots: 5,
                      activeIndex: 1,
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
