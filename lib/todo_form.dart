import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_list2/todo_model.dart';

class TodoForm extends StatefulWidget {
  const TodoForm({
    super.key,
    this.todoModel,
    this.index,
  });

  final TodoModel? todoModel;
  final int? index;

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final TextEditingController titleController =  TextEditingController();

  final TextEditingController subtitleController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('ToDo Form',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20 ),),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Enter Title',
                border: OutlineInputBorder(),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)
                )
              ),
            ),
            Gap(10),
            TextField(
              controller: subtitleController,
              decoration: InputDecoration(
                  hintText: 'Enter Subtitle',
                  border: OutlineInputBorder(),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)
                  )
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: (){
                final data = TodoModel(title: titleController.text, subtitle: subtitleController.text);
                Navigator.pop(context, data);
              },
                  child: Text('Save')
              ),
            )
          ],
        ),
      ),
    );
  }
}
