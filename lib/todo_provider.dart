import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';
import 'todo_model.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoModel> _task = [];

  List<TodoModel> get task => _task;

  TodoProvider() {
    fetchTask();
  }

  /// Fetch Task
  Future<void> fetchTask() async {
    final Database db = await DatabaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query('todo');

    _task =
        maps.map((e) {
          return TodoModel(id: e['id'], title: e['title'], subtitle: e['subtitle']);
        }).toList();

    notifyListeners();
  }

  /// Add Task
  Future<void> addTask({required String title, required String subtitle}) async {
    if (title.trim().isEmpty || subtitle.trim().isEmpty) {
      return;
    }

    final Database db = await DatabaseHelper.database;

    await db.insert('todo', {'title': title, 'subtitle': subtitle});

    await fetchTask();
  }

  /// Delete Task
  Future<void> deleteTask(int id) async {
    final Database db = await DatabaseHelper.database;

    await db.delete('todo', where: 'id = ?', whereArgs: [id]);

    await fetchTask();
  }

  /// Update Task
  Future<void> updateTask({required int id, required String title, required String subtitle}) async {
    final Database db = await DatabaseHelper.database;

    await db.update('todo', {'title': title, 'subtitle': subtitle}, where: 'id = ?', whereArgs: [id]);

    await fetchTask();
  }
}
