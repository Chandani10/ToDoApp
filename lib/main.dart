import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/view/home_screen.dart';
import 'package:todo_app/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home:  SplashScreen(),
    );
  }
}
