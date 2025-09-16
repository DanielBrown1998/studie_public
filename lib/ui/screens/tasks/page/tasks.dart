import 'package:app/source/models/task.dart';
import 'package:app/ui/core/components/error_screen.dart';
import 'package:app/ui/core/components/load_screen.dart';
import 'package:app/ui/screens/tasks/page/widgets/create_task.dart';
import 'package:app/ui/core/components/default_dialog.dart';
import 'package:app/ui/screens/tasks/logic/tasks_logic.dart';
import 'package:app/utils/helpers/days_week.dart';
import 'package:app/ui/core/theme/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TasksScreen extends GetView<TasksLogic> {
  const TasksScreen({super.key});

  deleteDataInCloud() async {
    final bool? confirm = await DefaultDialog.dialog(
      confirmText: "sim",
      cancelText: "nao",
      middleText: "deseja apagar os dados da nuvem?",
      titleText: "Remover Dados",
    );
    if (confirm == true) {
      // TODO implements a function to remove firebase data
    }
  }

  syncDataInCloud() async {}

  saveDataInCLoud() async {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StudieTheme.primaryColor,
        centerTitle: true,
        foregroundColor: StudieTheme.primaryColor,
        surfaceTintColor: StudieTheme.primaryColor,
        elevation: 10,
        automaticallyImplyLeading: false,
        leading: null,
        title: Text("Tarefas", style: theme.textTheme.titleLarge),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              switch (value) {
                case "delete":
                  deleteDataInCloud();
                  break;
                case "save":
                  saveDataInCLoud();
                  break;
                case "sync":
                  syncDataInCloud();
                  break;
              }
            },
            icon: Icon(Icons.cloud, color: StudieTheme.whiteSmoke),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: "save",
                  child: ListTile(
                    leading: Icon(Icons.upload),
                    title: Text(
                      "salvar tarefas",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: "sync",
                  child: ListTile(
                    leading: Icon(Icons.sync),
                    title: Text(
                      "sincronizar tarefas",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: "delete",
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text(
                      "deletar tarefas",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  StudieTheme.primaryColor,
                  StudieTheme.terciaryColor,
                  StudieTheme.whiteSmoke,
                ],
              ),
            ),
          ),
          controller.obx(
            onError: (error) => ErrorScreen(error: error),
            onLoading: LoadScreen(),
            (state) => Obx(
              () => SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.weekday.value!.nome.tr,
                      style: theme.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Center(
                      child: CarouselSlider(
                        items: controller.toDos,
                        options: CarouselOptions(
                          autoPlay: false,
                          // reverse: true,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            // setState(() {
                            if (index != 0) {
                              controller.weekday.value = getWeekdayByNumber(
                                index,
                              );
                            } else {
                              controller.weekday.value = AllWeekDays.initial;
                            }
                            debugPrint(index.toString());
                            debugPrint(controller.weekday.value.toString());
                            // });
                          },
                          height: Get.height * .8,
                          disableCenter: false,
                          aspectRatio: 1 / (Get.width / Get.height),
                          initialPage: getNumberByWeekDay(
                            controller.weekday.value!,
                          ),
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Obx(
        () =>
            (controller.weekday.value != AllWeekDays.initial)
                ? FloatingActionButton.extended(
                  heroTag: "create_task",
                  backgroundColor: Colors.amber,
                  elevation: 20,
                  splashColor: Colors.amberAccent,
                  icon: Icon(
                    Icons.add_task,
                    color: StudieTheme.primaryColor,
                    size: 30,
                  ),
                  label: FittedBox(
                    child: Text(
                      "Add",
                      style: StudieTheme.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        color: StudieTheme.primaryColor,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    Task? task = await Get.to(
                      () => FormCreateTaskScreen(
                        weekday: controller.weekday.value!.nome,
                      ),
                    );
                    if (task != null) {
                      controller.initializeDaysAndTasksofDays(
                        controller.weekday.value!,
                      );
                    }
                  },
                )
                : const SizedBox.shrink(),
      ),
    );
  }
}
