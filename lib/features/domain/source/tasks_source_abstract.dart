import 'package:app/features/domain/entities/task.dart';

abstract class TasksSourceAbstract {
  Future<List<Task>> getTasksByWeekDay({required String weekdays});
  Future<int> createTask({required Task task});
  Future<int> deleteTask({required Task task});
  Future<Task?> updateTask({required Task task});
  Future<bool> setTaskChecked({required Task task});
}
