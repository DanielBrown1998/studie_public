import 'package:app/features/presenter/ai/logic/ai_logic.dart';
import 'package:app/features/presenter/ai/page/ai.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/mockito.dart';
import '../logic/ai_logic_test.mocks.dart';

class FakeAiBinding extends Bindings {
  final MockAiLogic mockAiLogic;
  FakeAiBinding(this.mockAiLogic);
  @override
  void dependencies() {
    Get.lazyPut<AiLogic>(() => mockAiLogic);
  }
}

class FakeInternalFinalCallback extends Fake implements InternalFinalCallback {
  @override
  void call() {
    // Do nothing
  }
}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockAiLogic mockAiLogic;
  late Rx<MockConnection> mockConnection;
  late MockFirebaseProvider mockFirebaseProvider;
  
  setUp(() {
    Get.testMode = true;
    mockAiLogic = MockAiLogic();
    mockConnection = MockConnection().obs;
    mockFirebaseProvider = MockFirebaseProvider();
    when(mockAiLogic.onStart).thenReturn(FakeInternalFinalCallback());
    when(mockAiLogic.onDelete).thenReturn(FakeInternalFinalCallback());
  });
  tearDown(() {
    Get.testMode = false;
    Get.reset();
  });

  pumpMainWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        initialBinding: FakeAiBinding(mockAiLogic),
        home: AiScreen(firebaseProvider: mockFirebaseProvider),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('AiPage displays correctly', (WidgetTester tester) async {
    when(mockAiLogic.status).thenReturn(RxStatus.success());
    when(mockAiLogic.state).thenReturn([ConnectivityResult.wifi]);
    when(mockAiLogic.connection).thenReturn(mockConnection);
    when(mockAiLogic.aiIsThinking).thenReturn(false.obs);
    await pumpMainWidget(tester);
    final textFinder = find.text('Gerar plano de estudos com I.A'.tr);
    expect(textFinder, findsOneWidget);
    final llmChatView = find.byKey(Key("llmChatView"));
    expect(llmChatView, findsOneWidget);
  });

  testWidgets('AiPage display connection Error Widget', (
    WidgetTester tester,
  ) async {
    when(mockAiLogic.status).thenReturn(RxStatus.error());
    when(mockAiLogic.state).thenReturn([ConnectivityResult.none]);
    when(mockAiLogic.connection).thenReturn(mockConnection);
    when(mockAiLogic.aiIsThinking).thenReturn(false.obs);
    await pumpMainWidget(tester);

    final llmChatView = find.widgetWithText(
      LlmChatView,
      "Olá! Como posso ajudar?".tr,
    );
    expect(llmChatView, findsOneWidget);
    final iconFinder = find.byIcon(Icons.signal_wifi_off);
    expect(iconFinder, findsOneWidget);
    final textFinder = find.text('Sem rede conectada'.tr);
    expect(textFinder, findsOneWidget);
  });

  testWidgets("AiPage display widget loading while status for loading", (
    WidgetTester tester,
  ) async {
    when(mockAiLogic.status).thenReturn(RxStatus.loading());
    when(mockAiLogic.aiIsThinking).thenReturn(false.obs);
    await pumpMainWidget(tester);
    final loadingIndicator = find.byType(Lottie);
    expect(loadingIndicator, findsOneWidget);
  });
}
