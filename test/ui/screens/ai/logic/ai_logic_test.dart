import 'package:app/source/service/firebase/ai_service.dart';
import 'package:app/ui/screens/ai/logic/ai_logic.dart';
import 'package:app/utils/connect/connection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart' as test;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'ai_logic_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AIService>(),
  MockSpec<AiLogic>(),
  MockSpec<Connection>(),
])
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  test.group("ai logic tests", () {
    late MockAIService aiService;
    late MockAiLogic aiLogic;
    late MockConnection connection;
    String? exame;
    String? timeStartStudy;
    String? timeEndStudy;
    String? firstTimeStudyInterval;
    String? secondTimeStudyInterval;
    String? thirtTimeStudyInterval;

    test.setUpAll(() {
      aiService = MockAIService();
      aiLogic = MockAiLogic();
      connection = MockConnection();
      exame = "math";
      timeStartStudy = "08:00";
      timeEndStudy = "12:00";
      firstTimeStudyInterval = "10:00";
    });

    test.test("Shoud generate studyPlan", () async {
      Map<String, dynamic> response = {
        "plano_semanal": [
          {
            "dia": "segunda-feira",
            "tarefas": [
              {
                "horaInicial": 8,
                "discipline": "math",
                "description": "analise combin.",
              },
              {
                "horaInicial": 9,
                "discipline": "math",
                "description": "analise combin.",
              },
              {
                "horaInicial": 11,
                "discipline": "math",
                "description": "analise combin.",
              },
            ],
          },
          {
            "dia": "terca-feira",
            "tarefas": [
              {
                "horaInicial": 8,
                "discipline": "math",
                "description": "analise combin.",
              },
              {
                "horaInicial": 9,
                "discipline": "math",
                "description": "analise combin.",
              },
              {
                "horaInicial": 11,
                "discipline": "math",
                "description": "analise combin.",
              },
            ],
          },
          {
            "dia": "quarta-feira",
            "tarefas": [
              {
                "horaInicial": 8,
                "discipline": "math",
                "description": "analise combin.",
              },
              {
                "horaInicial": 9,
                "discipline": "math",
                "description": "analise combin.",
              },
              {
                "horaInicial": 11,
                "discipline": "math",
                "description": "analise combin.",
              },
            ],
          },
          {
            "dia": "quinta-feira",
            "tarefas": [
              {
                "horaInicial": 8,
                "discipline": "math",
                "description": "analise combin.",
              },
              {
                "horaInicial": 9,
                "discipline": "math",
                "description": "analise combin.",
              },
              {
                "horaInicial": 11,
                "discipline": "math",
                "description": "analise combin.",
              },
            ],
          },
          {
            "dia": "sexta-feira",
            "tarefas": [
              {
                "horaInicial": 8,
                "discipline": "math",
                "description": "analise combin.",
              },
              {
                "horaInicial": 9,
                "discipline": "math",
                "description": "analise combin.",
              },
              {
                "horaInicial": 11,
                "discipline": "math",
                "description": "analise combin.",
              },
            ],
          },
          {
            "dia": "sabado",
            "tarefas": [
              {
                "horaInicial": 8,
                "discipline": "math",
                "description": "analise combin.",
              },
              {
                "horaInicial": 9,
                "discipline": "math",
                "description": "analise combin.",
              },
              {
                "horaInicial": 11,
                "discipline": "math",
                "description": "analise combin.",
              },
            ],
          },
        ],
      };

      when(connection.connectionStatus).thenReturn([ConnectivityResult.wifi]);

      when(
        aiService.generateStudyPlan(
          exame,
          timeStartStudy,
          timeEndStudy,
          firstTimeStudyInterval,
          secondTimeStudyInterval,
          thirtTimeStudyInterval,
        ),
      ).thenAnswer((_) async {
        return response;
      });

      when(
        aiLogic.generateStudyPlan(
          exame,
          timeStartStudy,
          timeEndStudy,
          firstTimeStudyInterval,
          secondTimeStudyInterval,
          thirtTimeStudyInterval,
        ),
      ).thenAnswer(
        (_) async => aiService.generateStudyPlan(
          exame,
          timeStartStudy,
          timeEndStudy,
          firstTimeStudyInterval,
          secondTimeStudyInterval,
          thirtTimeStudyInterval,
        ),
      );

      final generateStudyplan = await aiLogic.generateStudyPlan(
        exame,
        timeStartStudy,
        timeEndStudy,
        firstTimeStudyInterval,
        secondTimeStudyInterval,
        thirtTimeStudyInterval,
      );

      test.expect(generateStudyplan, response);
    });

    test.test(
      "generateStudyPlan should return null when no connection",
      () async {
        when(connection.connectionStatus).thenReturn([ConnectivityResult.none]);
        when(
          aiLogic.generateStudyPlan(
            exame,
            timeStartStudy,
            timeEndStudy,
            firstTimeStudyInterval,
            secondTimeStudyInterval,
            thirtTimeStudyInterval,
          ),
        ).thenAnswer((_) async => null);
        final generateStudyplan = await aiLogic.generateStudyPlan(
          exame,
          timeStartStudy,
          timeEndStudy,
          firstTimeStudyInterval,
          secondTimeStudyInterval,
          thirtTimeStudyInterval,
        );
        test.expect(generateStudyplan, null);
      },
    );
  });
}
