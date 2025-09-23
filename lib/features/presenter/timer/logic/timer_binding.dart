part of 'timer_logic.dart';
class TimerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimerLogic>(() => TimerLogic());
  }
}
