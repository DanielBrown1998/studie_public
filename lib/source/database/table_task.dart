part of 'database.dart';

class TableTasks extends Table{
  IntColumn get uid => integer().named("uid").autoIncrement()();
  TextColumn get discipline =>
      text().named("discipline").withLength(min: 3, max: 18)();
  TextColumn get description =>
      text().named("description").withLength(max: 255)();
  BoolColumn get checked => boolean().withDefault(const Constant(false)).named("checked")();
  TextColumn get daysWeek => text().named("daysWeek")();
  IntColumn get timeStart => integer().named("timeStart")();
  IntColumn get timeEnd => integer().named("timeEnd")();

}
