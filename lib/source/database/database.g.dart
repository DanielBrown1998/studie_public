// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TableTasksTable extends TableTasks
    with TableInfo<$TableTasksTable, TableTask> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TableTasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<int> uid = GeneratedColumn<int>(
    'uid',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _disciplineMeta = const VerificationMeta(
    'discipline',
  );
  @override
  late final GeneratedColumn<String> discipline = GeneratedColumn<String>(
    'discipline',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 18,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 255),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checkedMeta = const VerificationMeta(
    'checked',
  );
  @override
  late final GeneratedColumn<bool> checked = GeneratedColumn<bool>(
    'checked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("checked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _daysWeekMeta = const VerificationMeta(
    'daysWeek',
  );
  @override
  late final GeneratedColumn<String> daysWeek = GeneratedColumn<String>(
    'daysWeek',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeStartMeta = const VerificationMeta(
    'timeStart',
  );
  @override
  late final GeneratedColumn<int> timeStart = GeneratedColumn<int>(
    'timeStart',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeEndMeta = const VerificationMeta(
    'timeEnd',
  );
  @override
  late final GeneratedColumn<int> timeEnd = GeneratedColumn<int>(
    'timeEnd',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    uid,
    discipline,
    description,
    checked,
    daysWeek,
    timeStart,
    timeEnd,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'table_tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<TableTask> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
        _uidMeta,
        uid.isAcceptableOrUnknown(data['uid']!, _uidMeta),
      );
    }
    if (data.containsKey('discipline')) {
      context.handle(
        _disciplineMeta,
        discipline.isAcceptableOrUnknown(data['discipline']!, _disciplineMeta),
      );
    } else if (isInserting) {
      context.missing(_disciplineMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('checked')) {
      context.handle(
        _checkedMeta,
        checked.isAcceptableOrUnknown(data['checked']!, _checkedMeta),
      );
    }
    if (data.containsKey('daysWeek')) {
      context.handle(
        _daysWeekMeta,
        daysWeek.isAcceptableOrUnknown(data['daysWeek']!, _daysWeekMeta),
      );
    } else if (isInserting) {
      context.missing(_daysWeekMeta);
    }
    if (data.containsKey('timeStart')) {
      context.handle(
        _timeStartMeta,
        timeStart.isAcceptableOrUnknown(data['timeStart']!, _timeStartMeta),
      );
    } else if (isInserting) {
      context.missing(_timeStartMeta);
    }
    if (data.containsKey('timeEnd')) {
      context.handle(
        _timeEndMeta,
        timeEnd.isAcceptableOrUnknown(data['timeEnd']!, _timeEndMeta),
      );
    } else if (isInserting) {
      context.missing(_timeEndMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid};
  @override
  TableTask map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TableTask(
      uid:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}uid'],
          )!,
      discipline:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}discipline'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
      checked:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}checked'],
          )!,
      daysWeek:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}daysWeek'],
          )!,
      timeStart:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}timeStart'],
          )!,
      timeEnd:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}timeEnd'],
          )!,
    );
  }

  @override
  $TableTasksTable createAlias(String alias) {
    return $TableTasksTable(attachedDatabase, alias);
  }
}

