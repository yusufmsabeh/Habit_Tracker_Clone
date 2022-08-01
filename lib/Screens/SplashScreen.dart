import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/HomePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 400.w,
              height: 400.h,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage('assets/logo.png')))),
          Text(
            'Daily',
            style: GoogleFonts.kaiseiOpti(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 100.sp,
                    color: Color.fromARGB(255, 53, 175, 190))),
          )
        ],
      )),
    );
  }
}
