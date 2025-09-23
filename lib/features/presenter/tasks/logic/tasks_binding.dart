part of 'tasks_logic.dart';
class TasksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TasksLogic>(() => TasksLogic());
  }
}
