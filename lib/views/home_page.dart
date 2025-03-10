import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controllers/todo_controller.dart';
import '../utils/constants.dart';
import 'widgets/todo_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ToDoController controller = Get.find<ToDoController>();
    final TextEditingController taskController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do"),
        backgroundColor: AppColors.red,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(3.w),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      hintText: "Enter a task",
                      filled: true,
                      fillColor: AppColors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                      border: Border.all()),
                  child: IconButton(
                    icon: Icon(Icons.add, color: AppColors.deepPurple),
                    onPressed: () {
                      if (taskController.text.isNotEmpty) {
                        controller.addToDo(taskController.text);
                        taskController.clear();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () {
                if (controller.todos.isNotEmpty) {
                  return ListView.builder(
                    itemCount: controller.todos.length,
                    itemBuilder: (context, index) {
                      final todo = controller.todos[index];
                      return ToDoTile(todo: todo);
                    },
                  );
                } else {
                  return Center(
                    child:
                        Text("No To-Do found", style: Get.textTheme.labelLarge),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
