import 'package:flutter/material.dart';

enum MoodType {
  calm,
  content,
  peaceful,
  happy,
}

class MoodData {
  final String label;
  final String emoji;
  final Color color;

  MoodData({required this.label, required this.emoji, required this.color});

  static Map<MoodType, MoodData> get all => {
    MoodType.calm: MoodData(label: "Calm", emoji: "😊", color: const Color(0xFFA6E3FF)),
    MoodType.content: MoodData(label: "Content", emoji: "😆", color: const Color(0xFFFFE1A8)),
    MoodType.peaceful: MoodData(label: "Peaceful", emoji: "🙂", color: const Color(0xFFFFB2A6)),
    MoodType.happy: MoodData(label: "Happy", emoji: "😁", color: const Color(0xFFD7FE65)),
  };
}
