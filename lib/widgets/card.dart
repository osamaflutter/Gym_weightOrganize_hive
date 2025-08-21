import 'package:flutter/material.dart';
import 'package:hive_test/models/workout.dart';

class Cardd extends StatelessWidget {
  const Cardd({super.key, required this.workkout, required this.index});
  final List<Workout> workkout;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            //height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF1A1A1D), //Colors.blueGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workkout[index].title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        workkout[index].number.toString(),
                        style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Kg',
                        style: TextStyle(
                          color: Color(0xFFB0B0B0),
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
