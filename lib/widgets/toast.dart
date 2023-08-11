
import 'package:flutter/material.dart';
import 'package:get/get.dart';

toastFunction({String message = ''}){
  return  Get.showSnackbar( GetSnackBar(
    backgroundColor: Colors.white,messageText: Text(message,style:
  const TextStyle(color: Colors.deepPurple,fontSize: 18),),
    duration: const Duration(seconds: 3),snackPosition: SnackPosition.TOP,));
}