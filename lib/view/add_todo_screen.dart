import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controller/add_todo_controller.dart';
import 'package:todo_app/widgets/text_form_field.dart';
import 'package:todo_app/widgets/toast.dart';

class AddToDo extends GetView<AddToDoController> {
  AddToDo({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final addToDoController = Get.put(AddToDoController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: textFieldsWidget(context)),
    );
  }

 Widget textFieldsWidget(context){
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height/1.5,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              children: <Widget>[
                TextFormFieldWidget(
                  maxLength: 30,
                  controller: addToDoController.titleController,
                  hintText: 'Title',
                ),
                TextFormFieldWidget(
                  maxLength: 50,
                  controller: addToDoController.descriptionController,
                  hintText: 'Description',
                    textInputAction : TextInputAction.done
                ),
                TextFormFieldWidget(
                  maxLength: 10,
                  readOnly: true,
                  controller: addToDoController.dueDateController,
                  hintText: 'Due Date',
                  counterText: '',
                  onTabFunction: (){
                    _selectDate(context:Get.context);
                  },
                ),
                Obx(
                  ()=> InputDecorator(
                    decoration: const InputDecoration(
                      labelText: '',
                      contentPadding: EdgeInsets.zero,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        items: addToDoController.priorities.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        style: const TextStyle(fontFamily: 'Urbanist-Medium',
                            fontSize: 16,
                            color: Colors.black),
                        value: addToDoController.priorityLevelText.toString(),
                        onChanged: (value) => addToDoController.updatePriority(value!),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50.0,),
                saveButtonView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate({BuildContext? context}) async {
    final DateTime? picked = await showDatePicker(
      context: context!,
      initialDate: addToDoController.selectedDate.value,
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != addToDoController.selectedDate.value) {
      addToDoController.selectedDate.value = picked;
      String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      addToDoController.dueDateController?.text = formattedDate;
    }
  }

  Widget saveButtonView(){
    return  ElevatedButton(
      onPressed: () {
        if(addToDoController.titleController!.text.isEmpty){
          toastFunction(message: "Title can't be empty");
          return;
        }
        if(addToDoController.descriptionController!.text.isEmpty){
          toastFunction(message: "Description can't be empty");
          return;
        }
        if(addToDoController.dueDateController!.text.isEmpty){
          toastFunction(message: "Due Date can't be empty");
          return;
        }
        (addToDoController.editTaskData != null)?
        addToDoController.updateTask() : addToDoController.addTask();
      },
      style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
          backgroundColor: MaterialStateProperty.all(Colors.amber),
          padding: MaterialStateProperty.all(const EdgeInsets.all(13.0)),
          textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20,color: Colors.white,fontFamily: 'Urbanist-Bold'))),
      child: const Text(
        "Save",
        style: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.w600),
      ),
    );
  }



}
