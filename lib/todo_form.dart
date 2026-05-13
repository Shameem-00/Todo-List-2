import 'package:flutter/material.dart';
import 'todo_model.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class TodoForm extends StatefulWidget {
  const TodoForm({super.key, this.todoModel});

  final TodoModel? todoModel;

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController subtitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.todoModel?.title ?? '';
    subtitleController.text = widget.todoModel?.subtitle ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo Form')),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(hintText: 'Enter Title', border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) return "required";
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    controller: subtitleController,
                    decoration: const InputDecoration(hintText: 'Enter Subtitle', border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) return "required";
                      return null;
                    },
                  ),
                ],
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context, TodoModel(id: widget.todoModel?.id, title: titleController.text, subtitle: subtitleController.text));
                    }
                  },

                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
