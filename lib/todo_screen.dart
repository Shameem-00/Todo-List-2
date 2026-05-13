import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'todo_form.dart';
import 'todo_model.dart';
import 'todo_provider.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo App')),

      body: Consumer<TodoProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.task.length,

            itemBuilder: (context, index) {
              final todo = value.task[index];

              return ListTile(
                title: Text(todo.title),

                subtitle: Text(todo.subtitle),

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    /// Edit
                    IconButton(
                      onPressed: () async {
                        final data = await Navigator.push(context, MaterialPageRoute(builder: (_) => TodoForm(todoModel: todo)));

                        if (data == null) return;

                        final TodoModel todoModel = data;

                        context.read<TodoProvider>().updateTask(id: todo.id!, title: todoModel.title, subtitle: todoModel.subtitle);
                      },

                      icon: const Icon(Icons.edit),
                    ),

                    /// Delete
                    IconButton(
                      onPressed: () {
                        context.read<TodoProvider>().deleteTask(todo.id!);
                      },

                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final data = await Navigator.push(context, MaterialPageRoute(builder: (_) => const TodoForm()));

          if (data == null) return;

          final TodoModel todoModel = data;

          context.read<TodoProvider>().addTask(title: todoModel.title, subtitle: todoModel.subtitle);
        },

        child: const Icon(Icons.add),
      ),
    );
  }
}
