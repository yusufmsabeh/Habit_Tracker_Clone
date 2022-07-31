import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/DB/DBConaction.dart';
import 'package:habit_tracker/Providers/DBProvider.dart';
import 'package:habit_tracker/Screens/EmptyHabitScreen.dart';
// import 'package:habit_tracker/Widgets.dart/LoadingSpinner.dart';
import 'package:habit_tracker/Widgets.dart/TodayHabit.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class TodayScreen extends StatefulWidget {
  DateTime dateTime;

  double todayHieght;
  TodayScreen(this.todayHieght, this.dateTime);

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Provider.of<DBProvider>(context).todayHabits.isEmpty
            ? const EmptyHabitScreen()
            : ListView.builder(
                itemCount: Provider.of<DBProvider>(context).todayHabits.length,
                itemBuilder: (context, index) {
                  return TodayHabit(
                    habit: Provider.of<DBProvider>(context).todayHabits[index],
                  );
                }),
        AnimatedContainer(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 240, 240, 240),
            ),
            height: widget.todayHieght,
            duration: const Duration(milliseconds: 500),
            child: SingleChildScrollView(
                child: TableCalendar(
              selectedDayPredicate: (day) => isSameDay(day, widget.dateTime),
              calendarStyle:
                  const CalendarStyle(rangeHighlightColor: Colors.red),
              rowHeight: 100.h,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
            )))
      ],
    );
  }
}
