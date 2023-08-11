

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/database/database_helper.dart';
import 'package:todo_app/model/task_data.dart';
import 'package:todo_app/widgets/toast.dart';

class TaskController extends GetxController {
  RxList <TaskData> taskData =<TaskData> [].obs;
  List<TaskData> filteredSet = [];
  DatabaseHelper database = DatabaseHelper();
   Rx<TextEditingController> searchController = TextEditingController(text: '').obs;
  @override
  void onInit() {
    getAllTask();
    filteredSet = taskData;
    super.onInit();
  }


  Future<void> getAllTask() async {
   await database.queryAllRows().then((value) {
      for (var element in value) {
          taskData.add(TaskData(id: element['id'], title: element['title'], description: element['description'], dueDate: element['dueDate'],
            priorityLevel: element['priorityLevel']));
      }
    });
  }

  Future<void> deleteTask(int id,int position) async {
     await database.delete(id);
    taskData.removeAt(position);
     toastFunction(message: "To Do delete successfully");
  }

  Future<void>  searchTasksByTitle(String searchTerm) async {
    taskData.value = filteredSet.where((item) => item.title.toLowerCase().contains(searchTerm.toLowerCase())).toList();
  }
}
