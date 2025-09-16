import 'dart:async';
import 'package:app/source/service/firebase/ai_service.dart';
import 'package:app/utils/connect/connection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class AiLogic extends GetxController with StateMixin<List<ConnectivityResult>> {
  final AIService aiService = AIService();
  final Rx<Connection> connection = Connection().obs;
  late StreamSubscription<List<ConnectivityResult>> streamSubscription;
  RxBool aiIsThinking = false.obs;

  RxStatus loadingConnect = RxStatus.loading();
  RxStatus successConnect = RxStatus.success();
  RxStatus errorConnect = RxStatus.error();
  RxStatus empty = RxStatus.empty();

  @override
  void onInit() {
    super.onInit();
    change(connection.value.connectionStatus, status: loadingConnect);
    connection.value.initializeConnection();
    streamSubscription = connection.value.connectivyStream.listen((results) {
      _updateStatus();
    });
  }

  _updateStatus() {
    if (connection.value.connectionStatus.contains(ConnectivityResult.mobile) ||
        connection.value.connectionStatus.contains(ConnectivityResult.wifi)) {
      change(connection.value.connectionStatus, status: successConnect);
    } else {
      change(connection.value.connectionStatus, status: errorConnect);
    }
  }

  @override
  void onClose() {
    super.onClose();
    connection.value.dispose();
  }

  //retirar o nullable de message
  Future<Map<String, dynamic>?> generateStudyPlan(
    String? exame,
    String? timeStartStudy,
    String? timeEndStudy,
    String? firstTimeStudyInterval,
    String? secondTimeStudyInterval,
    String? thirtTimeStudyInterval,
  ) async {
    if (connection.value.connectionStatus == [ConnectivityResult.none]) {
      return null;
    }
    aiIsThinking.value = true;
    final studyPlan = await aiService.generateStudyPlan(
      exame,
      timeStartStudy,
      timeEndStudy,
      firstTimeStudyInterval,
      secondTimeStudyInterval,
      thirtTimeStudyInterval,
    );
    aiIsThinking.value = false;
    if (studyPlan != null) {
      return studyPlan;
    }
    return null;
  }
}
