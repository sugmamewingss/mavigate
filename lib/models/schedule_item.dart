class ScheduleItem {
  final String id;
  final String courseName;
  final String day;
  final String time;

  const ScheduleItem({
    required this.id,
    required this.courseName,
    required this.day,
    required this.time,
  });

  ScheduleItem copyWith({
    String? id,
    String? courseName,
    String? day,
    String? time,
  }) {
    return ScheduleItem(
      id: id ?? this.id,
      courseName: courseName ?? this.courseName,
      day: day ?? this.day,
      time: time ?? this.time,
    );
  }
}
