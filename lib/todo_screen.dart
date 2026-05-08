import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo_list2/todo_form.dart';
import 'package:todo_list2/todo_model.dart';
import 'package:todo_list2/todo_provider.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Row(
          children: [
            CircleAvatar(radius: 20),
            Gap(10),
            Text('ToDo List', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20)),
          ],
        ),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.task.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(value.task[index].title),
                subtitle: Text(value.task[index].subtitle),

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    /// update task
                    IconButton(
                      onPressed: () async {

                        final data = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TodoForm(
                              todoModel: value.task[index],
                              index: index,
                            ),
                          ),
                        );

                        if (data == null) return;

                        final todoModel = data as TodoModel;

                        context.read<TodoProvider>().updateTask(
                          index: index,
                          title: todoModel.title,
                          subtitle: todoModel.subtitle,
                        );
                      },
                      icon: Icon(Icons.edit, color: Colors.blue),
                    ),
                    IconButton(
                      onPressed: () {
                        value.deleteTask(index);
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () async {
          final data = await Navigator.push(context, MaterialPageRoute(builder: (_) => TodoForm()));
          if (data == null) return;
          final todoModel = data as TodoModel;
          context.read<TodoProvider>().addTask(title: todoModel.title, subtitle: todoModel.subtitle);
        },
        child: Icon(Icons.add, color: Colors.white, size: 26),
      ),
    );
  }
}
