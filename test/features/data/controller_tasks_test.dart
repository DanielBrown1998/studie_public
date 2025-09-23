import 'package:app/features/data/source/database/database.dart'
    as package_database;
import 'package:app/features/domain/entities/task.dart';
import 'package:app/features/data/repository/tasks_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'controller_tasks_test.mocks.dart';

@GenerateNiceMocks([MockSpec<package_database.AppDataBase>()])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late TaskRepositoryImpl controller;
  late MockAppDataBase mockDatabase;

  setUp(() {
    mockDatabase = MockAppDataBase();
    controller = TaskRepositoryImpl(database: mockDatabase);
  });

  group('ControllerTask Tests', () {
    test('initializeController should fetch and set tasks and nome', () async {
      final tasks = [
        Task(
          daysWeek: 'Segunda',
          timeStart: 1,
          timeEnd: 2,
          description: 'Task 1',
          discipline: 'Discipline 1',
          checked: false,
        ),
      ];
      when(
        mockDatabase.getTasksByWeekDay(weekdays: 'Segunda'),
      ).thenAnswer((_) async => tasks);

      await controller.initializeController(nome: 'Segunda', required: null);

      expect(controller.tasks, tasks);
      expect(controller.nome.value, 'Segunda');
    });

    test(
      'checkIfHasTaskThisHour should return false if a task already exists at that time',
      () async {
        final existingTask = Task(
          daysWeek: 'Segunda',
          timeStart: 1,
          timeEnd: 2,
          description: 'Existing Task',
          discipline: 'Discipline',
          checked: false,
        );
        when(
          mockDatabase.getTasksByWeekDay(weekdays: 'Segunda'),
        ).thenAnswer((_) async => [existingTask]);

        final newTask = Task(
          daysWeek: 'Segunda',
          timeStart: 1,
          timeEnd: 2,
          description: 'New Task',
          discipline: 'Discipline',
          checked: false,
        );
        final result = await controller.checkIfHasTaskThisHour(newTask);

        expect(result, isFalse);
      },
    );

    test(
      'checkIfHasTaskThisHour should return true if no task exists at that time',
      () async {
        when(
          mockDatabase.getTasksByWeekDay(weekdays: 'Segunda'),
        ).thenAnswer((_) async => []);

        final newTask = Task(
          daysWeek: 'Segunda',
          timeStart: 1,
          timeEnd: 2,
          description: 'New Task',
          discipline: 'Discipline',
          checked: false,
        );
        final result = await controller.checkIfHasTaskThisHour(newTask);

        expect(result, isTrue);
      },
    );

    test(
      'createTask should create and add tasks when no conflict exists',
      () async {
        final task = Task(
          daysWeek: 'Segunda',
          timeStart: 1,
          timeEnd: 3,
          description: 'Task',
          discipline: 'Discipline',
          checked: false,
        );
        when(
          mockDatabase.getTasksByWeekDay(weekdays: 'Segunda'),
        ).thenAnswer((_) async => []);
        when(mockDatabase.createTask(task: task)).thenAnswer((_) async => 1);

        final result = await controller.createTask(task: task);

        expect(result, 2);
        expect(controller.tasks.length, 2);
      },
    );

    test('createTask should not create tasks when a conflict exists', () async {
      final existingTask = Task(
        daysWeek: 'Segunda',
        timeStart: 1,
        timeEnd: 2,
        description: 'Existing Task',
        discipline: 'Discipline',
        checked: false,
      );
      final task = Task(
        daysWeek: 'Segunda',
        timeStart: 1,
        timeEnd: 3,
        description: 'Task',
        discipline: 'Discipline',
        checked: false,
      );

      when(
        mockDatabase.getTasksByWeekDay(weekdays: 'Segunda'),
      ).thenAnswer((_) async => [existingTask]);

      final result = await controller.createTask(task: task);

      expect(result, 1);
      expect(controller.tasks.length, 1);
      verifyNever(mockDatabase.createTask(task: task));
    });

    test('deleteTask should remove the task and call database', () async {
      final task = Task(
        daysWeek: 'Segunda',
        timeStart: 1,
        timeEnd: 2,
        description: 'Task 1',
        discipline: 'Discipline 1',
        checked: false,
      );
      controller.tasks.add(task);
      when(mockDatabase.deleteTask(task: task)).thenAnswer((_) async => 1);

      final result = await controller.deleteTask(task: task);

      expect(result, 1);
      expect(controller.tasks.isEmpty, isTrue);
      verify(mockDatabase.deleteTask(task: task)).called(1);
    });

    test('getTasksByWeekDay should return tasks from database', () async {
      final tasks = [
        Task(
          daysWeek: 'Segunda',
          timeStart: 1,
          timeEnd: 2,
          description: 'Task 1',
          discipline: 'Discipline 1',
          checked: false,
        ),
      ];
      when(
        mockDatabase.getTasksByWeekDay(weekdays: 'Segunda'),
      ).thenAnswer((_) async => tasks);

      final result = await controller.getTasksByWeekDay(weekdays: 'Segunda');

      expect(result, tasks);
    });

    test('setTaskChecked should call database', () async {
      final task = Task(
        daysWeek: 'Segunda',
        timeStart: 1,
        timeEnd: 2,
        description: 'Task 1',
        discipline: 'Discipline 1',
        checked: false,
      );
      when(
        mockDatabase.setTaskChecked(task: task),
      ).thenAnswer((_) async => true);

      final result = await controller.setTaskChecked(task: task);

      expect(result, isTrue);
      verify(mockDatabase.setTaskChecked(task: task)).called(1);
    });

    test('updateTask should call database and return updated task', () async {
      final task = Task(
        daysWeek: 'Segunda',
        timeStart: 1,
        timeEnd: 2,
        description: 'Task 1',
        discipline: 'Discipline 1',
        checked: false,
      );
      final updatedTask = Task(
        daysWeek: 'Segunda',
        timeStart: 1,
        timeEnd: 2,
        description: 'Updated Task',
        discipline: 'Discipline 1',
        checked: false,
      );

      when(
        mockDatabase.updateTask(task: task),
      ).thenAnswer((_) async => updatedTask);

      final result = await controller.updateTask(task: task);

      expect(result, updatedTask);
      verify(mockDatabase.updateTask(task: task)).called(1);
    });
  });
}
