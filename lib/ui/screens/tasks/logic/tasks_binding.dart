import 'package:app/ui/screens/tasks/logic/tasks_logic.dart';
import 'package:get/get.dart';

class TasksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TasksLogic>(() => TasksLogic());
  }
}