class TableTask extends DataClass implements Insertable<TableTask> {
  final int uid;
  final String discipline;
  final String description;
  final bool checked;
  final String daysWeek;
  final int timeStart;
  final int timeEnd;
  const TableTask({
    required this.uid,
    required this.discipline,
    required this.description,
    required this.checked,
    required this.daysWeek,
    required this.timeStart,
    required this.timeEnd,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<int>(uid);
    map['discipline'] = Variable<String>(discipline);
    map['description'] = Variable<String>(description);
    map['checked'] = Variable<bool>(checked);
    map['daysWeek'] = Variable<String>(daysWeek);
    map['timeStart'] = Variable<int>(timeStart);
    map['timeEnd'] = Variable<int>(timeEnd);
    return map;
  }

  TableTasksCompanion toCompanion(bool nullToAbsent) {
    return TableTasksCompanion(
      uid: Value(uid),
      discipline: Value(discipline),
      description: Value(description),
      checked: Value(checked),
      daysWeek: Value(daysWeek),
      timeStart: Value(timeStart),
      timeEnd: Value(timeEnd),
    );
  }

  factory TableTask.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TableTask(
      uid: serializer.fromJson<int>(json['uid']),
      discipline: serializer.fromJson<String>(json['discipline']),
      description: serializer.fromJson<String>(json['description']),
      checked: serializer.fromJson<bool>(json['checked']),
      daysWeek: serializer.fromJson<String>(json['daysWeek']),
      timeStart: serializer.fromJson<int>(json['timeStart']),
      timeEnd: serializer.fromJson<int>(json['timeEnd']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<int>(uid),
      'discipline': serializer.toJson<String>(discipline),
      'description': serializer.toJson<String>(description),
      'checked': serializer.toJson<bool>(checked),
      'daysWeek': serializer.toJson<String>(daysWeek),
      'timeStart': serializer.toJson<int>(timeStart),
      'timeEnd': serializer.toJson<int>(timeEnd),
    };
  }

  TableTask copyWith({
    int? uid,
    String? discipline,
    String? description,
    bool? checked,
    String? daysWeek,
    int? timeStart,
    int? timeEnd,
  }) => TableTask(
    uid: uid ?? this.uid,
    discipline: discipline ?? this.discipline,
    description: description ?? this.description,
    checked: checked ?? this.checked,
    daysWeek: daysWeek ?? this.daysWeek,
    timeStart: timeStart ?? this.timeStart,
    timeEnd: timeEnd ?? this.timeEnd,
  );
  TableTask copyWithCompanion(TableTasksCompanion data) {
    return TableTask(
      uid: data.uid.present ? data.uid.value : this.uid,
      discipline:
          data.discipline.present ? data.discipline.value : this.discipline,
      description:
          data.description.present ? data.description.value : this.description,
      checked: data.checked.present ? data.checked.value : this.checked,
      daysWeek: data.daysWeek.present ? data.daysWeek.value : this.daysWeek,
      timeStart: data.timeStart.present ? data.timeStart.value : this.timeStart,
      timeEnd: data.timeEnd.present ? data.timeEnd.value : this.timeEnd,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TableTask(')
          ..write('uid: $uid, ')
          ..write('discipline: $discipline, ')
          ..write('description: $description, ')
          ..write('checked: $checked, ')
          ..write('daysWeek: $daysWeek, ')
          ..write('timeStart: $timeStart, ')
          ..write('timeEnd: $timeEnd')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    uid,
    discipline,
    description,
    checked,
    daysWeek,
    timeStart,
    timeEnd,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TableTask &&
          other.uid == this.uid &&
          other.discipline == this.discipline &&
          other.description == this.description &&
          other.checked == this.checked &&
          other.daysWeek == this.daysWeek &&
          other.timeStart == this.timeStart &&
          other.timeEnd == this.timeEnd);
}

class TableTasksCompanion extends UpdateCompanion<TableTask> {
  final Value<int> uid;
  final Value<String> discipline;
  final Value<String> description;
  final Value<bool> checked;
  final Value<String> daysWeek;
  final Value<int> timeStart;
  final Value<int> timeEnd;
  const TableTasksCompanion({
    this.uid = const Value.absent(),
    this.discipline = const Value.absent(),
    this.description = const Value.absent(),
    this.checked = const Value.absent(),
    this.daysWeek = const Value.absent(),
    this.timeStart = const Value.absent(),
    this.timeEnd = const Value.absent(),
  });
  TableTasksCompanion.insert({
    this.uid = const Value.absent(),
    required String discipline,
    required String description,
    this.checked = const Value.absent(),
    required String daysWeek,
    required int timeStart,
    required int timeEnd,
  }) : discipline = Value(discipline),
       description = Value(description),
       daysWeek = Value(daysWeek),
       timeStart = Value(timeStart),
       timeEnd = Value(timeEnd);
  static Insertable<TableTask> custom({
    Expression<int>? uid,
    Expression<String>? discipline,
    Expression<String>? description,
    Expression<bool>? checked,
    Expression<String>? daysWeek,
    Expression<int>? timeStart,
    Expression<int>? timeEnd,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (discipline != null) 'discipline': discipline,
      if (description != null) 'description': description,
      if (checked != null) 'checked': checked,
      if (daysWeek != null) 'daysWeek': daysWeek,
      if (timeStart != null) 'timeStart': timeStart,
      if (timeEnd != null) 'timeEnd': timeEnd,
    });
  }

  TableTasksCompanion copyWith({
    Value<int>? uid,
    Value<String>? discipline,
    Value<String>? description,
    Value<bool>? checked,
    Value<String>? daysWeek,
    Value<int>? timeStart,
    Value<int>? timeEnd,
  }) {
    return TableTasksCompanion(
      uid: uid ?? this.uid,
      discipline: discipline ?? this.discipline,
      description: description ?? this.description,
      checked: checked ?? this.checked,
      daysWeek: daysWeek ?? this.daysWeek,
      timeStart: timeStart ?? this.timeStart,
      timeEnd: timeEnd ?? this.timeEnd,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<int>(uid.value);
    }
    if (discipline.present) {
      map['discipline'] = Variable<String>(discipline.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (checked.present) {
      map['checked'] = Variable<bool>(checked.value);
    }
    if (daysWeek.present) {
      map['daysWeek'] = Variable<String>(daysWeek.value);
    }
    if (timeStart.present) {
      map['timeStart'] = Variable<int>(timeStart.value);
    }
    if (timeEnd.present) {
      map['timeEnd'] = Variable<int>(timeEnd.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TableTasksCompanion(')
          ..write('uid: $uid, ')
          ..write('discipline: $discipline, ')
          ..write('description: $description, ')
          ..write('checked: $checked, ')
          ..write('daysWeek: $daysWeek, ')
          ..write('timeStart: $timeStart, ')
          ..write('timeEnd: $timeEnd')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDataBase extends GeneratedDatabase {
  _$AppDataBase(QueryExecutor e) : super(e);
  $AppDataBaseManager get managers => $AppDataBaseManager(this);
  late final $TableTasksTable tableTasks = $TableTasksTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tableTasks];
}

typedef $$TableTasksTableCreateCompanionBuilder =
    TableTasksCompanion Function({
      Value<int> uid,
      required String discipline,
      required String description,
      Value<bool> checked,
      required String daysWeek,
      required int timeStart,
      required int timeEnd,
    });
typedef $$TableTasksTableUpdateCompanionBuilder =
    TableTasksCompanion Function({
      Value<int> uid,
      Value<String> discipline,
      Value<String> description,
      Value<bool> checked,
      Value<String> daysWeek,
      Value<int> timeStart,
      Value<int> timeEnd,
    });

class $$TableTasksTableFilterComposer
    extends Composer<_$AppDataBase, $TableTasksTable> {
  $$TableTasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get discipline => $composableBuilder(
    column: $table.discipline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get checked => $composableBuilder(
    column: $table.checked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get daysWeek => $composableBuilder(
    column: $table.daysWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timeStart => $composableBuilder(
    column: $table.timeStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timeEnd => $composableBuilder(
    column: $table.timeEnd,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TableTasksTableOrderingComposer
    extends Composer<_$AppDataBase, $TableTasksTable> {
  $$TableTasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get discipline => $composableBuilder(
    column: $table.discipline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get checked => $composableBuilder(
    column: $table.checked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get daysWeek => $composableBuilder(
    column: $table.daysWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timeStart => $composableBuilder(
    column: $table.timeStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timeEnd => $composableBuilder(
    column: $table.timeEnd,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TableTasksTableAnnotationComposer
    extends Composer<_$AppDataBase, $TableTasksTable> {
  $$TableTasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get discipline => $composableBuilder(
    column: $table.discipline,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get checked =>
      $composableBuilder(column: $table.checked, builder: (column) => column);

  GeneratedColumn<String> get daysWeek =>
      $composableBuilder(column: $table.daysWeek, builder: (column) => column);

  GeneratedColumn<int> get timeStart =>
      $composableBuilder(column: $table.timeStart, builder: (column) => column);

  GeneratedColumn<int> get timeEnd =>
      $composableBuilder(column: $table.timeEnd, builder: (column) => column);
}

class $$TableTasksTableTableManager
    extends
        RootTableManager<
          _$AppDataBase,
          $TableTasksTable,
          TableTask,
          $$TableTasksTableFilterComposer,
          $$TableTasksTableOrderingComposer,
          $$TableTasksTableAnnotationComposer,
          $$TableTasksTableCreateCompanionBuilder,
          $$TableTasksTableUpdateCompanionBuilder,
          (
            TableTask,
            BaseReferences<_$AppDataBase, $TableTasksTable, TableTask>,
          ),
          TableTask,
          PrefetchHooks Function()
        > {
  $$TableTasksTableTableManager(_$AppDataBase db, $TableTasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$TableTasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$TableTasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$TableTasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> uid = const Value.absent(),
                Value<String> discipline = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<bool> checked = const Value.absent(),
                Value<String> daysWeek = const Value.absent(),
                Value<int> timeStart = const Value.absent(),
                Value<int> timeEnd = const Value.absent(),
              }) => TableTasksCompanion(
                uid: uid,
                discipline: discipline,
                description: description,
                checked: checked,
                daysWeek: daysWeek,
                timeStart: timeStart,
                timeEnd: timeEnd,
              ),
          createCompanionCallback:
              ({
                Value<int> uid = const Value.absent(),
                required String discipline,
                required String description,
                Value<bool> checked = const Value.absent(),
                required String daysWeek,
                required int timeStart,
                required int timeEnd,
              }) => TableTasksCompanion.insert(
                uid: uid,
                discipline: discipline,
                description: description,
                checked: checked,
                daysWeek: daysWeek,
                timeStart: timeStart,
                timeEnd: timeEnd,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TableTasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataBase,
      $TableTasksTable,
      TableTask,
      $$TableTasksTableFilterComposer,
      $$TableTasksTableOrderingComposer,
      $$TableTasksTableAnnotationComposer,
      $$TableTasksTableCreateCompanionBuilder,
      $$TableTasksTableUpdateCompanionBuilder,
      (TableTask, BaseReferences<_$AppDataBase, $TableTasksTable, TableTask>),
      TableTask,
      PrefetchHooks Function()
    >;

class $AppDataBaseManager {
  final _$AppDataBase _db;
  $AppDataBaseManager(this._db);
  $$TableTasksTableTableManager get tableTasks =>
      $$TableTasksTableTableManager(_db, _db.tableTasks);
}
