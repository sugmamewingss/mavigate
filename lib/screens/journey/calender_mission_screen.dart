import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/dialogs/sub_journey_completion_dialog.dart';
import '../../widgets/navigation/custom_bottom_nav_bar.dart';

class AddedActivityItem {
  final String title;
  final String date;
  final String time;

  const AddedActivityItem({
    required this.title,
    required this.date,
    required this.time,
  });
}

class CalenderMissionScreen extends StatefulWidget {
  final VoidCallback? onMissionCompleted;

  const CalenderMissionScreen({
    super.key,
    this.onMissionCompleted,
  });

  @override
  State<CalenderMissionScreen> createState() => _CalenderMissionScreenState();
}

class _CalenderMissionScreenState extends State<CalenderMissionScreen> {
  final TextEditingController _activityController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  final List<AddedActivityItem> _addedActivities = [];

  @override
  void initState() {
    super.initState();
    _activityController.addListener(_onFormChanged);
    _dateController.addListener(_onFormChanged);
    _timeController.addListener(_onFormChanged);
  }

  void _onFormChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _activityController.removeListener(_onFormChanged);
    _dateController.removeListener(_onFormChanged);
    _timeController.removeListener(_onFormChanged);
    _activityController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  bool get _isFormValid {
    return _activityController.text.trim().isNotEmpty &&
        _dateController.text.trim().isNotEmpty &&
        _timeController.text.trim().isNotEmpty;
  }

  bool get _hasAddedActivities => _addedActivities.isNotEmpty;

  void _handleAddActivity() {
    if (!_isFormValid) return;

    final title = _activityController.text.trim();
    final date = _dateController.text.trim();
    final time = _timeController.text.trim();

    setState(() {
      _addedActivities.add(
        AddedActivityItem(
          title: title,
          date: date,
          time: time,
        ),
      );
    });

    FocusScope.of(context).unfocus();
  }

  void _handlePickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.electricBlue,
              surface: Color(0xFF131D31),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final day = picked.day.toString().padLeft(2, '0');
      final month = picked.month.toString().padLeft(2, '0');
      final year = picked.year.toString().substring(2);
      setState(() {
        _dateController.text = '$day/$month/$year';
      });
    }
  }

  void _handlePickTime() async {
    final now = TimeOfDay.now();
    final picked = await showTimePicker(
      context: context,
      initialTime: now,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.electricBlue,
              surface: Color(0xFF131D31),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final hour = picked.hour.toString().padLeft(2, '0');
      final minute = picked.minute.toString().padLeft(2, '0');
      // Default duration 1 hour 40 mins
      final endHour = ((picked.hour + 1) % 24).toString().padLeft(2, '0');
      final endMinute = ((picked.minute + 40) % 60).toString().padLeft(2, '0');
      setState(() {
        _timeController.text = '$hour.$minute - $endHour.$endMinute';
      });
    }
  }

  void _handleFinish() async {
    if (!_hasAddedActivities) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Silakan tambahkan minimal 1 aktivitas ke kalender!'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
      return;
    }

    final confirmed = await SubJourneyCompletionDialog.show(
      context,
      title: 'Sub-Journey 1.2 selesai! 🎉',
      description:
          'Kalendermu sudah mulai terisi. Sekarang kamu punya gambaran yang lebih jelas tentang waktumu.',
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
                  // 1. Top Bar: Back Button & Title "Siapkan Kalender"
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
                        'Siapkan Kalender',
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
                    'Siapkan Kalender',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.4,
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    'Mulai masukkan aktivitas pentingmu ke kalender.',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondaryDark,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 3. Form Card ("Tambahkan aktivitasmu")
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
                            // Card Header: Calendar Icon & "Tambahkan aktivitasmu"
                            const Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_rounded,
                                  size: 18,
                                  color: Color(0xFF60A5FA),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Tambahkan aktivitasmu',
                                  style: TextStyle(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 18),

                            // Field 1: Activity
                            const Text(
                              'Activity',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF94A3B8),
                              ),
                            ),
                            const SizedBox(height: 6),
                            _buildInputContainer(
                              child: TextField(
                                controller: _activityController,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                decoration: const InputDecoration(
                                  hintText: 'Isi aktivitasmu',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF64748B),
                                    fontSize: 13.5,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 14),

                            // Fields Row: Date & Time
                            Row(
                              children: [
                                // Date Field
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Date',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF94A3B8),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      _buildInputContainer(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextField(
                                                controller: _dateController,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13.5,
                                                ),
                                                decoration: const InputDecoration(
                                                  hintText: '27/08/26',
                                                  hintStyle: TextStyle(
                                                    color: Color(0xFF64748B),
                                                    fontSize: 13,
                                                  ),
                                                  border: InputBorder.none,
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                    horizontal: 14,
                                                    vertical: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.calendar_today_outlined,
                                                size: 18,
                                                color: Color(0xFF64748B),
                                              ),
                                              onPressed: _handlePickDate,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: 12),

                                // Time Field
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Time',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF94A3B8),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      _buildInputContainer(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextField(
                                                controller: _timeController,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13.5,
                                                ),
                                                decoration: const InputDecoration(
                                                  hintText: '13.00 - 14.40',
                                                  hintStyle: TextStyle(
                                                    color: Color(0xFF64748B),
                                                    fontSize: 13,
                                                  ),
                                                  border: InputBorder.none,
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                    horizontal: 14,
                                                    vertical: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.access_time_rounded,
                                                size: 18,
                                                color: Color(0xFF64748B),
                                              ),
                                              onPressed: _handlePickTime,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // Button: "Tambahkan ke Kalender"
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: _isFormValid ? _handleAddActivity : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isFormValid
                                      ? AppColors.electricBlue
                                      : const Color(0xFF1E293B),
                                  foregroundColor: _isFormValid
                                      ? Colors.white
                                      : const Color(0xFF64748B),
                                  disabledBackgroundColor: const Color(0xFF1E293B),
                                  disabledForegroundColor: const Color(0xFF64748B),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    side: BorderSide(
                                      color: _isFormValid
                                          ? AppColors.electricBlue
                                          : const Color(0xFF334155),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'Tambahkan ke Kalender',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),

                            // Added Activity Notification Card
                            if (_hasAddedActivities) ...[
                              const SizedBox(height: 18),
                              ..._addedActivities.map(
                                (item) => Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 14,
                                  ),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF13222D),
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: const Color(0xFF064E3B),
                                      width: 1.2,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.title,
                                              style: const TextStyle(
                                                fontSize: 13.5,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              '${item.date} • ${item.time}',
                                              style: const TextStyle(
                                                fontSize: 11.5,
                                                color: Color(0xFF94A3B8),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.check_rounded,
                                            size: 16,
                                            color: Color(0xFF10B981),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            'Ditambahkan',
                                            style: TextStyle(
                                              fontSize: 11.5,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFF10B981),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
                      onPressed: _hasAddedActivities ? _handleFinish : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _hasAddedActivities
                            ? const Color(0xFF10B981)
                            : const Color(0xFF1E293B),
                        foregroundColor: _hasAddedActivities
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

  Widget _buildInputContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1E293B),
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
