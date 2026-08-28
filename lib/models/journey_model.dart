enum SubJourneyStatus { locked, active, completed }

class SubJourneyItem {
  final String id;
  final String stepNumber;
  final String title;
  final String description;
  final SubJourneyStatus status;
  final double progress; // 0.0 to 1.0
  final int totalSteps;
  final int completedSteps;

  const SubJourneyItem({
    required this.id,
    required this.stepNumber,
    required this.title,
    required this.description,
    required this.status,
    this.progress = 0.0,
    this.totalSteps = 7,
    this.completedSteps = 0,
  });

  SubJourneyItem copyWith({
    String? id,
    String? stepNumber,
    String? title,
    String? description,
    SubJourneyStatus? status,
    double? progress,
    int? totalSteps,
    int? completedSteps,
  }) {
    return SubJourneyItem(
      id: id ?? this.id,
      stepNumber: stepNumber ?? this.stepNumber,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      totalSteps: totalSteps ?? this.totalSteps,
      completedSteps: completedSteps ?? this.completedSteps,
    );
  }
}

class MissionStepData {
  final String topic;
  final String title;
  final String description;
  final String? imageAsset;
  final String? iconName;

  const MissionStepData({
    required this.topic,
    required this.title,
    required this.description,
    this.imageAsset,
    this.iconName,
  });
}
