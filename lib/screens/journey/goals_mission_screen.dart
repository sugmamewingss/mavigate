import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/dialogs/sub_journey_completion_dialog.dart';
import '../../widgets/navigation/custom_bottom_nav_bar.dart';

class GoalsMissionScreen extends StatefulWidget {
  final VoidCallback? onMissionCompleted;

  const GoalsMissionScreen({
    super.key,
    this.onMissionCompleted,
  });

  @override
  State<GoalsMissionScreen> createState() => _GoalsMissionScreenState();
}

class _GoalsMissionScreenState extends State<GoalsMissionScreen> {
  final TextEditingController _goalsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _goalsController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _goalsController.dispose();
    super.dispose();
  }

  bool get _isFormValid => _goalsController.text.trim().isNotEmpty;

  void _handleFinish() async {
    if (!_isFormValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Silakan tuliskan satu target atau goal pertamamu!'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
      return;
    }

    final confirmed = await SubJourneyCompletionDialog.show(
      context,
      title: 'Sub-Journey 1.3 selesai! 🎉',
      description:
          'Target pertamamu sudah tersimpan. Sekarang kamu punya arah yang lebih jelas untuk memulai perkuliahan!',
      buttonText: 'Lanjutkan →',
      mascotAsset: 'assets/images/Pose 16.png',
    );

    if (confirmed == true && mounted) {
      widget.onMissionCompleted?.call();
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  // 1. Top Bar: Back Button & Title "Tentukan Goals"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(false),
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

                      const Text(
                        'Tentukan Goals',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF94A3B8),
                        ),
                      ),

                      const SizedBox(width: 40), // Balanced spacing
                    ],
                  ),

                  const SizedBox(height: 20),

                  // 2. Headline & Subtitle
                  const Text(
                    'Tentukan Goals',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.4,
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    'Tidak perlu memikirkan semuanya sekaligus. Tentukan satu tujuan yang ingin kamu mulai kejar.',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondaryDark,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 3. Form Card ("GOALS PERTAMAMU")
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Tag: "GOALS PERTAMAMU"
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E293B),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFF334155),
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                'GOALS PERTAMAMU',
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF60A5FA),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Question Title
                            const Text(
                              'Apa satu hal yang ingin kamu capai atau kembangkan di awal kuliah?',
                              style: TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                height: 1.35,
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Multi-line Text Input Container
                            Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                color: const Color(0xFF0F172A),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: const Color(0xFF1E293B),
                                  width: 1,
                                ),
                              ),
                              child: TextField(
                                controller: _goalsController,
                                maxLines: null,
                                expands: true,
                                textAlignVertical: TextAlignVertical.top,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  height: 1.4,
                                ),
                                decoration: const InputDecoration(
                                  hintText:
                                      'Contoh: Saya ingin lebih percaya diri mengikuti kegiatan kampus.',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF64748B),
                                    fontSize: 13,
                                    height: 1.4,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(16),
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Card Footer Note
                            const Text(
                              'Buat sesederhana mungkin. Yang penting jelas dan bermakna untukmu.',
                              style: TextStyle(
                                fontSize: 11.5,
                                color: Color(0xFF64748B),
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 4. Bottom Button: "Selesai ✓"
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _isFormValid ? _handleFinish : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isFormValid
                            ? const Color(0xFF10B981)
                            : const Color(0xFF1E293B),
                        foregroundColor: _isFormValid
                            ? Colors.white
                            : const Color(0xFF64748B),
                        disabledBackgroundColor: const Color(0xFF1E293B),
                        disabledForegroundColor: const Color(0xFF64748B),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Selesai',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.check_rounded, size: 20),
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
