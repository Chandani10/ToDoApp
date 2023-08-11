
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:todo_app/view/home_screen.dart';

class SplashController extends GetxController  {

  @override
  void onInit() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    _navigateToNextScreen();
    super.onInit();
  }

 void _navigateToNextScreen() => Timer(const Duration(seconds: 5), () async {
    Get.offAll(()=>HomePage());
      });


}
