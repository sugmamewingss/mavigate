import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/calendar_model.dart';

class AddScheduleDialog extends StatefulWidget {
  const AddScheduleDialog({super.key});

  static Future<CalendarScheduleItem?> show(BuildContext context) {
    return showDialog<CalendarScheduleItem>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.75),
      builder: (context) => const AddScheduleDialog(),
    );
  }

  @override
  State<AddScheduleDialog> createState() => _AddScheduleDialogState();
}

class _AddScheduleDialogState extends State<AddScheduleDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController =
      TextEditingController(text: '26/08/26');
  final TextEditingController _timeController =
      TextEditingController(text: '08:00');

  ScheduleCategory _selectedCategory = ScheduleCategory.kelas;
  SchedulePriority _selectedPriority = SchedulePriority.sedang;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  bool get _isValid => _titleController.text.trim().isNotEmpty;

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
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 0),
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
      setState(() {
        _timeController.text = '$hour:$minute';
      });
    }
  }

  void _handleSave() {
    if (!_isValid) return;

    final item = CalendarScheduleItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      time: _timeController.text.trim(),
      date: _dateController.text.trim(),
      category: _selectedCategory,
      priority: _selectedPriority,
    );

    Navigator.of(context).pop(item);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: const Color(0xFF131D31),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.borderDark,
            width: 1.2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Bar: Title & Close Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tambahkan Jadwal',
                  style: TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E293B),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.close_rounded,
                        color: Color(0xFF94A3B8),
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Field: Judul
            _buildInputContainer(
              child: TextField(
                controller: _titleController,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'Judul',
                  hintStyle: TextStyle(color: Color(0xFF64748B), fontSize: 13.5),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Dropdowns Row: Kategori (Kelas) & Prioritas
            Row(
              children: [
                // Kategori Dropdown
                Expanded(
                  child: _buildInputContainer(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<ScheduleCategory>(
                        value: _selectedCategory,
                        dropdownColor: const Color(0xFF131D31),
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(0xFF94A3B8),
                        ),
                        isDense: true,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        items: const [
                          DropdownMenuItem(
                            value: ScheduleCategory.kelas,
                            child: Text(
                              'Kelas',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 13.5),
                            ),
                          ),
                          DropdownMenuItem(
                            value: ScheduleCategory.aktivitas,
                            child: Text(
                              'Aktivitas',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 13.5),
                            ),
                          ),
                          DropdownMenuItem(
                            value: ScheduleCategory.personal,
                            child: Text(
                              'Personal',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 13.5),
                            ),
                          ),
                        ],
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _selectedCategory = val;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // Prioritas Dropdown
                Expanded(
                  child: _buildInputContainer(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<SchedulePriority>(
                        value: _selectedPriority,
                        dropdownColor: const Color(0xFF131D31),
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(0xFF94A3B8),
                        ),
                        isDense: true,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        items: const [
                          DropdownMenuItem(
                            value: SchedulePriority.tinggi,
                            child: Text(
                              'Tinggi',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 13.5),
                            ),
                          ),
                          DropdownMenuItem(
                            value: SchedulePriority.sedang,
                            child: Text(
                              'Prioritas',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 13.5),
                            ),
                          ),
                          DropdownMenuItem(
                            value: SchedulePriority.rendah,
                            child: Text(
                              'Rendah',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 13.5),
                            ),
                          ),
                        ],
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _selectedPriority = val;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Pickers Row: Date & Time
            Row(
              children: [
                // Date Field
                Expanded(
                  child: _buildInputContainer(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _dateController,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 13),
                            decoration: const InputDecoration(
                              hintText: '26/08/26',
                              hintStyle: TextStyle(
                                  color: Color(0xFF64748B), fontSize: 12.5),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.calendar_today_outlined,
                            size: 16,
                            color: Color(0xFF94A3B8),
                          ),
                          onPressed: _handlePickDate,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                              minWidth: 32, minHeight: 32),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // Time Field
                Expanded(
                  child: _buildInputContainer(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _timeController,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 13),
                            decoration: const InputDecoration(
                              hintText: '08:00',
                              hintStyle: TextStyle(
                                  color: Color(0xFF64748B), fontSize: 12.5),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.access_time_rounded,
                            size: 16,
                            color: Color(0xFF94A3B8),
                          ),
                          onPressed: _handlePickTime,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                              minWidth: 32, minHeight: 32),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Button: "Simpan Jadwal"
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _isValid ? _handleSave : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isValid
                      ? AppColors.electricBlue
                      : const Color(0xFF1E293B),
                  foregroundColor:
                      _isValid ? Colors.white : const Color(0xFF64748B),
                  disabledBackgroundColor: const Color(0xFF1E293B),
                  disabledForegroundColor: const Color(0xFF64748B),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Simpan Jadwal',
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
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
