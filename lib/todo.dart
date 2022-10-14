import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_basics/provider/todo_opertaion.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController task = TextEditingController();
  bool isTask = false;



  @override
  Widget build(BuildContext context) {
    print('first build');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('My Todos'),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => PopUpDialoge(title: 'Add Task', task: task, onPress: (){
              if (task.text.isEmpty) {
                isTask = true;
              } else {
                Navigator.pop(context);
                Provider.of<TodoOperations>(context, listen: false)
                    .taskWidgets(task);
                task.clear();
              }
            })
          );
        },
        style: ElevatedButton.styleFrom(
            primary: Colors.red,
            padding: const EdgeInsets.all(10),
            shape: const CircleBorder()),
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Consumer<TodoOperations>(
          builder: (context, value,child) {
            print('list view build');
            return ListView.builder(
              itemCount: value.taskList.length,
              itemBuilder: ((context, index) {
                return Card(
                  elevation: 10,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: ListTile(
                    leading: Text(value.taskList[index].toString()),
                    title: IconButton(
                      icon: const Icon(
                        Icons.update,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        task.text = value.taskList[index];
                        showDialog(
                            context: context,
                            builder: (context) =>
                                PopUpDialoge(
                                    title: 'update', task: task, onPress: () {
                                  value.upDateTask(task, index);
                                  Navigator.pop(context);
                                }));
                      },
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        value.deleteTask(index);
                      },
                    ),
                  ),
                );
              }),
            );
          }
        ),
      ),
    );
  }
}


class PopUpDialoge extends StatelessWidget {

  const PopUpDialoge({
    required this.title,
    required this.task,
    required  this.onPress,
    Key? key}) : super(key: key);

  final String title;
  final Function onPress;
  final TextEditingController  task;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Text(title),
      content: TextField(
        controller: task,
      ),
      actions: [
        TextButton(
          onPressed:(){onPress();},
          child: Text(title),
        ),
        TextButton(
          onPressed: () {
              Navigator.pop(context);
              task.clear();
          },
          child: const Text('cancel'),
        )
      ],
    );
  }
}
