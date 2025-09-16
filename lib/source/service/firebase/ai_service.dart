import 'dart:convert';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';

class AIService {
  // Define o schema para uma única tarefa.
  static final _taskSchema = Schema.object(
    properties: {
      'horaInicial': Schema.integer(
        description: "A hora de início da tarefa (formato 24h, ex: 8, 14).",
      ),
      'discipline': Schema.string(
        description: "A matéria a ser estudada, com no máximo 18 caracteres.",
      ),
      'description': Schema.string(
        description:
            "Uma breve descrição da tarefa, com no máximo 20 caracteres.",
      ),
    },
    propertyOrdering: ['horaInicial', 'discipline', 'description'],
  );

  // Define o schema para o plano de um dia, que contém o nome do dia e uma lista de tarefas.
  static final _dayPlanSchema = Schema.object(
    properties: {
      'dia': Schema.string(
        description: "O nome do dia da semana (ex: 'segunda-feira').",
      ),
      'tarefas': Schema.array(
        items: _taskSchema,
        description: "Lista de tarefas para este dia.",
      ),
    },
    propertyOrdering: ['dia', 'tarefas'],
  );

  // Define o schema principal que espera um plano semanal, que é uma lista de planos diários.
  static final _jsonSchema = Schema.object(
    properties: {
      'plano_semanal': Schema.array(
        items: _dayPlanSchema,
        description:
            "Uma lista contendo o plano de estudos para cada dia da semana.",
      ),
    },
  );

  late final _model = FirebaseAI.googleAI().generativeModel(
    model: 'gemini-2.5-flash',
    generationConfig: GenerationConfig(
      responseSchema: _jsonSchema,
      responseMimeType: 'application/json', // Força a saída em JSON
    ),
  );

  Future<Map<String, dynamic>?> generateStudyPlan(
    String? exame,
    String? timeStartStudy,
    String? timeEndStudy,
    String? firstTimeStudyInterval,
    String? secondTimeStudyInterval,
    String? thirtTimeStudyInterval,
  ) async {
    String string =
        'Crie um plano de estudos semanal focado no certame do $exame. O plano deve cobrir de segunda a sabado. Os horários de estudo são: das ${timeStartStudy}h às ${timeEndStudy}h, os intervalos de descanso dos estudos são das ${firstTimeStudyInterval}h às ${int.parse(firstTimeStudyInterval!.substring(0, 2)) + 1}h';

    if (secondTimeStudyInterval != null && secondTimeStudyInterval.isNotEmpty) {
      string +=
          ' e das ${secondTimeStudyInterval}h  às ${int.parse(secondTimeStudyInterval.substring(0, 2)) + 1}h';
    }
    if (thirtTimeStudyInterval != null && thirtTimeStudyInterval.isNotEmpty) {
      string +=
          ' e das $thirtTimeStudyInterval às ${int.parse(thirtTimeStudyInterval.substring(0, 2)) + 1}h';
    }

    string +=
        '. Por favor, gere a resposta estritamente no formato JSON definido no schema. Certifique-se de que os valores de "discipline" e "description" respeitem os limites de caracteres definidos no schema.';

    final prompt = [Content.text(string)];

    final response = await _model.generateContent(prompt);
    final Map<String, dynamic> jsonResponse = json.decode(response.text!);
    debugPrint(jsonResponse.toString());
    return jsonResponse;
  }
}
