import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:titled_navigation_bar/titled_navigation_bar.dart';

import 'Task_widget.dart';
import 'app_provider.dart';
import 'new_task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: (context) {
        return AppProvider();
      },
      child: MaterialApp(debugShowCheckedModeBanner: false, home: tabBar()),
    );
  }
}

class tabBar extends StatefulWidget {
  @override
  _tabBarState createState() => _tabBarState();
}

class _tabBarState extends State<tabBar> with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Consumer<AppProvider>(builder: (context, value, child) {
        value.selectAllTasks();
        return Scaffold(
          appBar: AppBar(
            title: Text("My Tasks"),
            bottom: TabBar(
              controller: tabController,
              tabs: [
                Tab(
                  child: Text("All Tasks"),
                ),
                Tab(
                  child: Text("Complete Tasks"),
                ),
                Tab(
                  child: Text("InComplete Tasks"),
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: tabController,
            children: [
              AllTasks(),
              CompleteTasks(),
              InCompleteTasks(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return NewTask();
              }));
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Colors.blue,
          ),
          bottomNavigationBar: TitledBottomNavigationBar(
              currentIndex: 0,
              onTap: (index) {
                tabController.animateTo(index);
                setState(() {
                });
              },
              items: [
                TitledNavigationBarItem(title: Text('Home'), icon: Icons.home),
                TitledNavigationBarItem(title: Text('Search'), icon: Icons.search),
                TitledNavigationBarItem(title: Text('favorite'), icon: Icons.favorite),
              ]),
          drawer: custamDrawer(tabController),
        );
      }),

    );

  }
}

class AllTasks extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, value, child) {
      return Column(
        children: value.task.map((e) => TaskWidget(e)).toList(),
      );
    });
  }
}

class CompleteTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, value, child) {
      return Column(
        children: value.task
            .where((element) => element.isComplete == true)
            .map((e) => TaskWidget(e))
            .toList(),
      );
    });

  }
}

class InCompleteTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, value, child) {
      return Column(
        children: value.task
            .where((element) => element.isComplete == false)
            .map((e) => TaskWidget(e))
            .toList(),
      );
    });
  }
}
class custamDrawer extends StatelessWidget {
  TabController tabController1;

  custamDrawer(this.tabController1);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              child: Text('O'),
            ),
            accountName: Text('Ola omar'),
            accountEmail: Text('olashab300@gmail.com'),
          ),
          ListTile(
            onTap: () {
              tabController1.animateTo(0);
              Navigator.pop(context);
            },
            title: Text('All Task'),
            subtitle: Text('user Task'),
            leading: Icon(Icons.done),
            trailing: Icon(Icons.arrow_right),
          ),
          ListTile(
            onTap: () {
              tabController1.animateTo(1);
              Navigator.pop(context);
            },
            title: Text('complete Task'),
            subtitle: Text('complete Task'),
            leading: Icon(Icons.done),
            trailing: Icon(Icons.arrow_right),
          ),
          ListTile(
            onTap: () {
              tabController1.animateTo(2);
              Navigator.pop(context);
            },
            title: Text(' Incomplete Task'),
            subtitle: Text('Incomplete Task'),
            leading: Icon(Icons.done),
            trailing: Icon(Icons.arrow_right),
          ),
          Text('data 1'),
          Text('data 2'),
          Text('data 3'),
        ],
      ),
    );
  }
}
