import 'package:app/features/data/repository/tasks_repository_impl.dart';
import 'package:app/core/routes/routes.dart';
import 'package:app/core/components/app_bar.dart';
import 'package:app/core/components/menu_card.dart';
import 'package:app/features/data/source/database/database.dart';
import 'package:app/utils/helpers/database_instance.dart';
import 'package:app/utils/helpers/days_week.dart';
import 'package:app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, DatabaseInstance? databaseInstance})
    : databaseInstance = databaseInstance ?? DatabaseInstance();

  final DatabaseInstance databaseInstance;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double _op;
  @override
  void initState() {
    _op = 0;
    awaitAndShowMenuCard();
    super.initState();
    AppDataBase database = widget.databaseInstance.getdatabase;
    for (AllWeekDays weekday in AllWeekDays.values) {
      Get.putAsync(() async {
        final controller = TaskRepositoryImpl(database: database);
        await controller.initializeController(nome: weekday.nome);
        return controller;
      }, tag: weekday.nome);
    }
  }

  void awaitAndShowMenuCard() async {
    await Future.delayed(Duration(milliseconds: 1500));
    setState(() {
      _op = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: StudieAppBar.appBar,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              StudieTheme.primaryColor,
              StudieTheme.terciaryColor,
              StudieTheme.whiteSmoke,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                child: Text(
                  "Aqui voce pode planejar seus estudos com facilidade".tr,
                  style: theme.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1,
                    mainAxisSpacing: 20,
                  ),
                  children: [
                    AnimatedOpacity(
                      opacity: _op,
                      duration: Duration(seconds: 1),
                      curve: Curves.easeInCubic,
                      child: MenuCard(
                        function: () {
                          goToTaskScreen();
                        },
                        description: "plano semanal".tr,
                        icon: Icons.play_arrow,
                        duration: 1,
                      ),
                    ),
                    AnimatedOpacity(
                      duration: Duration(seconds: 1),
                      opacity: _op,
                      curve: Curves.easeInCubic,
                      child: MenuCard(
                        function: () {},
                        description: "Meus Resumos".tr,
                        icon: Icons.create_new_folder,
                        duration: 1,
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: _op,
                      duration: Duration(milliseconds: 1500),
                      curve: Curves.easeInCubic,
                      child: MenuCard(
                        function: () {
                          goToAiScreen();
                        },
                        description: "A.I",
                        // icon: Icons.star_rate,
                        lottieURL: "assets/lotties/star_ai.json",
                        duration: 1,
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: _op,
                      duration: Duration(milliseconds: 1750),
                      curve: Curves.easeInCubic,
                      child: MenuCard(
                        function: () {},
                        description: "Tarefas".tr,
                        icon: Icons.task,
                        duration: 1,
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: _op,
                      duration: Duration(milliseconds: 1900),
                      curve: Curves.easeInCubic,
                      child: MenuCard(
                        function: () {
                          goToTimerScreen();
                        },
                        description: "Pomodoro".tr,
                        // icon: Icons.apple,
                        lottieURL: "assets/lotties/countdown.json",
                        duration: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FloatingActionButton.extended(
              heroTag: "config_button",
              elevation: null,
              isExtended: true,
              backgroundColor: theme.primaryColor,
              icon: Icon(Icons.settings, color: StudieTheme.whiteSmoke),
              label: FittedBox(
                child: Text("Config".tr, style: theme.textTheme.titleSmall),
              ),
              onPressed: () {},
              splashColor: theme.primaryColorLight,
            ),
            FloatingActionButton.extended(
              heroTag: "login_button",
              elevation: 10,
              isExtended: true,
              label: FittedBox(
                child: Text("Login".tr, style: theme.textTheme.titleSmall),
              ),
              backgroundColor: theme.primaryColor,
              icon: Icon(Icons.login, color: StudieTheme.whiteSmoke),
              onPressed: () {},
              splashColor: theme.primaryColorLight,
            ),
            FloatingActionButton.extended(
              heroTag: "help_button",
              elevation: null,
              isExtended: true,
              backgroundColor: theme.primaryColor,
              label: FittedBox(
                child: Text("Ajuda".tr, style: theme.textTheme.titleSmall),
              ),

              icon: Icon(
                Icons.help_outline_outlined,
                color: StudieTheme.whiteSmoke,
              ),
              onPressed: () {},
              splashColor: theme.primaryColorLight,
            ),
          ],
        ),
      ),
    );
  }
}
