import 'package:app/source/models/task.dart';
import 'package:app/ui/screens/tasks/page/widgets/task_card.dart';
import 'package:app/ui/core/theme/theme.dart';
import 'package:app/utils/helpers/days_week.dart';
import 'package:flutter/material.dart';

class TutorialWidget extends StatefulWidget {
  const TutorialWidget({super.key});

  @override
  State<TutorialWidget> createState() => _TutorialWidgetState();
}

class _TutorialWidgetState extends State<TutorialWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Icon(Icons.arrow_drop_up, color: StudieTheme.whiteSmoke),
            ),
            Card(
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(
                  width: 2,
                  color: StudieTheme.secondaryColor,
                ),
              ),
              elevation: 20,
              shadowColor: StudieTheme.secondaryColor,
              margin: EdgeInsets.only(bottom: 16, top: 16),
              color: StudieTheme.terciaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 10,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TaskCard(
                        task: Task(
                          timeStart: 00,
                          description: "aqui ficara a descricao da sua tarefa",
                          discipline: "titulo",
                          daysWeek: AllWeekDays.initial.name,
                        ),
                        isTutorial: true,
                      ),
                    ),
                    Wrap(
                      spacing: 10,
                      direction: Axis.vertical,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        Chip(
                          label: Text(
                            "suas tarefas estao armazenadas aqui!",
                            style: StudieTheme.textTheme.displaySmall,
                          ),
                        ),
                        Chip(
                          label: Text("aperte para marcar como concluido"),
                          labelStyle: StudieTheme.textTheme.displaySmall,
                        ),
                        Chip(
                          label: Text(
                            "pressione para mais opcoes",
                            style: StudieTheme.textTheme.displaySmall,
                          ),
                        ),
                        Chip(
                          label: Text(
                            "utilize o exemplo para testes",
                            style: StudieTheme.textTheme.displaySmall,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Icon(Icons.arrow_drop_down, color: StudieTheme.whiteSmoke),
            ),
          ],
        ),
      ),
    );
  }
}
