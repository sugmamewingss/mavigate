import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String userName;
  final String userEmail;
  final VoidCallback? onNavigateToJourney;

  const ProfileScreen({
    super.key,
    this.userName = 'Raven',
    this.userEmail = 'raven@email.com',
    this.onNavigateToJourney,
  });

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF131D31),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.borderDark),
        ),
        title: const Text(
          'Konfirmasi Keluar',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        content: const Text(
          'Apakah kamu yakin ingin keluar dari akun?',
          style: TextStyle(color: AppColors.textSecondaryDark),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal', style: TextStyle(color: Color(0xFF94A3B8))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayName = userName.isNotEmpty ? userName : 'Raven';
    final displayEmail = userEmail.isNotEmpty ? userEmail : 'raven@email.com';
    final initial = displayName.isNotEmpty ? displayName[0].toUpperCase() : 'R';

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header: "Profil Saya" & Subtitle
          const Text(
            'Profil Saya',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Perjalananmu, arahmu.',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondaryDark,
            ),
          ),

          const SizedBox(height: 20),

          // 2. User Info Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.surfaceDark,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: AppColors.borderDark,
                width: 1.2,
              ),
            ),
            child: Row(
              children: [
                // Avatar Circle
                Container(
                  width: 54,
                  height: 54,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1E3A8A),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      initial,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF60A5FA),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Name, Email, Role Tag
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        displayEmail,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: AppColors.textSecondaryDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFF334155),
                            width: 1,
                          ),
                        ),
                        child: const Text(
                          'Mahasiswa Baru',
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 3. CURRENT JOURNEY Card
          Container(
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
                // Top Row: Trophy + "CURRENT JOURNEY" & "Change"
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Text('🏆', style: TextStyle(fontSize: 16)),
                        SizedBox(width: 8),
                        Text(
                          'CURRENT JOURNEY',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF60A5FA),
                            letterSpacing: 0.6,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Target journey dapat diubah di semester baru! ✨'),
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      child: const Text(
                        'Change',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Title: Achiever
                const Text(
                  'Achiever',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.3,
                  ),
                ),

                const SizedBox(height: 6),

                // Description
                const Text(
                  'Build your skills, explore opportunities, and make your college years count.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondaryDark,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 18),

                // Quests progress row: 3 / 5 quests completed (60%)
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '3 / 5 quests completed',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '60%',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF60A5FA),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: const LinearProgressIndicator(
                    value: 0.6,
                    minHeight: 5,
                    backgroundColor: Color(0xFF1E293B),
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                  ),
                ),

                const SizedBox(height: 12),

                // Subtext: Currently on Quest 4
                const Text(
                  'Currently on Quest 4',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFF94A3B8),
                  ),
                ),

                const SizedBox(height: 16),

                // Link: View Journey >
                GestureDetector(
                  onTap: onNavigateToJourney,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View Journey',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF60A5FA),
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 16,
                        color: Color(0xFF60A5FA),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // 4. Section: JOURNEY HISTORY
          const Text(
            'JOURNEY HISTORY',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF94A3B8),
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 10),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceDark,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColors.borderDark,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Green checkmark in circle
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFF064E3B),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check_rounded,
                      color: Color(0xFF10B981),
                      size: 20,
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                // Info
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'JOURNEY 1',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF94A3B8),
                        letterSpacing: 0.4,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'HALO MABA!',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Completed',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF10B981),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // 5. Section: MY GOALS
          const Text(
            'MY GOALS',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF94A3B8),
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 10),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.surfaceDark,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColors.borderDark,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'My First Goal',
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Saya ingin sukses dunia dan akhirat.',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: AppColors.textSecondaryDark,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E2A44),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.circle, size: 6, color: Color(0xFF60A5FA)),
                      SizedBox(width: 6),
                      Text(
                        'Active',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF60A5FA),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // 6. Section: ACCOUNT
          const Text(
            'ACCOUNT',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF94A3B8),
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 10),

          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.surfaceDark,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColors.borderDark,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                // Account Settings
                ListTile(
                  leading: const Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                  title: const Text(
                    'Account Settings',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pengaturan akun akan segera hadir! ⚙️'),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),

                const Divider(height: 1, color: Color(0xFF1E293B)),

                // Log Out
                ListTile(
                  leading: const Icon(
                    Icons.logout_rounded,
                    color: Color(0xFFF87171),
                    size: 20,
                  ),
                  title: const Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFF87171),
                    ),
                  ),
                  onTap: () => _handleLogout(context),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
