// class Workout {
//   Workout({required this.number, required this.title});
//   final String title;
//   final String number;
// }

import 'package:hive/hive.dart';

part 'workout.g.dart';

@HiveType(typeId: 0)
class Workout extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String number;

  Workout({required this.title, required this.number});
}
