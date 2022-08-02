import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:habit_tracker/DB/DBConaction.dart';
import 'package:habit_tracker/Providers/DBProvider.dart';
import 'package:habit_tracker/Screens/CongratsScreen.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:provider/provider.dart';

class TodayHabit extends StatelessWidget {
  Habit habit;

  TodayHabit({required this.habit, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double habitPrograss = (habit.done! / habit.target) * 100;
    String path = habit.badge;

    return InkWell(
      onTap: () async {
        Provider.of<DBProvider>(context, listen: false).updateDone(habit.id!);
        if (habit.done! >= habit.target - 1) {
          Provider.of<DBProvider>(context, listen: false)
              .deleteHabit(habit.id!);
          showDialog(
              context: context,
              builder: (context) => CongratsScreen(
                    habitName: habit.name,
                  ));
        }
        Fluttertoast.showToast(
          msg: 'YouMadeProgress'.tr(),
          toastLength: Toast.LENGTH_SHORT, // length
          gravity: ToastGravity.BOTTOM, // location
          // duration
        );
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text("YouMadeProgress".tr())));

        // function();
      },
      child: Expanded(
        child: Container(
          margin: EdgeInsets.all(40.w),
          padding: EdgeInsets.all(40.w),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(60.r)),
          width: double.infinity,
          // height: 300.h,
          child: Row(children: [
            Container(
              margin: context.locale.toString() == 'en'
                  ? EdgeInsets.only(right: 40.w)
                  : EdgeInsets.only(left: 40.w),
              width: 350.w,
              height: 350.h,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(habit.badge), fit: BoxFit.contain)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 500.w,
                  child: Text(
                    habit.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 80.sp,
                        overflow: TextOverflow.fade),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: 500.w,
                  child: Text(
                    'Preogresss'.tr() + ': ${habitPrograss.floor()} %',
                    textAlign: context.locale.toString() == 'en'
                        ? TextAlign.left
                        : TextAlign.right,
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
