import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/journey_model.dart';
import '../../widgets/cards/journey_focus_card.dart';
import '../../widgets/cards/journey_hero_card.dart';
import '../../widgets/cards/sub_journey_card.dart';
import 'calender_mission_screen.dart';
import 'sub_journey_mission_screen.dart';

class JourneyScreen extends StatefulWidget {
  final VoidCallback? onResetWeekly;

  const JourneyScreen({
    super.key,
    this.onResetWeekly,
  });

  @override
  State<JourneyScreen> createState() => _JourneyScreenState();
}

class _JourneyScreenState extends State<JourneyScreen> {
  int _selectedJourneyUnit = 0; // 0: Journey 1, 1: Journey 2, 2: Journey 3

  // Sub-Journey Items State
  late List<SubJourneyItem> _subJourneys;

  @override
  void initState() {
    super.initState();
    _initSubJourneys();
  }

  void _initSubJourneys() {
    _subJourneys = [
      const SubJourneyItem(
        id: 'orientation',
        stepNumber: '1.1',
        title: 'Orientation',
        description: 'Kenali beberapa hal mengenai dunia perkuliahan.',
        status: SubJourneyStatus.active,
        progress: 0.0,
      ),
      const SubJourneyItem(
        id: 'calender',
        stepNumber: '1.2',
        title: 'Calender',
        description: 'Atur aktivitas pentingmu di kalender.',
        status: SubJourneyStatus.locked,
        progress: 0.0,
      ),
      const SubJourneyItem(
        id: 'goals',
        stepNumber: '1.3',
        title: 'Goals',
        description: 'Tentukan satu tujuan yang ingin kamu mulai kejar.',
        status: SubJourneyStatus.locked,
        progress: 0.0,
      ),
    ];
  }

  int get _journeyPercentage {
    final orientationDone = _subJourneys[0].status == SubJourneyStatus.completed;
    final calenderDone = _subJourneys[1].status == SubJourneyStatus.completed;
    final goalsDone = _subJourneys[2].status == SubJourneyStatus.completed;

    if (goalsDone) return 100;
    if (calenderDone) return 80;
    if (orientationDone) return 40;
    return 0;
  }

  double get _journeyProgressValue => _journeyPercentage / 100.0;

  SubJourneyItem get _currentFocusItem {
    for (final item in _subJourneys) {
      if (item.status == SubJourneyStatus.active) {
        return item;
      }
    }
    // If all completed, return last
    return _subJourneys.last;
  }

  bool get _isAllCompleted {
    return _subJourneys.every((item) => item.status == SubJourneyStatus.completed);
  }

  void _openMission(SubJourneyItem item) async {
    if (item.status == SubJourneyStatus.locked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${item.title} masih terkunci. Selesaikan misi sebelumnya! 🔒'),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (item.id == 'calender') {
      final result = await Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder: (context) => CalenderMissionScreen(
            onMissionCompleted: () {
              _markMissionCompleted('calender');
            },
          ),
        ),
      );

