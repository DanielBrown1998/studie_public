import 'package:app/ui/screens/ai/logic/ai_binding.dart';
import 'package:app/ui/screens/ai/page/ai.dart';
import 'package:app/ui/screens/tasks/logic/tasks_binding.dart';
import 'package:app/ui/screens/tasks/page/tasks.dart';
import 'package:app/ui/screens/timer/logic/timer_binding.dart';
import 'package:app/ui/screens/timer/page/timer.dart';
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
