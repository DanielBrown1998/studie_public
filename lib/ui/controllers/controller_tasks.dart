import 'package:app/domain/workflow/dao_tasks_workflow.dart';
import 'package:app/source/models/task.dart';
import 'package:get/get.dart';
import 'package:app/source/database/database.dart' as package_database;

class ControllerTask extends GetxController implements DaoTasksWorkflow {
  final package_database.AppDataBase database;
  RxString nome = "".obs;
  RxList<Task> tasks = <Task>[].obs;

  ControllerTask({required this.database});

  Future<void> initializeController({required String nome, required}) async {
    tasks.value = await getTasksByWeekDay(weekdays: nome);
    this.nome.value = nome;
  }

  Future<bool> checkIfHasTaskThisHour(Task task) async {
    List<Task> tasks = await getTasksByWeekDay(weekdays: task.daysWeek);
    for (Task taskInto in tasks) {
      if (taskInto.timeStart == task.timeStart) return false;
    }
    return true;
  }

  @override
  Future<int> createTask({required Task task}) async {
    int result = 0;

    int countTasks = task.timeEnd - task.timeStart;
    for (int i = 0; i < countTasks; i++) {
      Task taskPart = Task(
        daysWeek: task.daysWeek,
        description: task.description,
        discipline: task.discipline,
        checked: task.checked,
        timeStart: task.timeStart + i,
      );
      bool haveTaskThisHour = await checkIfHasTaskThisHour(taskPart);
      if (haveTaskThisHour) {
        await database.createTask(task: taskPart);
        result++;
        // debugPrint(result.toString());
        tasks.add(taskPart);
      }
    }
    return result;
  }

  @override
  Future<int> deleteTask({required Task task}) async {
    tasks.remove(task);
    return await database.deleteTask(task: task);
  }

  @override
  Future<List<Task>> getTasksByWeekDay({required String weekdays}) async {
    return await database.getTasksByWeekDay(weekdays: weekdays);
  }

  @override
  Future<bool> setTaskChecked({required Task task}) async {
    return await database.setTaskChecked(task: task);
  }

  @override
  Future<Task?> updateTask({required Task task}) async {
    final Task? result = await database.updateTask(task: task);
    return result;
  }
}