      if (result == true && mounted) {
        _markMissionCompleted('calender');
      }
      return;
    }

    List<MissionStepData> missionSteps;

    if (item.id == 'orientation') {
      missionSteps = const [
        MissionStepData(
          topic: 'Jadwal',
          title: 'Kenali Dunia Perkuliahan',
          description:
              'Pelajari fungsi Jadwal dan bagaimana informasi ini membantu kamu mengetahui waktu perkuliahan.',
        ),
        MissionStepData(
          topic: 'KRS',
          title: 'Kenali Dunia Perkuliahan',
          description:
              'Pelajari fungsi KRS dan bagaimana informasi ini membantu kamu mengetahui waktu perkuliahan.',
        ),
        MissionStepData(
          topic: 'SKS',
          title: 'Kenali Dunia Perkuliahan',
          description:
              'Pelajari fungsi SKS dan bagaimana informasi ini membantu kamu mengetahui waktu perkuliahan.',
        ),
        MissionStepData(
          topic: 'SIAM',
          title: 'Kenali Dunia Perkuliahan',
          description:
              'Pelajari fungsi SIAM dan bagaimana informasi ini membantu kamu mengetahui waktu perkuliahan.',
        ),
        MissionStepData(
          topic: 'Gapura',
          title: 'Kenali Dunia Perkuliahan',
          description:
              'Pelajari fungsi Gapura dan bagaimana informasi ini membantu kamu mengetahui waktu perkuliahan.',
        ),
        MissionStepData(
          topic: 'Brone',
          title: 'Kenali Dunia Perkuliahan',
          description:
              'Pelajari fungsi Brone dan bagaimana informasi ini membantu kamu mengetahui waktu perkuliahan.',
        ),
        MissionStepData(
          topic: 'Pusat Layanan Akademik & Halo FILKOM',
          title: 'Kenali Dunia Perkuliahan',
          description:
              'Pelajari fungsi Pusat Layanan Akademik & Halo FILKOM dan bagaimana informasi ini membantu kamu mengetahui waktu perkuliahan.',
        ),
      ];
    } else {
      missionSteps = const [
        MissionStepData(
          topic: 'Target Akademik',
          title: 'Menentukan Arah Kuliah',
          description:
              'Tentukan target IPK dan keahlian spesifik yang ingin kamu kuasai selama semester ini.',
        ),
        MissionStepData(
          topic: 'Action Plan',
          title: 'Menentukan Arah Kuliah',
          description:
              'Buat langkah konkret mingguan untuk mencapai tujuan akademik dan pengembangan dirimu.',
        ),
      ];
    }

    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => SubJourneyMissionScreen(
          missionTitle: item.id == 'orientation'
              ? 'Kenali Dunia Perkuliahan'
              : 'Misi ${item.title}',
          missionSubtitle: item.id == 'orientation'
              ? '7 hal yang perlu kamu kenal sebagai MABA.'
              : 'Langkah terstruktur menuju kesuksesan akademik.',
          subJourneyCode: item.stepNumber,
          steps: missionSteps,
          onMissionCompleted: () {
            _markMissionCompleted(item.id);
          },
        ),
      ),
    );

    if (result == true && mounted) {
      _markMissionCompleted(item.id);
    }
  }

  void _markMissionCompleted(String missionId) {
    setState(() {
      if (missionId == 'orientation') {
        _subJourneys[0] = _subJourneys[0].copyWith(
          status: SubJourneyStatus.completed,
          progress: 1.0,
        );
        // Unlock next (Calender)
        if (_subJourneys[1].status == SubJourneyStatus.locked) {
          _subJourneys[1] = _subJourneys[1].copyWith(
            status: SubJourneyStatus.active,
            progress: 0.25,
          );
        }
      } else if (missionId == 'calender') {
        _subJourneys[1] = _subJourneys[1].copyWith(
          status: SubJourneyStatus.completed,
          progress: 1.0,
        );
        // Unlock next (Goals)
        if (_subJourneys[2].status == SubJourneyStatus.locked) {
          _subJourneys[2] = _subJourneys[2].copyWith(
            status: SubJourneyStatus.active,
            progress: 0.30,
          );
        }
      } else if (missionId == 'goals') {
        _subJourneys[2] = _subJourneys[2].copyWith(
          status: SubJourneyStatus.completed,
          progress: 1.0,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final focusItem = _currentFocusItem;
    final isAllDone = _isAllCompleted;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header Row (Journey Title & Weekly Reset Button)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Journey',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.4,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Perjalananmu, langkah demi langkah',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondaryDark,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Weekly Reset Pill Button
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('✨ Progress mingguan diperbarui!'),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF334155),
                      width: 1,
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.auto_awesome_rounded,
                        size: 13,
                        color: Color(0xFF60A5FA),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Weekly Reset',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF60A5FA),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // 2. Journey Unit Tabs Row [Journey 1 (Active)] [Journey 2] [Journey 3]
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _buildJourneyUnitTab(0, 'Journey 1'),
                const SizedBox(width: 10),
                _buildJourneyUnitTab(1, 'Journey 2'),
                const SizedBox(width: 10),
                _buildJourneyUnitTab(2, 'Journey 3'),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 3. Card Hero: HALO MABA Journey
          JourneyHeroCard(
            title: 'HALO MABA Journey',
            description:
                'Panduan langkah demi langkah untuk beradaptasi dan sukses di dunia perkuliahan.',
            percentage: _journeyPercentage,
            progress: _journeyProgressValue,
          ),

          const SizedBox(height: 24),

          // 4. Section: FOKUS SAAT INI
          const Text(
            'FOKUS SAAT INI',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 12),

          JourneyFocusCard(
            title: isAllDone ? 'Semua Misi Selesai 🎉' : focusItem.title,
            description: isAllDone
                ? 'Luar biasa! Kamu telah menyelesaikan seluruh rangkaian misi Journey 1.'
                : focusItem.description,
            isAllCompleted: isAllDone,
            onContinue: () => _openMission(focusItem),
          ),

          const SizedBox(height: 24),

          // 5. Section: SUB-JOURNEY
          const Text(
            'SUB-JOURNEY',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 12),

          // Sub-Journey Items List
          ..._subJourneys.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: SubJourneyCard(
                item: item,
                onContinue: () => _openMission(item),
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildJourneyUnitTab(int index, String label) {
    final isSelected = _selectedJourneyUnit == index;

    return GestureDetector(
      onTap: () {
        if (index > 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$label masih terkunci. Selesaikan Journey 1 dahulu! 🔒'),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 1),
            ),
          );
        } else {
          setState(() {
            _selectedJourneyUnit = index;
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.electricBlue : AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.electricBlue : AppColors.borderDark,
            width: 1.2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF94A3B8),
          ),
        ),
      ),
    );
  }
}
