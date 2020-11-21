import 'package:flutter/material.dart';
import 'package:habitIt/objects/habit.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';

Future<void> addHabitDialog(
    BuildContext context,
    var addHabit,
    TextEditingController nameController,
    TextEditingController dayController) async {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          //shape: CircleBorder(),
          child: Container(
            height: 300,
            padding: EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Text(
                    "Add Habit",
                    style: TextStyle(fontSize: 30),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: TextField(
                        autofocus: true,
                        controller: nameController,
                        textAlign: TextAlign.center,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          hintText: "Habit Name",
                        ),
                      )),
                  Container(
                      width: 150,
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 15),
                      child: TextField(
                          controller: dayController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Objective Days",
                          ))),
                  FloatingActionButton(
                    backgroundColor: Colors.deepPurpleAccent,
                    heroTag: "addButton",
                    onPressed: () {
                      addHabit(
                          nameController.text, int.parse(dayController.text));
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

void showAddCard(BuildContext context, var addHabit,
    TextEditingController nameController, TextEditingController dayController) {
  showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.8),
    transitionDuration: Duration(milliseconds: 300),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Dialog(
        elevation: 8,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          height: 300,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "Add Habit",
                style: TextStyle(fontSize: 30),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextField(
                    controller: nameController,
                    textAlign: TextAlign.center,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: "Habit name",
                    ),
                  )),
              Container(
                  width: 150,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 15),
                  child: TextField(
                      controller: dayController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "objective days",
                      ))),
              FloatingActionButton(
                backgroundColor: Colors.deepPurpleAccent,
                onPressed: () {
                  if (nameController.text != "" && dayController.text != "") {
                    addHabit(
                        nameController.text, int.parse(dayController.text));
                    Navigator.of(context).pop();
                  }
                },
                child: Icon(Icons.add),
              ),
            ],
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
  );
}

class EditHabit extends StatefulWidget {
  final habit;
  final deleteHabit;
  final editHabit;
  EditHabit(this.habit, this.deleteHabit, this.editHabit);

  @override
  _EditHabitState createState() =>
      _EditHabitState(habit, this.deleteHabit, this.editHabit);
}

class _EditHabitState extends State<EditHabit> {
  Habit habit;
  var deleteHabit;
  var editHabit;
  _EditHabitState(this.habit, this.deleteHabit, this.editHabit);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(habit.name[0].toUpperCase() + habit.name.substring(1))
        ],
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: () {
              habit.days != 0 ? habit.days-- : habit.days = 0;
              setState(() {});
            },
            icon: Icon(Icons.remove),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Text(
                habit.days.toString(),
                style: TextStyle(fontSize: 50),
              )),
          IconButton(
            onPressed: () {
              habit.days++;
              setState(() {});
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          color: Colors.red,
          child: Text("Delete Habit"),
          onPressed: () {
            deleteHabit(habit);
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          color: Colors.blue,
          child: Text("Done"),
          onPressed: () {
            editHabit(habit.days);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

Future<void> deleteHabitDialog(
    BuildContext context, Habit habit, var deleteHabit, var editDays) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return EditHabit(habit, deleteHabit, editDays);
    },
  );
}
