// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/models/workout.dart';
import 'package:hive_test/widgets/card.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late Box box;
  String tit = '';
  final name = TextEditingController();
  final number = TextEditingController();

  List<Workout> workout = [];

  @override
  void dispose() {
    name.dispose();
    number.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    box = Hive.box<Workout>('lol');

    workout = box.values.cast<Workout>().toList();
  }

  void makeNew() {
    //workout.insert(0, Workout(number: number.text, title: name.text));
    final newWorkout = Workout(number: number.text, title: name.text);
    setState(() {
      workout.insert(0, newWorkout);
      // box.putAt(0, newWorkout); // Not ideal — use add instead
      box.add(newWorkout); // appends, but we can reverse display
    });
  }

  void addWorkOut() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        final screenHeight = MediaQuery.of(context).size.height;
        // final topPadding = MediaQuery.of(
        //     context,
        //   ).padding.top; // height of notification area
        return Container(
          height: MediaQuery.of(context).size.height,
          color: Color(0xFF0E0E10),
          child: Padding(
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
              top: screenHeight - 700,
            ),
            child: Column(
              children: [
                TextField(
                  controller: name,
                  style: TextStyle(color: Colors.white),
                  maxLength: 30,
                  decoration: InputDecoration(
                    label: Text(
                      'Workout',
                      style: TextStyle(color: Colors.white),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: number,
                  style: TextStyle(color: Colors.white),
                  maxLength: 30,
                  decoration: InputDecoration(
                    label: Text(
                      'Weight in kg',
                      style: TextStyle(color: Colors.white),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                Container(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      print(name.text);
                      print(number.text);
                      Navigator.of(context).pop();
                      setState(() {
                        makeNew();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(12),
                      ),
                    ),
                    child: Text('Add'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = Scaffold(
      backgroundColor: Color(0xFF0E0E10),
      appBar: AppBar(
        backgroundColor: Color(0xFF0E0E10),
        title: Text("GYM", style: TextStyle(color: Colors.white)),
        actions: [IconButton(onPressed: addWorkOut, icon: Icon(Icons.add))],
      ),

      body: Center(
        child: ListView.builder(
          itemCount: workout.length,
          itemBuilder: (ctx, index) => Dismissible(
            key: ValueKey(workout[index].title),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                box.deleteAt(index);
                workout.removeAt(index);
              });
            },
            background: Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerRight,
              child: Icon(Icons.delete, color: Colors.white),
            ),
            child: Cardd(workkout: workout, index: index),
          ),
        ),
      ),
    );

    if (workout.isEmpty) {
      activeScreen = Scaffold(
        backgroundColor: Color(0xFF0E0E10),
        appBar: AppBar(
          backgroundColor: Color(0xFF0E0E10),
          title: Text("GYM", style: TextStyle(color: Colors.white)),
          actions: [IconButton(onPressed: addWorkOut, icon: Icon(Icons.add))],
        ),
        body: Center(
          child: Text(
            'Try adding Workout',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    return activeScreen;
  }
}
