import 'package:app/ui/controllers/controller_tasks.dart';
import 'package:app/source/models/task.dart';
import 'package:app/ui/core/theme/theme.dart';
import 'package:app/ui/core/components/getsnackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class TaskCard extends StatefulWidget {
  final Task task;
  double? width;
  bool isTutorial;
  final ControllerTask? controllerTask;
  bool flagShowDescription = false;
  Color borderColorCard = StudieTheme.primaryColor;
  TaskCard({
    super.key,
    required this.task,
    this.controllerTask,
    this.width,
    this.isTutorial = false,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  final _formKey = GlobalKey<FormState>();
  final disciplineController = TextEditingController();
  final timeStartController = TextEditingController();
  final descriptionController = TextEditingController();
  // control variavable for update task
  bool isUpdating = false;
  //to backup for cancel in update
  Task? temporaryTask;
  @override
  void initState() {
    super.initState();
    temporaryTask = widget.task;
    widget.width = 1;
    timeStartController.text = widget.task.timeStart.toString();
    disciplineController.text = widget.task.discipline;
    descriptionController.text = widget.task.description;
  }

  @override
  bool get mounted => super.mounted && widget.width != null;

  @override
  void dispose() {
    widget.width = null;
    disciplineController.dispose();
    timeStartController.dispose();
    descriptionController.dispose();
    temporaryTask = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ControllerTask? controller = widget.controllerTask;
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TweenAnimationBuilder(
        duration: Duration(milliseconds: 350),
        tween: Tween<double>(begin: 1, end: widget.width ?? 1),
        curve: Curves.linearToEaseOut,
        onEnd: () {},
        builder:
            (context, value, child) => Center(
              child: AnimatedSize(
                duration: Duration(milliseconds: 450),
                curve: Curves.linear,
                onEnd: () {
                  setState(() {
                    widget.width = 1;
                    if (widget.borderColorCard != StudieTheme.primaryColor) {
                      widget.borderColorCard = StudieTheme.primaryColor;
                    } else {
                      widget.borderColorCard = StudieTheme.secondaryColor;
                    }
                  });
                },
                reverseDuration: Duration(milliseconds: 300),
                child: Card(
                  shadowColor: theme.primaryColor,
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(
                      width:
                          (3 + (widget.width ?? 0.0)) *
                          (2 - (widget.width ?? 1.0)),
                      color: widget.borderColorCard,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                      ),
                    ),
                    child: child,
                  ),
                ),
              ),
            ),
        child: Form(
          key: _formKey,
          child: InkWell(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            ),
            onTap: () async {
              //check is here
              widget.task.checked = !widget.task.checked;
              if (!widget.isTutorial) {
                await controller!.setTaskChecked(task: widget.task);
              }
              setState(() {});
            },
            onLongPress: () {
              widget.flagShowDescription = !widget.flagShowDescription;
              setState(() {
                widget.width = 0;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: size.width * 0.15,
                        child: TextFormField(
                          enabled: isUpdating,
                          decoration: InputDecoration(border: InputBorder.none),
                          keyboardType: TextInputType.number,
                          initialValue:
                              (!isUpdating)
                                  ? "${timeStartController.text}:00"
                                  : null,
                          controller: (isUpdating) ? timeStartController : null,
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
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      Flexible(
                        child: TextFormField(
                          decoration: InputDecoration(border: InputBorder.none),
                          enabled: isUpdating,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Informe a disciplina';
                            }
                            if (value.length > 12) {
                              return 'Menos de 12 caracteres';
                            }
                            return null;
                          },
                          controller: disciplineController,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      if (!isUpdating)
                        Checkbox(
                          value: widget.task.checked,
                          onChanged: (value) {},
                          shape: CircleBorder(
                            side: BorderSide(
                              width: 2,
                              color: StudieTheme.secondaryColor,
                            ),
                          ),
                        )
                      else
                        ElevatedButton.icon(
                          style: ButtonStyle().copyWith(
                            elevation: WidgetStatePropertyAll(0),
                          ),
                          onPressed: () async {
                            //update task here!!!

                            if (_formKey.currentState!.validate()) {
                              Task task = Task(
                                timeStart: int.parse(timeStartController.text),
                                daysWeek: controller!.nome.value,
                                description: descriptionController.text.trim(),
                                discipline: disciplineController.text.trim(),
                                uid: widget.task.uid,
                                timeEnd: widget.task.timeEnd,
                              );
                              Get.showSnackbar(
                                GetSnackBarStudie(
                                  icon: Icons.refresh,
                                  message: "Atualizando tarefa...",
                                ).snackbarStudie,
                              );
                              Task? value = await controller.updateTask(
                                task: task,
                              );
                              if (value != null) {
                                Get.showSnackbar(
                                  GetSnackBarStudie(
                                    icon: Icons.check,
                                    message: "tarefa atualizada",
                                  ).snackbarStudie,
                                );
                              } else {
                                Get.showSnackbar(
                                  GetSnackBarStudie(
                                    icon: Icons.error,
                                    message: "Houve um Erro, tente novamente!",
                                  ).snackbarStudie,
                                );
                              }
                              isUpdating = !isUpdating;
                              setState(() {});
                            } else {
                              Get.showSnackbar(
                                GetSnackBarStudie(
                                  icon: Icons.error,
                                  message: "Houve um Erro, tente novamente!",
                                ).snackbarStudie,
                              );
                            }
                          },
                          label: Icon(Icons.add_task),
                        ),
                    ],
                  ),
                  Visibility(
                    visible: widget.flagShowDescription,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: descriptionController,
                          maxLines: 10,
                          minLines: 1,
                          decoration: InputDecoration(border: InputBorder.none),
                          enabled: isUpdating,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Informe a descrição';
                            }
                            return null;
                          },
                          style: theme.textTheme.bodyMedium,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            IconButton(
                              onPressed: () {
                                timeStartController.text =
                                    temporaryTask!.timeStart.toString();
                                disciplineController.text =
                                    temporaryTask!.discipline;
                                descriptionController.text =
                                    temporaryTask!.description;
                                setState(() {
                                  isUpdating = !isUpdating;
                                });
                              },
                              icon: Icon(
                                (!isUpdating) ? Icons.refresh : Icons.cancel,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                bool delete = await Get.dialog(
                                  Container(
                                    constraints: BoxConstraints(
                                      maxHeight: 500,
                                      minHeight: 350,
                                      minWidth: 230,
                                      maxWidth: 400,
                                    ),
                                    height: size.height / 3,
                                    width: size.width * .8,
                                    decoration: BoxDecoration(
                                      color: StudieTheme.whiteSmoke.withAlpha(
                                        160,
                                      ),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.remove_circle_outline,
                                          color: Colors.red,
                                          size: 50,
                                        ),
                                        Text(
                                          "Remover ${widget.task.discipline}?",
                                          style: theme.textTheme.bodyLarge,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Get.back(result: false);
                                              },
                                              style: ButtonStyle(
                                                iconColor:
                                                    WidgetStateProperty.all(
                                                      Colors.red,
                                                    ),
                                                iconSize:
                                                    WidgetStateProperty.all(32),
                                                backgroundColor:
                                                    WidgetStateProperty.all(
                                                      StudieTheme.whiteColor,
                                                    ),
                                              ),
                                              child: Icon(Icons.delete),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Get.back(result: true);
                                              },
                                              style: ButtonStyle(
                                                iconColor:
                                                    WidgetStateProperty.all(
                                                      const Color.fromARGB(
                                                        255,
                                                        47,
                                                        112,
                                                        49,
                                                      ),
                                                    ),
                                                iconSize:
                                                    WidgetStateProperty.all(32),
                                                backgroundColor:
                                                    WidgetStateProperty.all(
                                                      StudieTheme.whiteColor,
                                                    ),
                                              ),
                                              child: Icon(Icons.check),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  transitionCurve: Curves.decelerate,
                                  transitionDuration: Duration(
                                    milliseconds: 500,
                                  ),
                                );
                                if (delete) {
                                  await controller!.deleteTask(
                                    task: widget.task,
                                  );
                                }
                              },
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                            IconButton(
                              onPressed: () {
                                //here go a pomodoro
                              },
                              icon: Icon(Icons.access_alarm),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
