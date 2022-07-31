import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:habit_tracker/DB/DBConaction.dart';
import 'package:habit_tracker/model/habit.dart';

class DBProvider extends ChangeNotifier {
  List<Habit> allHabits = [];
  List<Habit> todayHabits = [];
  DateTime dateTime = DateTime.now();

  DBProvider() {
    selectAllHabits();
  }
  fillHabits(List<Habit> allHabits, List<Habit> todayHabits) {
    this.todayHabits = todayHabits;
    this.allHabits = allHabits;

    notifyListeners();
  }

  changeDateTime(DateTime dateTime) {
    this.dateTime = dateTime;
    notifyListeners();
    selectAllHabits();
  }

  createHabit(Habit habit, var day) async {
    await connection.instance.insertHabit(habit, day);
    selectAllHabits();
  }

  selectAllHabits() async {
    todayHabits = await connection.instance.realAllHaibtsByDay(dateTime);
    allHabits = await connection.instance.readAllHabits();

    fillHabits(allHabits, todayHabits);
  }

  updateHabit(Habit habit, var days) async {
    await connection.instance.updateHabit(habit, days);
    selectAllHabits();
  }

  deleteHabit(int id) async {
    await connection.instance.deleteHabit(id);
    selectAllHabits();
  }

  updateDone(int id) async {
    await connection.instance.updateDone(id);
    selectAllHabits();
  }

  readHabitById(int id) async {
    return await connection.instance.realHabitById(id);
  }

  getHabitDays(int id) async {
    return await connection.instance.getHabitDays(id);
  }
}
