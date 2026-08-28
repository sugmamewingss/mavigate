import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/calendar_model.dart';
import '../../widgets/dialogs/add_schedule_dialog.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int _selectedDayIndex = 2; // 0: 24, 1: 25, 2: 26, 3: 27, 4: 28, 5: 29, 6: 30

  final List<String> _dayNames = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
  final List<int> _dates = [24, 25, 26, 27, 28, 29, 30];

  final List<CalendarScheduleItem> _schedules = [
    const CalendarScheduleItem(
      id: '1',
      title: 'Programming',
      time: '08:00',
      date: '26/08/26',
      category: ScheduleCategory.kelas,
    ),
    const CalendarScheduleItem(
      id: '2',
      title: 'Organization Meeting',
      time: '13:00',
      date: '26/08/26',
      category: ScheduleCategory.aktivitas,
    ),
    const CalendarScheduleItem(
      id: '3',
      title: 'Study Session',
      time: '18:00',
      date: '26/08/26',
      category: ScheduleCategory.personal,
    ),
  ];

  String get _selectedDateHeader {
    final dayName = switch (_selectedDayIndex) {
      0 => 'SENIN',
      1 => 'SELASA',
      2 => 'RABU',
      3 => 'KAMIS',
      4 => 'JUMAT',
      5 => 'SABTU',
      _ => 'MINGGU',
    };
    return '$dayName, ${_dates[_selectedDayIndex]} AGUSTUS';
  }

  void _openAddSchedule() async {
    final newItem = await AddScheduleDialog.show(context);
    if (newItem != null && mounted) {
      setState(() {
        _schedules.add(newItem);
        // Sort by time
        _schedules.sort((a, b) => a.time.compareTo(b.time));
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('📅 Jadwal "${newItem.title}" berhasil ditambahkan!'),
          backgroundColor: const Color(0xFF10B981),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header: Icon & "Kalender"
              const Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    color: Color(0xFF3B82F6),
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Kalender',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 2. Calendar Month Card
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
                child: Column(
                  children: [
                    // Month Navigator: < Agustus 2026 >
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1E293B),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.chevron_left_rounded,
                              color: Color(0xFF94A3B8),
                              size: 20,
                            ),
                          ),
                        ),
                        const Text(
                          'Agustus 2026',
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1E293B),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.chevron_right_rounded,
                              color: Color(0xFF94A3B8),
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // Day of week labels: Sen, Sel, Rab, ...
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(7, (index) {
                        return SizedBox(
                          width: 36,
                          child: Text(
                            _dayNames[index],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 12),

                    // Dates row: 24, 25, 26, 27, 28, 29, 30
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(7, (index) {
                        final isSelected = _selectedDayIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDayIndex = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.electricBlue
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${_dates[index]}',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: isSelected
                                      ? FontWeight.w800
                                      : FontWeight.w600,
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF94A3B8),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 3. Section Date Header (e.g. "RABU, 26 AGUSTUS")
              Text(
                _selectedDateHeader,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF94A3B8),
                  letterSpacing: 0.8,
                ),
              ),

              const SizedBox(height: 16),

              // 4. Timeline Schedule Items
              ..._schedules.map((schedule) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Time Label (e.g. 08:00)
                      SizedBox(
                        width: 52,
                        child: Text(
                          schedule.time,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Schedule Content Card
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
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
                              // Dot indicator
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: schedule.categoryColor,
                                  shape: BoxShape.circle,
                                ),
                              ),

                              const SizedBox(width: 12),

                              // Title & Category
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      schedule.title,
                                      style: const TextStyle(
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        letterSpacing: -0.2,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      schedule.categoryLabel,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800,
                                        color: schedule.categoryColor,
                                        letterSpacing: 0.6,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 80), // Padding for FAB & Nav bar
            ],
          ),
        ),

        // Floating Action Button (+)
        Positioned(
          bottom: 24,
          right: 24,
          child: GestureDetector(
            onTap: _openAddSchedule,
            child: Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: AppColors.electricBlue,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.electricBlue.withValues(alpha: 0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
