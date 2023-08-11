class TaskData {
  int? id;
  String title;
  String description;
  int priorityLevel;
  String dueDate;
  TaskData({ this.id, required this.title,required this.description,required this.priorityLevel,required this.dueDate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priorityLevel': priorityLevel,
      'dueDate': dueDate,
    };
  }
}
