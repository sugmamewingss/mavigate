import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../services/auth_database_service.dart';
import '../../widgets/common/mavigate_logo.dart';
import '../home/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Silakan lengkapi semua kolom pendaftaran!'),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Kata sandi dan konfirmasi kata sandi tidak sama! Silakan periksa kembali.'),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    final success = await AuthDatabaseService().registerUser(
      name: name,
      email: email,
      password: password,
    );

    if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Email sudah terdaftar! Silakan gunakan email lain atau masuk.'),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            userName: name,
            userEmail: email,
          ),
        ),
        (route) => false,
      );
    }
  }

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
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),

                          // Top Centered Mavigate Logo
                          const Center(
                            child: MavigateLogo(height: 38),
                          ),

                          const SizedBox(height: 24),

                          // Headline "Mari kita mulai."
                          const Center(
                            child: Text(
                              'Mari kita mulai.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.4,
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Subtitle
                          const Center(
                            child: Text(
                              'Buat akun Mavigate kamu dan mulailah\nmenemukan arahmu.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textSecondaryDark,
                                height: 1.4,
                              ),
                            ),
                          ),

                          const SizedBox(height: 28),

                          // Field: Nama
                          const Text(
                            'Nama',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildTextField(
                            controller: _nameController,
                            hintText: 'Apa nama panggilan kamu?',
                          ),

                          const SizedBox(height: 18),

                          // Field: Email
                          const Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildTextField(
                            controller: _emailController,
                            hintText: 'Masukkan email',
                            keyboardType: TextInputType.emailAddress,
                          ),

                          const SizedBox(height: 18),

                          // Field: Kata Sandi
                          const Text(
                            'Kata Sandi',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildTextField(
                            controller: _passwordController,
                            hintText: 'Buat kata sandi',
                            obscureText: _obscurePassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: const Color(0xFF64748B),
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),

                          const SizedBox(height: 18),

                          // Field: Konfirmasi Kata Sandi
                          const Text(
                            'Konfirmasi Kata Sandi',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildTextField(
                            controller: _confirmPasswordController,
                            hintText: 'Masukkan kembali kata sandi',
                            obscureText: _obscureConfirmPassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: const Color(0xFF64748B),
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword = !_obscureConfirmPassword;
                                });
                              },
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Note text
                          const Center(
                            child: Text(
                              'Informasi kamu hanya digunakan untuk menyimpan perjalanan dan\nprogres Mavigate kamu.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11.5,
                                color: Color(0xFF64748B),
                                height: 1.4,
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Button: "Buat Akun >"
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: _handleRegister,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.surfaceDark,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  side: const BorderSide(
                                    color: Color(0xFF1E293B),
                                    width: 1.2,
                                  ),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Buat Akun',
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

                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Link: "Sudah memiliki akun? Masuk"
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          text: 'Sudah memiliki akun? ',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF94A3B8),
                          ),
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Masuk',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14.5,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFF64748B),
          fontSize: 13.5,
        ),
        suffixIcon: suffixIcon,
        fillColor: AppColors.surfaceDark,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF1E293B)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF1E293B)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: AppColors.electricBlue,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
