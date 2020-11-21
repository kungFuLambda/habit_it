import 'package:flutter/material.dart';
import 'package:habitIt/widgetViews/popUp.dart';
import '../objects/habit.dart';

class HabitCard extends StatefulWidget {
  Habit habit;
  final addAndUpdateHabit;
  final deleteHabit;
  final editDays;

  Key key;

  int getId() {
    return habit.id;
  }

  int index;
  HabitCard({
    this.habit,
    this.addAndUpdateHabit,
    this.key,
    this.deleteHabit,
    this.editDays,
  });
  @override
  _StatefulHabitState createState() => _StatefulHabitState(
      habit, addAndUpdateHabit, this.deleteHabit, this.editDays, key);
}

class _StatefulHabitState extends State<HabitCard> {
  Habit habit;
  var updateHabitFunction;
  var openHabit;
  var deleteHabit;
  var editDays;
  Key key;
  _StatefulHabitState(this.habit, this.updateHabitFunction, this.deleteHabit,
      this.editDays, this.key);

  void changeDays(int days) {
    this.habit.setDays(days);
    editDays(this.habit);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5.0,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        height: 75,
        child: InkWell(
          splashColor: Colors.deepPurpleAccent,
          onLongPress: () {
            deleteHabitDialog(context, habit, deleteHabit, changeDays);
          },
          onTap: () => null, //openHabit(habit, index),
          child: Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      habit.name[0].toUpperCase() + habit.name.substring(1),
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          habit.days.toString() + " days",
                          style: TextStyle(fontSize: 22),
                        ),
                        if (habit.days >= habit.objective) ...[
                          Text("Now it's a habit!"),
                        ] else ...[
                          Text((habit.objective - habit.days).toString() +
                              " left"),
                        ]
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.purple, shape: BoxShape.circle),
                    child: IconButton(
                      splashColor: Colors.purpleAccent,
                      icon: Icon(Icons.add),
                      onPressed: () {
                        updateHabitFunction(habit);
                        setState(() {});
                      },
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
