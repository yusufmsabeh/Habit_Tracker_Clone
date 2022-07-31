import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:habit_tracker/DB/DBConaction.dart';
import 'package:habit_tracker/model/habit.dart';

class DBProvider extends ChangeNotifier {
  List<Habit> allHabits = [];
  List<Habit> todayHabits = [];

  DBProvider() {
    selectAllHabits();
  }
  fillHabits(List<Habit> allHabits, List<Habit> todayHabits) {
    this.allHabits = allHabits;
    this.todayHabits = todayHabits;
    notifyListeners();
  }

  fillSpecDay(List<Habit> specDayHabits) {
    this.todayHabits = specDayHabits;
    notifyListeners();
  }

  createHabit(Habit habit, var day) async {
    await connection.instance.insertHabit(habit, day);
    selectAllHabits();
  }

  selectAllHabits() async {
    allHabits = await connection.instance.readAllHabits();
    todayHabits = await connection.instance.realAllHaibtsByDay();
    fillHabits(allHabits, todayHabits);
  }

  selectSpcDay(var dateTime) async {
    List<Habit> specDayHabits =
        await connection.instance.realAllHaibtsBySpecDay(dateTime);
    fillSpecDay(specDayHabits);
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
