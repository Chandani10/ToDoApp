import 'package:get/get.dart';
import 'package:todo_app/controller/add_todo_controller.dart';
import 'package:todo_app/controller/splash_controller.dart';

class AddToDoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddToDoController>(
          () => AddToDoController(),
    );
  }
}