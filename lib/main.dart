import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/models/workout.dart';
import 'package:hive_test/test_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WorkoutAdapter());
  await Hive.openBox<Workout>('lol');

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: TestScreen()));
}
