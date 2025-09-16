import 'package:app/source/models/task.dart';
import 'package:app/ui/screens/tasks/page/widgets/task_card.dart';
import 'package:app/utils/helpers/days_week.dart';
import 'package:app/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/controller_tasks.dart';

class TasksToDos extends StatelessWidget {
  final AllWeekDays weekDays;
  final int index;
  const TasksToDos({super.key, required this.weekDays, required this.index});

  @override
  Widget build(BuildContext context) {
    final tasks = Get.find<ControllerTask>(tag: weekDays.nome);
    final size = Get.size;
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
          child: Icon(Icons.arrow_back_ios_new, color: StudieTheme.whiteSmoke),
        ),
        Flexible(
          child: Card(
            shadowColor: StudieTheme.whiteSmoke,
            color: Colors.transparent,
            elevation: 12,
            child: SizedBox(
              height: size.height * 0.6,
              width: size.width * .8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() {
                  List<Task> allTasksThisWeekDay = tasks.tasks;
                  allTasksThisWeekDay.sort(
                    (a, b) => a.timeStart.compareTo(b.timeStart),
                  );
                  if (allTasksThisWeekDay.isEmpty) {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.no_cell_rounded,
                          color: Colors.red,
                          size: 60,
                        ),
                        Text(
                          "Sem plano para esse dia da semana".tr,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleLarge,
                        ),
                      ],
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    itemCount: allTasksThisWeekDay.length,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        task: allTasksThisWeekDay[index],
                        controllerTask: tasks,
                      );
                    },
                  );
                }),
              ),
            ),
          ),
        ),
        Center(
          child: Icon(Icons.arrow_forward_ios, color: StudieTheme.whiteSmoke),
        ),
      ],
    );
  }
}
