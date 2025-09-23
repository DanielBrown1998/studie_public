part of 'ai_logic.dart';

class AiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AiLogic>(() => AiLogic());
  }
}
