import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/journey_model.dart';
import '../../widgets/dialogs/sub_journey_completion_dialog.dart';
import '../../widgets/navigation/custom_bottom_nav_bar.dart';

class SubJourneyMissionScreen extends StatefulWidget {
  final String missionTitle;
  final String missionSubtitle;
  final String subJourneyCode; // e.g. "1.1"
  final List<MissionStepData> steps;
  final VoidCallback? onMissionCompleted;

  const SubJourneyMissionScreen({
    super.key,
    required this.missionTitle,
    required this.missionSubtitle,
    this.subJourneyCode = '1.1',
    required this.steps,
    this.onMissionCompleted,
  });

  @override
  State<SubJourneyMissionScreen> createState() => _SubJourneyMissionScreenState();
}

class _SubJourneyMissionScreenState extends State<SubJourneyMissionScreen> {
  int _currentStepIndex = 0;

  void _handleNext() async {
    if (_currentStepIndex < widget.steps.length - 1) {
      setState(() {
        _currentStepIndex++;
      });
    } else {
      // Step 7 completed -> Show Completion Dialog (Pose 16.png)
      final confirmed = await SubJourneyCompletionDialog.show(
        context,
        title: 'Sub-Journey ${widget.subJourneyCode} selesai! 🎉',
        description:
            'Kamu sudah mengenal beberapa hal penting untuk memulai kehidupan perkuliahan.',
        buttonText: 'Lanjutkan →',
        mascotAsset: 'assets/images/Pose 16.png',
      );

      if (confirmed == true && mounted) {
        widget.onMissionCompleted?.call();
        Navigator.of(context).pop(true);
      }
    }
  }

  void _handleBack() {
    if (_currentStepIndex > 0) {
      setState(() {
        _currentStepIndex--;
      });
    } else {
      Navigator.of(context).pop(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalSteps = widget.steps.length;
    final currentStep = widget.steps[_currentStepIndex];

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Top Bar: Back Button & Step Counter (e.g. 1 / 7)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: _handleBack,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: AppColors.surfaceDark,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.chevron_left_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),

                      Text(
                        '${_currentStepIndex + 1} / $totalSteps',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF94A3B8),
                        ),
                      ),

                      const SizedBox(width: 40), // Balanced placeholder
                    ],
                  ),

                  const SizedBox(height: 16),

                  // 2. Segmented Progress Bar (7 Segments)
                  Row(
                    children: List.generate(totalSteps, (index) {
                      Color segmentColor;
                      if (index < _currentStepIndex) {
                        segmentColor = const Color(0xFF10B981); // Green (Completed)
                      } else if (index == _currentStepIndex) {
                        segmentColor = const Color(0xFF3B82F6); // Blue (Active)
                      } else {
                        segmentColor = const Color(0xFF1E293B); // Dark Slate (Future)
                      }

                      return Expanded(
                        child: Container(
                          height: 4,
                          margin: EdgeInsets.only(
                            right: index == totalSteps - 1 ? 0 : 5,
                          ),
                          decoration: BoxDecoration(
                            color: segmentColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 24),

                  // 3. Title & Subtitle
                  Text(
                    widget.missionTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.4,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    widget.missionSubtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondaryDark,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 4. Mission Content Card
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceDark,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: AppColors.borderDark,
                            width: 1.2,
                          ),
                        ),
                        child: Column(
                          children: [
                            // Topic Name (e.g. "Jadwal", "KRS", "SKS", "SIAM", "Gapura", "Brone", "Pusat Layanan...")
                            Text(
                              currentStep.topic,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16.5,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF3B82F6),
                                letterSpacing: 0.2,
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Reference Image / Graphic Container
                            Container(
                              width: double.infinity,
                              height: 180,
                              decoration: BoxDecoration(
                                color: const Color(0xFF0F172A),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: const Color(0xFF1E293B),
                                ),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF1E293B),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.image_outlined,
                                        color: Color(0xFF64748B),
                                        size: 32,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Reference Image',
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Description Text
                            Text(
                              currentStep.description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textSecondaryDark,
                                height: 1.45,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 5. Action Button: "Lanjut >"
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _handleNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.electricBlue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Lanjut',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.chevron_right_rounded, size: 20),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1, // Active at Journey tab
        onTabSelected: (index) {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
