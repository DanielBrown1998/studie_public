import 'dart:async';
import 'package:app/features/data/source/service/firebase/ai_service.dart';
import 'package:app/core/components/getsnackbar.dart';
import 'package:app/utils/connect/connection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
part 'ai_binding.dart';

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
    streamSubscription.cancel();
    connection.value.dispose();
    super.onClose();
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
    if (connection.value.connectionStatus == [ConnectivityResult.none] ||
        state == [ConnectivityResult.none]) {
      return null;
    }

    final errorSnackBar =
        GetSnackBarStudie(
          icon: Icons.error,
          message: 'Error ao gerar o plano de estudos, tente novamente.'.tr,
          duration: 3,
        ).snackbarStudie;

    aiIsThinking.value = true;
    Map<String, dynamic>? studyPlan;
    try {
      studyPlan = await aiService.generateStudyPlan(
        exame,
        timeStartStudy,
        timeEndStudy,
        firstTimeStudyInterval,
        secondTimeStudyInterval,
        thirtTimeStudyInterval,
      );
    } catch (e) {
      aiIsThinking.value = false;
      debugPrint('Error ao gerar o plano de estudos: $e');
      errorSnackBar.show();
      return null;
    }
    aiIsThinking.value = false;
    if (studyPlan == null) {
      errorSnackBar.show();
      return null;
    }
    return studyPlan;
  }
}
