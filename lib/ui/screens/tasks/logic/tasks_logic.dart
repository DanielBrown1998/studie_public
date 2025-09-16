import 'package:app/ui/screens/tasks/page/widgets/tutorial_widget.dart';
import 'package:app/ui/screens/tasks/page/widgets/tasks_to_dos.dart';
import 'package:app/utils/helpers/days_week.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TasksLogic extends GetxController with StateMixin<List<Widget>> {
  RxInt weekdayByDateTime = DateTime.now().weekday.obs;

  Rx<AllWeekDays?> weekday = AllWeekDays.initial.obs;
  RxList<Widget> toDos = <Widget>[].obs;

  RxStatus success = RxStatus.success();
  RxStatus loading = RxStatus.loading();
  RxStatus error = RxStatus.error("Houve um erro!".tr);
  RxStatus empty = RxStatus.empty();

  @override
  void dispose() {
    toDos.clear();
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    weekday.value = getWeekdayByNumber(weekdayByDateTime.value);
    initializeDaysAndTasksofDays(weekday.value!);
  }

  void initializeDaysAndTasksofDays(AllWeekDays weekdayActual) async {
    try {
      change(toDos, status: loading);
      await Future.delayed(Duration(milliseconds: 750));
      toDos.clear();
      toDos.add(TutorialWidget());
      for (int i = 1; i <= 7; i++) {
        weekday.value = getWeekdayByNumber(i);
        toDos.add(TasksToDos(weekDays: weekday.value!, index: i));
      }
      weekday.value = weekdayActual;
      change(toDos, status: success);
    } on Exception {
      change(toDos, status: error);
    }
  }
}
