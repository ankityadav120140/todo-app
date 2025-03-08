import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/todo_controller.dart';
import '../../models/todo.dart';
import '../../utils/constants.dart';

class ToDoTile extends StatefulWidget {
  final ToDo todo;

  const ToDoTile({super.key, required this.todo});

  @override
  _ToDoTileState createState() => _ToDoTileState();
}

class _ToDoTileState extends State<ToDoTile> {
  late TextEditingController _controller;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.todo.task);
  }

  @override
  Widget build(BuildContext context) {
    final ToDoController todoController = Get.find();

    return Dismissible(
      key: Key(widget.todo.id.toString()),
      background: Container(
        color: Colors.green,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.check, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          todoController.markAsDone(widget.todo.id);
          return false;
        }
        return true;
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          todoController.deleteToDo(widget.todo.id);
        }
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
          leading: Checkbox(
            value: widget.todo.isCompleted,
            onChanged: (value) {
              todoController.toggleCompletion(widget.todo.id);
            },
          ),
          title: _isEditing
              ? TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                )
              : Text(
                  widget.todo.task,
                  style: TextStyle(
                    fontSize: 16.sp,
                    decoration: widget.todo.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
          trailing: IconButton(
            icon: Icon(
              _isEditing ? Icons.done : Icons.edit,
              color: AppColors.deepPurple,
            ),
            onPressed: () {
              setState(() {
                if (_isEditing) {
                  todoController.updateToDo(widget.todo.id, _controller.text);
                }
                _isEditing = !_isEditing;
              });
            },
          ),
        ),
      ),
    );
  }
}
