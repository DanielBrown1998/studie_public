import 'package:app/core/components/menu_card.dart';
import 'package:app/features/data/repository/tasks_repository_impl.dart';
import 'package:app/features/presenter/home.dart';
import 'package:app/utils/helpers/database_instance.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import '../data/controller_tasks_test.mocks.dart';
import 'home_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DatabaseInstance>(), MockSpec<TaskRepositoryImpl>()])
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockDatabaseInstance mockDatabaseInstance;
  late MockAppDataBase mockDatabase;

  setUp(() {
    // Limpa todas as dependências do GetX antes de cada teste
    Get.reset();
    mockDatabaseInstance = MockDatabaseInstance();
    mockDatabase = MockAppDataBase();

    // Configura os mocks
    when(mockDatabaseInstance.getdatabase).thenReturn(mockDatabase);
  });

  testWidgets("should show menu card and bottom buttons", (widgetTester) async {
    // Injete a instância mockada do DatabaseInstance no widget
    await widgetTester.pumpWidget(
      GetMaterialApp(home: HomePage(databaseInstance: mockDatabaseInstance)),
    );

    // Aguarda as animações e a inicialização do widget
    await widgetTester.pumpAndSettle();

    final title = find.text(
      "Aqui voce pode planejar seus estudos com facilidade",
    );
    expect(title, findsOneWidget);

    final menuCard = find.byType(MenuCard);
    expect(menuCard, findsWidgets);

    for (String description in [
      "plano semanal",
      "Meus Resumos",
      "A.I",
      "Tarefas",
      // "Pomodoro",
    ]) {
      final planWeekmenuCard = find.byWidgetPredicate((widget) {
        return widget is MenuCard && widget.description == description;
      });
      expect(planWeekmenuCard, findsOneWidget);
    }

    final bottomButtons = find.byType(FloatingActionButton);
    expect(bottomButtons, findsNWidgets(3));

    for (String description in [
      "config_button",
      "login_button",
      "help_button",
    ]) {
      Finder floatActionButton = find.byWidgetPredicate((widget) {
        return widget is FloatingActionButton &&
            description == widget.heroTag &&
            widget.isExtended == true;
      });
      expect(floatActionButton, findsOneWidget);
    }
  });
}
