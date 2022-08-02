import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/DB/DBConaction.dart';
import 'package:habit_tracker/Providers/DBProvider.dart';
import 'package:habit_tracker/Widgets.dart/HabitWidget.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AllHabits extends StatefulWidget {
  @override
  State<AllHabits> createState() => _AllHabitsState();
}

class _AllHabitsState extends State<AllHabits> {
  @override
  Widget build(BuildContext context) {
    return Provider.of<DBProvider>(context).allHabits.isEmpty
        ? Center(child: Lottie.asset('assets/animations/empty.json'))
        : Container(
            margin: EdgeInsets.symmetric(horizontal: 40.w),
            child: ListView.builder(
                itemCount: Provider.of<DBProvider>(context).allHabits.length,
                itemBuilder: ((context, index) => HabitWidget(
                      habit: Provider.of<DBProvider>(context).allHabits[index],
                    ))));
  }
}
