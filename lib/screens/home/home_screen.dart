import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/cards/achiever_journey_card.dart';
import '../../widgets/cards/journey_unit_item_card.dart';
import '../../widgets/cards/motivation_quote_card.dart';
import '../../widgets/cards/next_step_card.dart';
import '../../widgets/navigation/custom_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  final String userEmail;

  const HomeScreen({
    super.key,
    this.userName = 'Raven',
    this.userEmail = '',
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;
  int _selectedJourneyTab = 0; // 0: Journey 1, 1: Journey 2, 2: Journey 3

  void _onTabSelected(int index) {
    setState(() {
      _currentNavIndex = index;
    });
  }

  void _goToJourney() {
    setState(() {
      _currentNavIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final displayName = widget.userName.isNotEmpty ? widget.userName : 'Raven';
    final userInitial = displayName.isNotEmpty ? displayName[0].toUpperCase() : 'R';

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: IndexedStack(
              index: _currentNavIndex,
              children: [
                // Tab 0: Beranda
                _buildBerandaTab(displayName, userInitial),

                // Tab 1: Journey
                _buildPlaceholderTab(
                  icon: Icons.explore_rounded,
                  title: 'Journey Section',
                  description: 'Section Journey sedang disiapkan dan akan kita lanjutkan berikutnya! 🧭',
                ),

                // Tab 2: Kalender
                _buildPlaceholderTab(
                  icon: Icons.calendar_today_rounded,
                  title: 'Kalender Section',
                  description: 'Jadwal dan aktivitas perkuliahan kamu.',
                ),

                // Tab 3: Profil
                _buildPlaceholderTab(
                  icon: Icons.person_rounded,
                  title: 'Profil Pengguna',
                  description: 'Kelola data diri, target semester, dan pengaturan akun.',
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentNavIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }

  Widget _buildBerandaTab(String displayName, String userInitial) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header (Greeting & Avatar)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat pagi, $displayName 👋',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondaryDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Ayo jadikan hari ini bermakna.',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Avatar Initial Circle
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    userInitial,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // 2. Achiever Journey Hero Card (Pose 15.png)
          const AchieverJourneyCard(
            title: 'Achiever Journey',
            subtitle:
                'Kembangkan keterampilanmu, jelajahi peluang, dan manfaatkan masa kuliahmu sebaik-baiknya.',
            progress: 0.40,
            progressText: '40% selesai',
            footerText: 'Mulai perjalanan mu!',
          ),

          const SizedBox(height: 24),

          // 3. Section: "Langkah Kamu Selanjutnya"
          const Text(
            'Langkah Kamu Selanjutnya',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 12),

          NextStepCard(
            tag: 'FOKUS SAAT INI',
            title: 'Goals',
            description: 'Tentukan satu tujuan yang ingin kamu mulai kejar.',
            onContinue: _goToJourney,
          ),

          const SizedBox(height: 24),

          // 4. Section: "Journey | Unit 1"
          const Text(
            'Journey | Unit 1',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 12),

          // Journey Tabs Pill Buttons
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _buildJourneyPillButton(
                  index: 0,
                  label: 'Journey 1',
                  isLocked: false,
                ),
                const SizedBox(width: 10),
                _buildJourneyPillButton(
                  index: 1,
                  label: 'Journey 2',
                  isLocked: true,
                ),
                const SizedBox(width: 10),
                _buildJourneyPillButton(
                  index: 2,
                  label: 'Journey 3',
                  isLocked: true,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Unit 1 Items List
          // Item 1: 1.1 Orientation (Completed)
          const JourneyUnitItemCard(
            stepNumber: '1.1',
            title: 'Orientation',
            description: 'Kenali beberapa hal mengenai dunia perkuliahan.',
            status: JourneyItemStatus.completed,
            progress: 1.0,
          ),

          const SizedBox(height: 12),

          // Item 2: 1.2 Calender (Completed)
          const JourneyUnitItemCard(
            stepNumber: '1.2',
            title: 'Calender',
            description: 'Atur aktivitas pentingmu di kalender.',
            status: JourneyItemStatus.completed,
            progress: 1.0,
          ),

          const SizedBox(height: 12),

          // Item 3: 1.3 Goals (In Progress / Active)
          JourneyUnitItemCard(
            stepNumber: '1.3',
            title: 'Goals',
            description: 'Tentukan satu tujuan yang ingin kamu mulai kejar.',
            status: JourneyItemStatus.inProgress,
            progress: 0.30,
            onTap: _goToJourney,
          ),

          const SizedBox(height: 12),

          // Item 4: Motivation Quote Card ("Teruslah melangkah maju" 🚀)
          const MotivationQuoteCard(
            title: 'Teruslah melangkah maju',
            quote: 'Langkah-langkah kecil yang konsisten menghasilkan kemajuan yang berarti.',
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildJourneyPillButton({
    required int index,
    required String label,
    required bool isLocked,
  }) {
    final isSelected = _selectedJourneyTab == index;

    return GestureDetector(
      onTap: () {
        if (isLocked) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$label masih terkunci. Selesaikan Journey sebelumnya! 🔒'),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 1),
            ),
          );
        } else {
          setState(() {
            _selectedJourneyTab = index;
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.electricBlue : AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.electricBlue : AppColors.borderDark,
            width: 1.2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLocked) ...[
              const Icon(
                Icons.lock_outline_rounded,
                size: 14,
                color: Color(0xFF94A3B8),
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderTab({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.surfaceDark,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.borderDark),
              ),
              child: Icon(
                icon,
                size: 36,
                color: const Color(0xFF60A5FA),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondaryDark,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
