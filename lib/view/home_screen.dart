import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controller/home_controller.dart';
import 'add_todo_screen.dart';

class HomePage extends GetView<HomeController> {
 HomePage({Key? key}) : super(key: key);
 final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add,color: Colors.white,),
        onPressed: () {
        Get.to(()=>AddToDo());
      },),
      appBar: AppBar(title: const Text("My To Do",
        style: TextStyle(fontSize: 20,fontFamily: 'Urbanist-Medium'),),
        actions:  [
          _showPopupMenu(),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          margin :  const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child:Column(
            children: [
              searchField(),
              Expanded(child: todoListItems()),
            ],
          )
        ),
      ),
    );
  }

  Widget searchField(){
    return  Obx(
          ()=>  SizedBox(
          height: 50,
          child: CupertinoSearchTextField(
            autofocus: false,
            controller: homeController.searchController.value,
            onChanged: (value){
                homeController.searchTasksByTitle(value);
            },
            decoration: BoxDecoration(border: Border.all(color: Colors.deepPurple)),
          )),
    );
  }

  Widget todoListItems() {
     return  Obx(() => homeController.taskData.isEmpty ?const Center(child: Text('No Data Found',style: TextStyle(fontSize: 20,fontFamily: 'Urbanist-Medium'),)) :ListView.builder(
           padding: const EdgeInsets.only(top: 30.0),
           itemCount: homeController.taskData.length,
           itemBuilder: (BuildContext context, int position) {
             return Container(
               margin: const EdgeInsets.only(bottom: 10.0),
               decoration:  BoxDecoration(
                   borderRadius: BorderRadius.circular(10.0),
                 boxShadow: const [
                   BoxShadow(
                       color: Color.fromRGBO(63,81,181, 0.1),
                        blurRadius: 15.0,
                       // offset: Offset(0.0, 7.0)
               ),
                 ],
               ),
               child: InkWell(onTap: homeController.taskData[position].description.length > 50 ?(){
                 Get.defaultDialog(
                     title: '',
                     content:  Text(
                       homeController.taskData[position].description,
                       textAlign: TextAlign.center,maxLines: 255,
                     ),
                     contentPadding: const EdgeInsets.only(bottom: 15,left: 20,right: 20),
                    confirm: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor: MaterialStateProperty.all(Colors.indigo),
                            padding: MaterialStateProperty.all(const EdgeInsets.all(10.0)),
                            textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20,color: Colors.white,fontFamily: 'Urbanist-Bold'))),
                        onPressed: (){
                          FocusScope.of(context).requestFocus(FocusNode());
                        Get.back();
                    }, child: const Text('Ok'))
                 );
               }:(){},
                 child: Card(
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                     color: Colors.white,
                     elevation: 2.0,
                     child: ListTile(
                       minLeadingWidth : 10,
                       leading:  Image.asset(
                         'assets/icons/flag.png',
                         scale: 1.2 ,
                         color: homeController.taskData[position].priorityLevel == 2 ? Colors.amber :
                         homeController.taskData[position].priorityLevel == 3  ? Colors.red : Colors.green,
                       ),
                       title: Row(
                         children: [
                           Expanded(
                             child: Text(homeController.taskData[position].title,maxLines: 2,
                               style: const TextStyle(
                                   fontSize: 18.0),
                             ).paddingOnly(top: 10),
                           ),
                         ],
                       ),
                       subtitle: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                           Text(
                             homeController.taskData[position].description,maxLines: 2,
                             style: const TextStyle(
                                 fontSize: 16.0,
                                 color: Colors.black54),
                           ).paddingOnly(top: 5,bottom: 5),
                           Text(
                             'Created at : ${homeController.taskData[position].dueDate}',
                             style: const TextStyle(
                                 fontSize: 16.0,
                                 color: Colors.black38),
                           ),
                         ],
                       ),
                       contentPadding: const EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 20.0),
                       isThreeLine: true,
                       trailing: Row(
                         mainAxisSize: MainAxisSize.min,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           InkWell(
                               onTap: (){
                                 Get.to(()=>AddToDo(),arguments: {'editTaskData': homeController.taskData[position]});
                               },
                               child: const Icon(Icons.mode_edit_outlined,size: 30,color: Colors.indigo,)),
                          InkWell(
                          onTap: () async {
                            deleteDialog(onConfirm :(){
                              Get.back();
                              homeController.deleteTask(homeController.taskData[position].id!,position);
                            });
                             },
                              child: const Icon(Icons.delete_forever,size: 30,color: Colors.red,).paddingOnly(left: 15,right: 10)),
                       ],).paddingOnly(top: 20),
                     )),
               ),
             );
           }),
     );
   }

 void  deleteDialog({Function? onConfirm}){
     Get.defaultDialog(
         titlePadding: const EdgeInsets.only(top: 15,bottom: 10),
         title: 'Delete To Do',
         barrierDismissible: false,
         content: const Text(
           'Are you sure , do you want to delete this todo?',
           textAlign: TextAlign.center,
         ),
         contentPadding: const EdgeInsets.only(bottom: 15,left: 20,right: 20),
         confirmTextColor: Colors.white,
         textConfirm: 'Yes',
         textCancel: 'No',onConfirm: (){
       if(onConfirm != null)onConfirm();
     },
       onCancel: (){
         Get.back();
       }
     );
   }

 Widget  _showPopupMenu()  {
   return PopupMenuButton<int>(elevation: 3,
     icon: const Icon(Icons.filter_alt_outlined,size: 30,).paddingOnly(right: 10),
     onSelected: (value) {
     if(value == 1){
       homeController.taskData.sort((a, b){ //sorting in descending order
         return (b.priorityLevel).compareTo((a.priorityLevel));
       });
     }else{
       homeController.taskData.sort((a, b){ //sorting in descending order
         return DateFormat('dd/MM/yyyy').parse(a.dueDate).compareTo(DateFormat('dd/MM/yyyy').parse(b.dueDate));
       });
     }
     },
     itemBuilder: (BuildContext context) {
       return [
         const PopupMenuItem(
           value: 1,
           child: Text('Priority Level',style: TextStyle(fontSize: 18),),
         ),
         const PopupMenuItem(
           value: 2,
           child: Text('Date',style: TextStyle(fontSize: 18)),
         ),

       ];
     },
   );
 }



}

