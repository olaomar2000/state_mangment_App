import 'package:flutter/material.dart';
import 'package:state_mangment/task_model.dart';

import 'db_helper.dart';


class AppProvider with ChangeNotifier {
  List<Task> task = List<Task>();
  bool value = false;

  Future selectAllTasks() async {
    List<Task> newTask = [];
    await DbHalper.dbHalper.selectAllTasks().then((value) => value.forEach((e) {
          newTask.add(Task.fromMap(e));
        }));
    task.clear();
    task.addAll(newTask);
    notifyListeners();
  }

  Future insertTask(Task task) async {
    await DbHalper.dbHalper.insertNewTasks(task);
    selectAllTasks();
  }

  deleteTask(int id) async {
    await DbHalper.dbHalper.deleteTask(id);
    selectAllTasks();
  }

  updateTask(Task task) async {
    await DbHalper.dbHalper.updateTask(task);
    notifyListeners();
  }
}
