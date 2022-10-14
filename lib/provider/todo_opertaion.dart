import 'package:flutter/material.dart';

class TodoOperations with ChangeNotifier{

  List<String> taskList = [];

  void taskWidgets(TextEditingController task) {
      taskList.add(task.text);
      notifyListeners();
  }

  void upDateTask(task,int  index){

    taskList[index] = task.text;
    task.clear();
    notifyListeners();
  }
  void deleteTask(int index) {
    taskList.removeAt(index);

    notifyListeners();

  }

}