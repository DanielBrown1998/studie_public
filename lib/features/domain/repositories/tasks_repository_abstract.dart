import 'package:app/features/domain/entities/task.dart';

abstract class TasksRepositoryAbstract {
  Future<List<Task>> getTasksByWeekDay({required String weekdays});
  Future<int> createTask({required Task task});
  Future<int> deleteTask({required Task task});
  Future<Task?> updateTask({required Task task});
  Future<bool> setTaskChecked({required Task task});
}
