import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_mangment/task_model.dart';


import 'app_provider.dart';
import 'db_helper.dart';

class NewTask extends StatelessWidget {
  bool isComplet = false;

  String taskName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New Task'),
        ),
        body: Container(
            padding: EdgeInsets.all(10),
            child: Consumer<AppProvider>(builder: (context, provider, c) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                    onChanged: (value) {
                      this.taskName = value;
                    },
                  ),
                  Checkbox(
                      value: provider.value,
                      onChanged: (value) {
                        provider.value = !provider.value;
                      }),
                  RaisedButton(
                    child: Text('Add New Task'),
                    onPressed: () {
                      provider
                          .insertTask(Task(taskName:this.taskName, isComplete:provider.value))
                          .whenComplete(() => Navigator.pop(context));
                    },
                  )
                ],
              );
            }
            )
        )
    );
  }
}
