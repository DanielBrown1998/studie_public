import 'package:app/core/components/app_bar.dart';
import 'package:app/core/components/time_picker_form_field.dart';
import 'package:app/core/theme/theme.dart';
import 'package:app/features/presenter/ai/logic/ai_logic.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class AiScreen extends GetView<AiLogic> {
  FirebaseProvider? firebaseProvider;
  AiScreen({super.key, this.firebaseProvider}) {
    // Initialize the FirebaseProvider if not provided
    // this is for dependency injection in tests
    firebaseProvider ??= FirebaseProvider(
      model: FirebaseAI.googleAI().generativeModel(model: "gemini-2.5-flash"),
    );
  }
  final RxBool isGenerateStudyPlan = false.obs;

  updateIsGenerateStudyPlan() {
    isGenerateStudyPlan.value = !isGenerateStudyPlan.value;
  }

  final lottieAiThinking = FittedBox(
    fit: BoxFit.scaleDown,
    child: Lottie.asset(
      "assets/lotties/ai_thinking.json",
      width: 150,
      height: 150,
    ),
  );

  Widget errorWidget(String? error) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Icon(
            Icons.signal_wifi_off,
            color: Colors.red,
            size: Get.size.width * .1,
          ),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            textAlign: TextAlign.left,
            "Sem rede conectada".tr,
            style: StudieTheme.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  successWidget() {
    if (controller.aiIsThinking.value) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: StudieTheme.secondaryColor, width: 3),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          height: Get.height * .2,
          width: Get.width,
          child: Center(child: lottieAiThinking),
        ),
      );
    }
    final formKey = GlobalKey<FormState>();
    final exameNameController = TextEditingController();
    final timeStartStudyController = TextEditingController();
    final timeEndStudyController = TextEditingController();
    final firstTimeStudyIntervalController = TextEditingController();
    final secondTimeStudyIntervalController = TextEditingController();
    final thirtTimeStudyIntervalController = TextEditingController();

    Widget studyPlanButton() {
      return Hero(
        tag: "studyPlanButton",
        child: InkWell(
          onTap: () {
            updateIsGenerateStudyPlan();
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        textAlign: TextAlign.left,
                        "Gerar plano de estudos com I.A".tr,
                        style: StudieTheme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    form() => Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: StudieTheme.whiteSmoke.withAlpha(154),
            child: Column(
              spacing: 10,
              children: [
                studyPlanButton(),
                TextFormField(
                  controller: exameNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "o nome do certame e obrigatorio".tr;
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  style: StudieTheme.textTheme.bodyMedium,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: StudieTheme.secondaryColor,
                        width: 2,
                      ),
                    ),
                    labelStyle: StudieTheme.textTheme.bodyMedium,
                    labelText: "Digite o nome do certame: ".tr,
                  ),
                ),
                TimePickerFormfield(
                  label: "Insira o horario inicial dos estudos",
                  timeController: timeStartStudyController,
                  validator: (TimeOfDay? value) {
                    if (value == null) {
                      return "Esse campo e necessario".tr;
                    }
                    if (value.hour < 7 || value.hour > 23) {
                      return "O valor deve ser entre 7 e 23".tr;
                    }
                    return null;
                  },
                ),

                TimePickerFormfield(
                  label: "Digite o horario final dos estudos",
                  timeController: timeEndStudyController,
                  validator: (TimeOfDay? value) {
                    if (value == null) {
                      return "Esse campo e necessario".tr;
                    }
                    if (value.hour < 7 || value.hour > 23) {
                      return "O valor deve ser entre 7 e 23".tr;
                    }
                    if (value.hour <=
                        int.parse(
                          timeStartStudyController.text.substring(0, 2),
                        )) {
                      return "O valor final deve ser maior que o inicial".tr;
                    }
                    return null;
                  },
                ),

                TimePickerFormfield(
                  label: "insira um horario de intervalo: ",
                  timeController: firstTimeStudyIntervalController,
                  validator: (TimeOfDay? value) {
                    if (value == null) {
                      return "Esse campo e necessario".tr;
                    }
                    if (value.hour < 7 || value.hour > 23) {
                      return "O valor deve ser entre 7 e 23".tr;
                    }
                    if (value.hour <=
                        int.parse(
                          timeStartStudyController.text.substring(0, 2),
                        )) {
                      return "O valor deve ser maior que o inicial".tr;
                    }
                    if (value.hour >=
                        int.parse(
                          timeEndStudyController.text.substring(0, 2),
                        )) {
                      return "O valor deve ser menor que o final".tr;
                    }
                    if (value.hour ==
                            int.parse(
                              secondTimeStudyIntervalController.text.substring(
                                0,
                                2,
                              ),
                            ) ||
                        value.hour ==
                            int.parse(
                              thirtTimeStudyIntervalController.text.substring(
                                0,
                                2,
                              ),
                            )) {
                      return "Os valores devem ser diferentes".tr;
                    }

                    return null;
                  },
                ),

                TimePickerFormfield(
                  label: "insira outro horario de intervalo (opcional)",

                  timeController: secondTimeStudyIntervalController,
                  validator: (TimeOfDay? value) {
                    if (value == null) {
                      return "Esse campo e necessario".tr;
                    }
                    if (value.hour < 7 || value.hour > 23) {
                      return "O valor deve ser entre 7 e 23".tr;
                    }
                    if (value.hour <=
                        int.parse(
                          timeStartStudyController.text.substring(0, 2),
                        )) {
                      return "O valor deve ser maior que o inicial".tr;
                    }
                    if (value.hour >=
                        int.parse(
                          timeEndStudyController.text.substring(0, 2),
                        )) {
                      return "O valor deve ser menor que o final".tr;
                    }
                    if (value.hour ==
                            int.parse(
                              firstTimeStudyIntervalController.text.substring(
                                0,
                                2,
                              ),
                            ) ||
                        value.hour ==
                            int.parse(
                              thirtTimeStudyIntervalController.text.substring(
                                0,
                                2,
                              ),
                            )) {
                      return "Os valores devem ser diferentes".tr;
                    }

                    return null;
                  },
                ),

                TimePickerFormfield(
                  label: "insira mais um horario de intervalo (opcional)",
                  timeController: thirtTimeStudyIntervalController,
                  validator: (TimeOfDay? value) {
                    if (value == null) {
                      return "Esse campo e necessario".tr;
                    }
                    if (value.hour < 7 || value.hour > 23) {
                      return "O valor deve ser entre 7 e 23".tr;
                    }
                    if (value.hour <=
                        int.parse(
                          timeStartStudyController.text.substring(0, 2),
                        )) {
                      return "O valor deve ser maior que o inicial".tr;
                    }
                    if (value.hour >=
                        int.parse(
                          timeEndStudyController.text.substring(0, 2),
                        )) {
                      return "O valor deve ser menor que o final".tr;
                    }
                    if (value.hour ==
                            int.parse(
                              firstTimeStudyIntervalController.text.substring(
                                0,
                                2,
                              ),
                            ) ||
                        value.hour ==
                            int.parse(
                              secondTimeStudyIntervalController.text.substring(
                                0,
                                2,
                              ),
                            )) {
                      return "Os valores devem ser diferentes".tr;
                    }

                    return null;
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white),
                        elevation: WidgetStatePropertyAll(0),
                        iconSize: WidgetStateProperty.all(50),
                      ),
                      onPressed: () {
                        updateIsGenerateStudyPlan();
                      },
                      child: Icon(Icons.cancel_outlined, color: Colors.red),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white),
                        elevation: WidgetStatePropertyAll(0),
                        iconSize: WidgetStateProperty.all(50),
                      ),
                      onPressed: () {
                        if (formKey.currentState != null &&
                            formKey.currentState!.validate()) {
                          updateIsGenerateStudyPlan();
                          controller.generateStudyPlan(
                            exameNameController.text,
                            timeStartStudyController.text,
                            timeEndStudyController.text,
                            firstTimeStudyIntervalController.text,
                            secondTimeStudyIntervalController.text,
                            thirtTimeStudyIntervalController.text,
                          );
                        }
                      },
                      child: Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: StudieTheme.secondaryColor, width: 3),
        ),
        child: AnimatedSize(
          curve: Curves.linear,
          alignment: AlignmentGeometry.topCenter,
          onEnd: () {},
          duration: Duration(milliseconds: 1250),
          reverseDuration: Duration(milliseconds: 250),
          child: (isGenerateStudyPlan.value) ? form() : studyPlanButton(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StudieAppBar.appBar,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              StudieTheme.primaryColor,
              StudieTheme.secondaryColor,
              StudieTheme.terciaryColor,
            ],
          ),
        ),
        child: Stack(
          children: [
            LlmChatView(
              key: Key("llmChatView"),
              cancelMessage: "cancelar".tr,
              welcomeMessage: "Olá! Como posso ajudar?".tr,
              autofocus: false,
              style: LlmChatViewStyle(
                progressIndicatorColor: StudieTheme.primaryColor,
                backgroundColor: Colors.transparent,
                userMessageStyle: UserMessageStyle(
                  textStyle: StudieTheme.textTheme.bodySmall,
                ),
                chatInputStyle: ChatInputStyle(
                  textStyle: StudieTheme.textTheme.bodySmall,
                ),
              ),
              enableVoiceNotes: false,
              errorMessage: "Houve um erro!".tr,
              provider: firebaseProvider!,
            ),
            controller.obx(
              onLoading: Center(child: lottieAiThinking),
              onError: (error) => errorWidget(error),
              (state) => Obx(() => successWidget()),
            ),
          ],
        ),
      ),
    );
  }
}
