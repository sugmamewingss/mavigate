import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/common/mavigate_logo.dart';
import '../../widgets/common/onboarding_button.dart';
import '../../widgets/common/onboarding_indicator.dart';

class OnboardingLandingScreen extends StatelessWidget {
  final VoidCallback? onNext;
  final VoidCallback? onSkip;

  const OnboardingLandingScreen({
    super.key,
    this.onNext,
    this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                children: [
                  // Top Row: Skip (Lewati) Button aligned to right
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: onSkip ??
                          () {
                            // Temporary feedback / skip to Auth
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Menuju Halaman Auth (Login/Register)...'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.textSecondaryDark,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      ),
                      child: const Text(
                        'Lewati',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondaryDark,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Mavigate Logo
                  const MavigateLogo(
                    fontSize: 26,
                    textColor: Colors.white,
                  ),

                  const SizedBox(height: 24),

                  // Headline & Description
                  const Text(
                    'College is confusing.\nLet\'s navigate it.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.25,
                      letterSpacing: -0.4,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Mavigate memberi kamu rekomendasi untuk menemukan hal-hal yang penting, dan tempat yang tepat untuk memulai perkuliahan.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondaryDark,
                        height: 1.45,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Hero Illustration / Picture Container
                  Expanded(
                    child: Center(
                      child: Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          maxWidth: 320,
                          maxHeight: size.height * 0.38,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceDark,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: AppColors.borderDark,
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.electricBlue.withValues(alpha: 0.12),
                              blurRadius: 28,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          'assets/images/onboarding_hero_1.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // Fallback academic illustration graphic if asset is still loading
                            return Container(
                              color: AppColors.surfaceDark,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.school_rounded,
                                    size: 64,
                                    color: AppColors.electricBlueLight,
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    'Academic Roadmap',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Bottom Action Button: "Ayo Mulai >"
                  OnboardingButton(
                    text: 'Ayo Mulai',
                    onPressed: onNext ??
                        () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Menuju halaman onboarding berikutnya...'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                  ),

                  const SizedBox(height: 20),

                  // Page Indicator (5 Dots, 1st Active)
                  const OnboardingIndicator(
                    totalDots: 5,
                    activeIndex: 0,
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
