import 'package:flutter/material.dart';
import '../../../data/models/mood_type.dart';

class MoodFaceWidget extends StatelessWidget {
  final MoodType mood;
  final double size;

  const MoodFaceWidget({
    super.key,
    required this.mood,
    required this.size,
  });

  Color get _faceBackgroundColor {
    switch (mood) {
      case MoodType.calm:
        return const Color(0xFFF4CDBC);
      case MoodType.content:
        return const Color(0xFFFFD363);
      case MoodType.peaceful:
        return const Color(0xFFECC29C);
      case MoodType.happy:
        return const Color(0xFFE5A182);
    }
  }

  String get _assetPath {
    switch (mood) {
      case MoodType.calm:
        return 'assets/icons/calm.png';
      case MoodType.content:
        return 'assets/icons/content.png';
      case MoodType.peaceful:
        return 'assets/icons/peaceful.png';
      case MoodType.happy:
        return 'assets/icons/happy.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * 0.16),
      decoration: BoxDecoration(
        color: _faceBackgroundColor,
        borderRadius: BorderRadius.circular(size * 0.22),
      ),
      child: Image.asset(
        _assetPath,
        fit: BoxFit.contain,
      ),
    );
  }
}
