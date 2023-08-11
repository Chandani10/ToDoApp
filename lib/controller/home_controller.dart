

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/database/database_helper.dart';
import 'package:todo_app/model/task_data.dart';
import 'package:todo_app/widgets/notification_service.dart';
import 'package:todo_app/widgets/toast.dart';

class HomeController extends GetxController {
  RxList <TaskData> taskData =<TaskData> [].obs;
  List<TaskData> filteredList = [];
  DatabaseHelper database = DatabaseHelper();
   Rx<TextEditingController> searchController = TextEditingController(text: '').obs;
  @override
  void onInit() {
    getAllTask();
    super.onInit();
  }


  Future<void> getAllTask() async {
   await database.queryAllRows().then((value) {
      for (var element in value) {
        filteredList.add(TaskData(id: element['id'], title: element['title'], description: element['description'], dueDate: element['dueDate'],
            priorityLevel: element['priorityLevel']));
      }
      taskData.value = filteredList;
    });
   checkReminders();
  }

  Future<void> deleteTask(int id,int position) async {
     await database.delete(id);
    taskData.removeAt(position);
     toastFunction(message: "To Do delete successfully");
  }

  void searchTasksByTitle(String searchItem) {
    List <TaskData> results = [];
    if (searchItem.isEmpty) {
      results = filteredList;
    } else {
      results = filteredList.where((element) => element.title.toString().toLowerCase().contains(searchItem.toLowerCase())).toList();
    }
    taskData.value = results;
  }

  checkReminders() async {
    print('yes');
    for (var element in taskData) {
      var formattedDate = DateFormat('dd/MM/yyyy').parse(element.dueDate);
      DateTime currentDate = DateTime.now();
      print('yes1 $formattedDate');
      if (formattedDate.isBefore(currentDate) || formattedDate.isAtSameMomentAs(currentDate)) {
        print('yes1');
      await  NotificationService().showNotifications(message: "Your '${element.title}' task is Due or expired. Please complete this task");
      }
    }

  }
}
