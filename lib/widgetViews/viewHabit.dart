import 'package:flutter/material.dart';
import 'package:habitIt/objects/habit.dart';

class OpenHabit extends StatefulWidget {
  final Habit habit;
  final int index;
  final addAndUpdateHabit;

  OpenHabit({this.habit, this.index, this.addAndUpdateHabit});
  @override
  _OpenHabitState createState() =>
      _OpenHabitState(habit, index, addAndUpdateHabit);
}

class _OpenHabitState extends State<OpenHabit> {
  Habit habit;
  int index;
  final addAndUpdateHabit;

  _OpenHabitState(this.habit, this.index, this.addAndUpdateHabit);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(50),
        child: Column(
          children: <Widget>[
            Hero(
              tag: "name$index",
              child: Container(
                  child: Text(
                habit.name,
                style: TextStyle(fontSize: 50),
              )),
            ),
            Hero(
              tag: "count$index",
              child: Text(habit.days.toString()),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                addAndUpdateHabit(habit);
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
