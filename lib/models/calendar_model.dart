import 'package:flutter/material.dart';

enum ScheduleCategory {
  kelas,
  aktivitas,
  personal,
}

enum SchedulePriority {
  tinggi,
  sedang,
  rendah,
}

class CalendarScheduleItem {
  final String id;
  final String title;
  final String time;
  final String date; // e.g. "2026-08-26" or "26/08/26"
  final ScheduleCategory category;
  final SchedulePriority priority;

  const CalendarScheduleItem({
    required this.id,
    required this.title,
    required this.time,
    required this.date,
    this.category = ScheduleCategory.kelas,
    this.priority = SchedulePriority.sedang,
  });

  String get categoryLabel {
    switch (category) {
      case ScheduleCategory.kelas:
        return 'KELAS';
      case ScheduleCategory.aktivitas:
        return 'AKTIVITAS';
      case ScheduleCategory.personal:
        return 'PERSONAL';
    }
  }

  Color get categoryColor {
    switch (category) {
      case ScheduleCategory.kelas:
        return const Color(0xFF3B82F6); // Blue
      case ScheduleCategory.aktivitas:
        return const Color(0xFFF87171); // Coral / Red
      case ScheduleCategory.personal:
        return const Color(0xFF10B981); // Green
    }
  }
}
