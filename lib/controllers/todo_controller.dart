import 'package:get/get.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/utils/helper.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import '../models/todo.dart';

class ToDoController extends GetxController {
  var todos = <ToDo>[].obs;

  ToDoController();

  @override
  void onInit() {
    super.onInit();
    loadToDos();
  }

  void addToDo(String task) {
    String id = const Uuid().v4();
    todos.add(ToDo(id: id, task: task, isCompleted: false));
    saveToDos();
  }

  void toggleCompletion(String id) {
    int index = todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      todos[index] = ToDo(
        id: todos[index].id,
        task: todos[index].task,
        isCompleted: !todos[index].isCompleted,
      );
      todos.refresh();
      saveToDos();
    }
  }

  void deleteToDo(String id) {
    todos.removeWhere((todo) => todo.id == id);
    saveToDos();
  }

  void saveToDos() {
    List<String> todoList =
        todos.map((todo) => jsonEncode(todo.toJson())).toList();
    Helpers.prefs?.setStringList(Keys.toDos, todoList);
  }

  void loadToDos() {
    List<String>? todoList = Helpers.prefs?.getStringList(Keys.toDos);
    if (todoList != null) {
      todos.value =
          todoList.map((item) => ToDo.fromJson(jsonDecode(item))).toList();
    }
  }

  void markAsDone(String id) {
    int index = todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      todos[index] = ToDo(
        id: todos[index].id,
        task: todos[index].task,
        isCompleted: true,
      );
      todos.refresh();
      saveToDos();
    }
  }

  void updateToDo(String id, String newTask) {
    int index = todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      todos[index] = ToDo(
        id: todos[index].id,
        task: newTask,
        isCompleted: todos[index].isCompleted,
      );
      todos.refresh();
      saveToDos();
    }
  }
}
