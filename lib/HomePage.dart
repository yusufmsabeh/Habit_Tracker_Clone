import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/DB/DBConaction.dart';
import 'package:habit_tracker/Providers/DBProvider.dart';
import 'package:habit_tracker/Screens/AddHabitScreen.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import 'Screens/AllHabits.dart';
import 'Screens/TodayScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Widget CurrentLeading = Text("HabitList".tr());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: GestureDetector(
          onTap: (() {
            showDialog(
                context: context, builder: (context) => AddHabitScreen());
          }),
          child: Container(
            margin: context.locale.toString() == 'en'
                ? EdgeInsets.only(right: 290.w)
                : EdgeInsets.only(left: 250.w),
            height: 100.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ], color: Colors.white, borderRadius: BorderRadius.circular(100.r)),
            child: TextButton(
              onPressed: null,
              child: Text(
                "AddNewHabit".tr(),
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(color: Colors.black)),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    context.locale.toString() == 'ar'
                        ? context.setLocale(const Locale('en'))
                        : context.setLocale(const Locale('ar'));
                  });
                },
                icon: const Icon(
                  Icons.language,
                  color: Colors.black,
                ))
          ],
          leadingWidth: 600.w,
          leading: Provider.of<DBProvider>(context).currentIndex == 1
              ? GestureDetector(
                  onTap: () {
                    Provider.of<DBProvider>(context, listen: false)
                        .changeTableHieght();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Row(
                      children: [
                        Text(
                          "TodayList".tr(),
                          style: TextStyle(
                              color: const Color.fromARGB(255, 112, 112, 112),
                              fontWeight: FontWeight.bold,
                              fontSize: 70.sp),
                        ),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: Color.fromARGB(255, 112, 112, 112),
                        )
                      ],
                    ),
                  ),
                )
              : Container(
                  width: double.infinity,
                  margin: context.locale.toString() == 'ar'
                      ? EdgeInsets.only(top: 20.w, right: 30.w)
                      : EdgeInsets.only(top: 20.w, left: 30.w),
                  child: Text(
                    'HabitList'.tr(),
                    style: TextStyle(
                        color: const Color.fromARGB(255, 112, 112, 112),
                        fontWeight: FontWeight.bold,
                        fontSize: 60.sp),
                  )),
          backgroundColor: const Color.fromARGB(255, 240, 240, 240),
          elevation: 0,
        ),
        bottomNavigationBar: SizedBox(
          height: 150.h,
          child: Stack(children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 150.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Provider.of<DBProvider>(context, listen: false)
                          .changeCurrentIndex(0);
                      print("Changethe curreintindex");
                    },
                    child: SizedBox(
                      // width: 100.w,
                      child: Column(
                        children: [
                          SizedBox(
                              width: 70.w,
                              height: 70.h,
                              child: Image.asset(
                                  Provider.of<DBProvider>(context)
                                              .currentIndex ==
                                          0
                                      ? 'assets/menuSelected.png'
                                      : 'assets/menu.png')),
                          Text("AllHabits".tr())
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Provider.of<DBProvider>(context, listen: false)
                          .changeCurrentIndex(1);
                    },
                    child: SizedBox(
                      // width: 100.w,
                      child: Column(
                        children: [
                          SizedBox(
                              width: 70.w,
                              height: 70.h,
                              child: Image.asset(
                                  Provider.of<DBProvider>(context)
                                              .currentIndex ==
                                          1
                                      ? 'assets/todaySelected.png'
                                      : 'assets/today.png')),
                          Text("TodayList".tr())
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
        body: Container(
            color: const Color.fromARGB(255, 240, 240, 240),
            child: Provider.of<DBProvider>(context).currentIndex == 0
                ? AllHabits()
                : TodayScreen()));
  }
}
