import 'package:flutter/cupertino.dart';
import 'package:todo_list2/todo_model.dart';

class TodoProvider extends ChangeNotifier{
  final List<TodoModel> _task = [];

  List<TodoModel> get task => _task;

  ///Add Task
  void addTask({required String title, required String subtitle}){
    if(title.trim().isEmpty || subtitle.trim().isEmpty) {
      return;
    }
    _task.add(TodoModel(title: title, subtitle: subtitle));
    notifyListeners();
  }

  ///Delete Task
  void deleteTask(int index){
    _task.removeAt(index);
    notifyListeners();
  }

  /// Update Task
  void updateTask({required int index, required String title, required String subtitle}){

    _task[index].title = title;
    _task[index].subtitle = subtitle;
    notifyListeners();
  }

}