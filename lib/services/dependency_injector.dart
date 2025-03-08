import 'package:get/get.dart';
import 'package:todo_app/utils/helper.dart';
import '../controllers/todo_controller.dart';

class DependencyInjector {
  static Future<void> initialize() async {
    await Helpers.initializeSharedPref();
    Get.put(ToDoController());
  }
}
