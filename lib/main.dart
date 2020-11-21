import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:habitIt/widgetViews/habitCard.dart';
import 'package:habitIt/widgetViews/popUp.dart';
import 'widgetViews/habitCard.dart';
import 'objects/habit.dart';
import 'databaseHelper.dart';
import 'widgetViews/headerBar.dart';
import 'widgetViews/viewHabit.dart';
import 'widgetViews/popUp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DbHelper db = DbHelper();
  List<HabitCard> listItems = [];
  List<Habit> habits;
  bool loadedHabits = false;
  double screenHeight;

  void getHabits() async {
    listItems = [];
    habits = await db.getHabits();
    habits.forEach((element) {
      listItems.add(HabitCard(
        habit: element,
        addAndUpdateHabit: addAndUpdate,
        deleteHabit: deleteHabit,
        editDays: setDays,
        key: UniqueKey(),
      ));
    });
    setState(() {});
  }

  void insertHabit(String name, int objective) async {
    int id = -1;
    if (listItems.length == 0) {
      id = 1;
    } else {
      listItems.forEach((element) {
        if (element.habit.id > id) {
          id = element.habit.id;
        }
      });
    }

    Habit h = Habit(id: id + 1, name: name, days: 0, objective: objective);
    db.insertHabit(h);
    listItems.insert(
        0,
        HabitCard(
          habit: h,
          addAndUpdateHabit: addAndUpdate,
          deleteHabit: deleteHabit,
          key: UniqueKey(),
          editDays: setDays,
        ));
    setState(() {});
  }

  void deleteHabit(Habit h) async {
    db.deleteHabit(h);
    listItems.removeWhere((element) => element.habit == h);
    setState(() {});
  }

  void addAndUpdate(Habit habit) {
    habit.addDay();
    db.updateHabit(habit);
  }

  void setDays(Habit habit) {
    db.updateHabit(habit);
  }

  @override
  Widget build(BuildContext context) {
    //resetHabits(db);
    screenHeight = MediaQuery.of(context).size.height;
    if (!loadedHabits) {
      getHabits();
      loadedHabits = true;
    }

    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.purple[100]])),
        child: Stack(children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              Header(screenHeight / 9),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) => listItems[index],
                      childCount: listItems.length)),
            ],
          ),
          SizedBox(
              width: 500,
              height: 75,
              child: FlareActor(
                'assets/addpop.flr2d',
                animation: 'Loading',
                fit: BoxFit.fitWidth,
              )),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              heroTag: "addButton",
              backgroundColor: Colors.deepPurpleAccent,
              onPressed: () {
                TextEditingController habitName = new TextEditingController();
                TextEditingController habitObjective =
                    new TextEditingController();
                showAddCard(context, insertHabit, habitName, habitObjective);
              },
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
        ]));
  }

  void openHabit(Habit h, int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OpenHabit(
                  habit: h,
                  index: index,
                  addAndUpdateHabit: addAndUpdate,
                )));
  }

  void resetHabits(DbHelper db) {
    for (int i = 0; i < 20; i++) {
      Habit h = Habit(
          id: i,
          name: "habit #" + i.toString(),
          days: 0,
          objective: 18 + i - 2 * i);
      db.insertHabit(h);
    }
  }
}
