import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
   SplashScreen({Key? key}) : super(key: key);

  final splashController = Get.put<SplashController>(SplashController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: Colors.indigo,body:
      Center(child: Container(
        height: 150,width: 150,
          alignment: Alignment.center,
          decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(color: Colors.white,width: 5)),
          child: const Text('To Do App',textAlign: TextAlign.center,style: TextStyle(fontSize:  20,fontFamily: 'Urbanist-Bold',color: Colors.white),).paddingSymmetric(horizontal: 2)),),);
  }
}
