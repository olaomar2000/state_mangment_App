import 'db_helper.dart';


class Task {
  int taskid;
  String taskName;
  bool isComplete;

  Task({this.taskid,this.taskName, this.isComplete});

  static toMap(Task task) {
    return {
      DbHalper.taskNameColumnName: task.taskName,
      DbHalper.taskIsCompleteColumnName: task.isComplete ? 1 : 0
    };
  }

  static Task fromMap(Map map) {
    bool isComplete;
    if (map[DbHalper.taskIsCompleteColumnName] == 1) {
      isComplete = true;
    }else {
      isComplete = false;
    }
    var task = Task(taskid:map[DbHalper.taskIdColumnName],taskName:map[DbHalper.taskNameColumnName],isComplete: isComplete);
    return task;
  }
}
