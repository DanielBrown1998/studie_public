import 'package:app/ui/screens/timer/logic/timer_logic.dart';
import 'package:get/get.dart';

class TimerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimerLogic>(() => TimerLogic());
  }
}
