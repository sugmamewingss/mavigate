import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/schedule_item.dart';
import '../../widgets/cards/schedule_class_card.dart';
import '../../widgets/common/locked_animated_button.dart';
import '../../widgets/common/onboarding_indicator.dart';

class BuildScheduleScreen extends StatefulWidget {
  final List<ScheduleItem> initialSchedule;
  final ValueChanged<List<ScheduleItem>> onScheduleUpdated;
  final VoidCallback? onBack;
  final VoidCallback? onNext;

  const BuildScheduleScreen({
    super.key,
    this.initialSchedule = const [],
    required this.onScheduleUpdated,
    this.onBack,
    this.onNext,
  });

  @override
  State<BuildScheduleScreen> createState() => _BuildScheduleScreenState();
}

class _BuildScheduleScreenState extends State<BuildScheduleScreen> {
  final TextEditingController _courseController = TextEditingController();
  late List<ScheduleItem> _scheduleList;

  String _selectedDay = 'Senin';
  String _selectedTime = '08:00 - 10:00';

  final List<String> _days = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
  ];

  final List<String> _times = [
    '08:00 - 10:00',
    '10:15 - 12:15',
    '13:00 - 15:00',
    '15:15 - 17:15',
    '18:30 - 20:30',
  ];

  @override
  void initState() {
    super.initState();
    _scheduleList = List.from(widget.initialSchedule);
  }

  @override
  void dispose() {
    _courseController.dispose();
    super.dispose();
  }

  void _onBack() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    widget.onBack?.call();
    Navigator.of(context).pop(_scheduleList);
  }

  void _addClass() {
    final courseName = _courseController.text.trim();
    if (courseName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Silakan masukkan nama mata kuliah terlebih dahulu!'),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    final newItem = ScheduleItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      courseName: courseName,
      day: _selectedDay,
      time: _selectedTime,
    );

    setState(() {
      _scheduleList.add(newItem);
      _courseController.clear();
    });

    widget.onScheduleUpdated(_scheduleList);

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('✓ Kelas "$courseName" berhasil ditambahkan!'),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1200),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _deleteClass(int index) {
    final deleted = _scheduleList[index];
    setState(() {
      _scheduleList.removeAt(index);
    });
    widget.onScheduleUpdated(_scheduleList);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Kelas "${deleted.courseName}" dihapus'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasClasses = _scheduleList.isNotEmpty;

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
                  // Top Row: Back Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      key: const Key('build_schedule_back_button'),
                      onPressed: _onBack,
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

                  // Form & Schedule List (Scrollable)
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Headline
                          const Text(
                            'Build Your Schedule',
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
                            'Tambahkan kelas ke dalam jadwal mingguan perkuliahanmu.',
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textSecondaryDark,
                              height: 1.45,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Card Input Form
                          Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceDark,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.borderDark,
                                width: 1.2,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // MATA KULIAH Label
                                const Text(
                                  'MATA KULIAH',
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF94A3B8),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 8),

                                // Text Field Mata Kuliah
                                TextField(
                                  controller: _courseController,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Nama mata kuliah (cth: Algoritma Pemrograman)',
                                    hintStyle: const TextStyle(
                                      color: Color(0xFF64748B),
                                      fontSize: 13.5,
                                    ),
                                    fillColor: const Color(0xFF0D1527),
                                    filled: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Color(0xFF1E293B)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Color(0xFF1E293B)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: AppColors.electricBlue,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // Row: HARI & WAKTU
                                Row(
                                  children: [
                                    // Dropdown HARI
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'HARI',
                                            style: TextStyle(
                                              fontSize: 11.5,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFF94A3B8),
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 12),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF0D1527),
                                              borderRadius: BorderRadius.circular(12),
                                              border: Border.all(color: const Color(0xFF1E293B)),
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                value: _selectedDay,
                                                isExpanded: true,
                                                dropdownColor: const Color(0xFF131D31),
                                                icon: const Icon(
                                                  Icons.keyboard_arrow_down_rounded,
                                                  color: Color(0xFF94A3B8),
                                                ),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13.5,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                items: _days.map((day) {
                                                  return DropdownMenuItem(
                                                    value: day,
                                                    child: Text(day),
                                                  );
                                                }).toList(),
                                                onChanged: (val) {
                                                  if (val != null) {
                                                    setState(() => _selectedDay = val);
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(width: 12),

                                    // Dropdown WAKTU
                                    Expanded(
                                      flex: 6,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'WAKTU',
                                            style: TextStyle(
                                              fontSize: 11.5,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFF94A3B8),
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 12),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF0D1527),
                                              borderRadius: BorderRadius.circular(12),
                                              border: Border.all(color: const Color(0xFF1E293B)),
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                value: _selectedTime,
                                                isExpanded: true,
                                                dropdownColor: const Color(0xFF131D31),
                                                icon: const Icon(
                                                  Icons.calendar_today_outlined,
                                                  size: 16,
                                                  color: Color(0xFF94A3B8),
                                                ),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                items: _times.map((t) {
                                                  return DropdownMenuItem(
                                                    value: t,
                                                    child: Text(t),
                                                  );
                                                }).toList(),
                                                onChanged: (val) {
                                                  if (val != null) {
                                                    setState(() => _selectedTime = val);
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 18),

                                // Button "+ Tambah Kelas"
                                SizedBox(
                                  width: double.infinity,
                                  height: 48,
                                  child: ElevatedButton(
                                    onPressed: _addClass,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.electricBlue,
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.add_rounded, size: 20),
                                        SizedBox(width: 6),
                                        Text(
                                          'Tambah Kelas',
                                          style: TextStyle(
                                            fontSize: 14.5,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Section Header: "Jadwal kamu" + Badge Counter
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(
                                child: Text(
                                  'Jadwal kamu',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF131D31),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: AppColors.borderDark),
                                ),
                                child: Text(
                                  '${_scheduleList.length} kelas ditambahkan',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF94A3B8),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // List of classes or Empty Box
                          if (!hasClasses)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 28),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceDark.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: AppColors.borderDark,
                                  width: 1,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Belum ada kelas yang ditambahkan',
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                              ),
                            )
                          else
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _scheduleList.length,
                              separatorBuilder: (context, index) => const SizedBox(height: 10),
                              itemBuilder: (context, index) {
                                final item = _scheduleList[index];
                                return ScheduleClassCard(
                                  item: item,
                                  onDelete: () => _deleteClass(index),
                                );
                              },
                            ),

                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Button: "Selesai >"
                  LockedAnimatedButton(
                    key: const Key('build_schedule_finish_button'),
                    text: 'Selesai',
                    isLocked: !hasClasses,
                    onPressed: () {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      Navigator.of(context).pop(_scheduleList);
                    },
                    lockedMessage: 'Tambahkan minimal 1 kelas ke jadwalmu! 📚',
                  ),

                  const SizedBox(height: 20),

                  // Page Indicator (5 Dots, index 2 aktif)
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
