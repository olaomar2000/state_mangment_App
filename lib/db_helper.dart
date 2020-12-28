
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:state_mangment/task_model.dart';



class DbHalper  {
  DbHalper._();

  static DbHalper dbHalper = DbHalper._();
  Database database;
  static final String databaseName = 'tasksDB.db';
  static final String tableName = 'tasks';
  static final String taskIdColumnName = 'id';
  static final String taskNameColumnName = 'name';
  static final String taskIsCompleteColumnName = 'isComplete';
  static final String colTitle = 'title';

  Future<Database> initDataBase() async {
    if (database == null) {
      return await createDataBase();
    } else {
      return database;
    }
  }

  Future<Database> createDataBase() async {
    try {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, databaseName);
      Database database =
          await openDatabase(path, version: 1, onCreate: (db, version) {
        db.execute('''CREATE TABLE $tableName(
      $taskIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
      $taskNameColumnName TEXT NOT NULL,
      $taskIsCompleteColumnName INTEGER
      )''');
      });
      return database;

    } on Exception catch (e) {
      print(e);
    }

  }

  insertNewTasks(Task task) async{
    try {
    var db=await initDataBase();
    db.insert(tableName, Task.toMap(task));
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<Map>>selectAllTasks()async{
    try {
    var db=await initDataBase();
    return await db.query(tableName);
    } on Exception catch (e) {
      print(e);
    }
  }
  //Done
  Future updateTask(Task task)async{
    try {
    var db=await initDataBase();
    db.update(tableName, Task.toMap(task),where: "$taskIdColumnName=${task.taskid}");
    } on Exception catch (e) {
      print(e);
    }
  }
//Done
  deleteTask(int id)async{
    var db=await initDataBase();
    db.delete(tableName,where: "$taskIdColumnName=$id");
  }


}
