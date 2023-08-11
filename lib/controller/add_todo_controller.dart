import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/task_controller.dart';
import 'package:todo_app/database/database_helper.dart';
import 'package:todo_app/model/task_data.dart';
import 'package:todo_app/view/home_screen.dart';

class AddToDoController extends GetxController {
  TaskData? editTaskData ;
  RxList <String>priorities = ["High", "Medium", "Low"].obs;
  TextEditingController? titleController ;
  TextEditingController? descriptionController;
  TextEditingController? dueDateController ;
  DatabaseHelper database = DatabaseHelper();
  RxInt priorityLevel = 1.obs;
  RxString priorityLevelText = 'Low'.obs;
  Rx<DateTime> selectedDate = DateTime.now().add(const Duration(days: 1)).obs;
  @override
  void onInit() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    dueDateController = TextEditingController();
    fetchData();
    super.onInit();
  }

  void fetchData(){
    if(Get.arguments != null){
      if(Get.arguments['editTaskData'] != null){
        editTaskData =  Get.arguments['editTaskData'];
       titleController?.text = editTaskData!.title;
      descriptionController?.text = editTaskData!.description;
      dueDateController?.text = editTaskData!.dueDate;
      if(editTaskData!.priorityLevel == 1) {
        updatePriority('Low');
      }else if(editTaskData!.priorityLevel == 2){
        updatePriority('Medium');
      }
      else if(editTaskData!.priorityLevel == 3){
        updatePriority('High');
      }
      else{
        updatePriority('Low');
      }
    }
    }
  }


  Future<void> addTask() async {
    await database.insert(TaskData(title: titleController!.text, description: descriptionController!.text , priorityLevel:  priorityLevel.value, dueDate: dueDateController!.text ));
    Get.delete<TaskController>();
    Get.offAll(()=>HomePage());
  }



  Future<void> updateTask() async {
    await database.update(TaskData(id: editTaskData!.id,title: titleController!.text, description: descriptionController!.text , priorityLevel: priorityLevel.value ,
        dueDate: dueDateController!.text ));
    Get.delete<TaskController>();
    Get.offAll(()=>HomePage());
  }

  void clearControllers()  {
    titleController?.clear();
    descriptionController?.clear();
    dueDateController?.clear();
  }

void updatePriority(String value) {
  switch (value) {
    case 'High':
      priorityLevel.value = 3;
      priorityLevelText.value = value;
      break;
    case 'Medium':
      priorityLevel.value = 2;
      priorityLevelText.value = value;
      break;
    case 'Low':
      priorityLevel.value = 1;
      priorityLevelText.value = value;
      break;
    default :
      priorityLevel.value = 1;
      priorityLevelText.value = value;
      break;

  }

}
}
