class Habit {
  final int id;
  String name;
  int days;
  int objective;

  Habit({this.id, this.name, this.days = 0, this.objective});

  // Convert a habit into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'days': days,
      'objective': objective,
    };
  }

  @override
  String toString() {
    return "{" +
        this.id.toString() +
        ", " +
        this.name +
        ", " +
        this.days.toString() +
        ", " +
        this.objective.toString() +
        "}";
  }

  void addDay() {
    this.days++;
  }

  void removeDay() {
    this.days--;
  }

  void setDays(int i) {
    this.days = i;
  }
}
