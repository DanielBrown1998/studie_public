import 'package:app/ui/screens/ai/logic/ai_logic.dart';
import 'package:get/get.dart';

class AiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AiLogic>(() => AiLogic());
  }
}
