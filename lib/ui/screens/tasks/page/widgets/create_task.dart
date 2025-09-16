import 'package:app/ui/controllers/controller_tasks.dart';
import 'package:app/ui/core/theme/theme.dart';
import 'package:app/source/models/task.dart';
import 'package:app/ui/core/components/getsnackbar.dart';
import 'package:drift/drift.dart' show InvalidDataException;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormCreateTaskScreen extends StatelessWidget {
  final String weekday;
  FormCreateTaskScreen({super.key, required this.weekday});

  final localFormKey = GlobalKey<FormState>();
  final disciplina = TextEditingController().obs;
  final hourInitial = TextEditingController().obs;
  final hourEnd = TextEditingController().obs;
  final description = TextEditingController().obs;

  Future<Task?> createTask(Task task) async {
    try {
      final controller = Get.find<ControllerTask>(tag: weekday);

      int value = await controller.createTask(task: task);
      if (value > 0) {
        Get.showSnackbar(
          GetSnackBarStudie(
            icon: Icons.create,
            message: "tarefa(s) criada(s) com sucesso!".tr,
          ).snackbarStudie,
        );
        return task;
      } else {
        Get.showSnackbar(
          GetSnackBarStudie(
            icon: Icons.error,
            message: "Erro ao criar tarefa!".tr,
          ).snackbarStudie,
        );
      }
    } on InvalidDataException catch (_) {
      Get.showSnackbar(
        GetSnackBarStudie(
          icon: Icons.error,
          message: "Erro ao criar tarefa!".tr,
        ).snackbarStudie,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StudieTheme.primaryColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Container(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Form(
                key: localFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 24.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(weekday, style: StudieTheme.textTheme.titleLarge),
                      Text(
                        "insira os dados da tarefa",
                        style: StudieTheme.textTheme.titleMedium,
                      ),
                      TextFormField(
                        style: StudieTheme.textTheme.titleSmall,
                        decoration: InputDecoration(
                          labelText: "disciplina",
                          labelStyle: StudieTheme.textTheme.titleSmall,
                        ),
                        controller: disciplina.value,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Informe a disciplina';
                          }
                          if (value.length > 18) {
                            return 'Mais de 18 caracteres';
                          }
                          if (value.length < 3) {
                            return 'Menos de 3 caracteres';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                      ),
                      TextFormField(
                        style: StudieTheme.textTheme.titleSmall,
                        decoration: InputDecoration(
                          labelText: "hora inicial",
                          labelStyle: StudieTheme.textTheme.titleSmall,
                        ),
                        controller: hourInitial.value,
                        onChanged: (value) {
                          hourEnd.value.text =
                              (int.parse(value) + 1).toString();
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Informe o horário inicial';
                          }
                          final hour = int.tryParse(value);
                          if (hour == null || hour < 0 || hour > 23) {
                            return 'Horário inicial inválido';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.datetime,
                      ),
                      Obx(
                        () => TextFormField(
                          style: StudieTheme.textTheme.titleSmall,
                          decoration: InputDecoration(
                            labelText: "hora final",
                            labelStyle: StudieTheme.textTheme.titleSmall,
                          ),
                          controller: hourEnd.value,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              hourEnd.value.text =
                                  (int.parse(hourInitial.value.text) + 1)
                                      .toString();
                            } else {
                              final hour = int.tryParse(value);
                              if (hour == null || hour < 0 || hour > 23) {
                                return 'Horário final inválido';
                              }
                              if (hourInitial.value.text.isNotEmpty) {
                                final start = int.tryParse(
                                  hourInitial.value.text,
                                );
                                if (start != null && hour <= start) {
                                  return 'Horário final deve ser maior que o inicial';
                                }
                              }
                            }
                            return null;
                          },
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                      TextFormField(
                        style: StudieTheme.textTheme.titleSmall,
                        controller: description.value,
                        decoration: InputDecoration(
                          labelText: "descricao",
                          labelStyle: StudieTheme.textTheme.titleSmall,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Informe a descrição';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (localFormKey.currentState != null &&
                                  localFormKey.currentState!.validate()) {
                                Task? task = Task(
                                  timeStart: int.parse(hourInitial.value.text),
                                  timeEnd: int.parse(hourEnd.value.text),
                                  description: description.value.text,
                                  discipline: disciplina.value.text,
                                  daysWeek: weekday,
                                );
                                createTask(task);
                                Get.back(result: task);
                              }
                            },
                            child: Icon(Icons.add_task, color: Colors.green),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.back(result: null);
                            },
                            child: Icon(Icons.cancel, color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
