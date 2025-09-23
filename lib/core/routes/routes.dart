import 'package:app/features/presenter/ai/logic/ai_logic.dart';
import 'package:app/features/presenter/ai/page/ai.dart';
import 'package:app/features/presenter/tasks/logic/tasks_logic.dart';
import 'package:app/features/presenter/tasks/page/tasks.dart';
import 'package:app/features/presenter/timer/logic/timer_logic.dart';
import 'package:app/features/presenter/timer/page/timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

goToTaskScreen() => Get.to(
  TasksScreen(),
  binding: TasksBinding(),
  curve: Curves.easeInOut,
  duration: Duration(milliseconds: 500),
  transition: Transition.downToUp,
);
goOffAllTaskScreen() => Get.offAll(
  TasksScreen(),
  binding: TasksBinding(),
  curve: Curves.easeInOut,
  duration: Duration(milliseconds: 500),
  transition: Transition.downToUp,
);

goToTimerScreen() => Get.to(
  TimerScreen(),
  binding: TimerBinding(),
  curve: Curves.easeInOut,
  duration: Duration(milliseconds: 500),
  transition: Transition.downToUp,
);
goToAiScreen() => Get.to(
  AiScreen(),
  binding: AiBinding(),
  curve: Curves.easeInOut,
  duration: Duration(milliseconds: 500),
  transition: Transition.downToUp,
);
