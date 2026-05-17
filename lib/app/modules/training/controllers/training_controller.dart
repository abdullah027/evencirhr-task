import 'package:get/get.dart';
import '../../../data/models/workout.dart';

class TrainingController extends GetxController {
  final workouts = <Workout>[
    Workout(id: '1', name: 'Arm Blaster', category: 'Arms Workout', duration: '25m - 30m', date: DateTime.now()),
    Workout(id: '2', name: 'Leg Day Blitz', category: 'Leg Workout', duration: '25m - 30m', date: DateTime.now()),
  ].obs;

  // Reactively track workouts mapped to specific day numbers for Week 1
  final week1Workouts = <String, String?>{
    '8': '1',
    '9': null,
    '10': null,
    '11': '2',
    '12': null,
    '13': null,
    '14': null,
  }.obs;

  // Reactively track workouts mapped to specific day numbers for Week 2
  final week2Workouts = <String, String?>{
    '15': null,
    '16': null,
    '17': null,
    '18': null,
    '19': null,
    '20': null,
    '21': null,
  }.obs;

  // Moves a workout reactively from one day identifier to another
  void moveWorkout(String workoutId, String fromDay, String toDay) {
    if (week1Workouts.containsKey(fromDay)) {
      week1Workouts[fromDay] = null;
    } else if (week2Workouts.containsKey(fromDay)) {
      week2Workouts[fromDay] = null;
    }

    if (week1Workouts.containsKey(toDay)) {
      week1Workouts[toDay] = workoutId;
    } else if (week2Workouts.containsKey(toDay)) {
      week2Workouts[toDay] = workoutId;
    }
  }
}
