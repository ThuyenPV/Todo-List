// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class LocalTask extends DataClass implements Insertable<LocalTask> {
  final int id;
  final String title;
  final String description;
  final int taskType;
  final DateTime dayOfTask;
  final bool isComplete;

  LocalTask({
    required this.id,
    required this.title,
    required this.description,
    required this.taskType,
    required this.dayOfTask,
    required this.isComplete,
  });

  factory LocalTask.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return LocalTask(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      description: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      taskType: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}taskType'])!,
      dayOfTask: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}dayOfTask'])!,
      isComplete: const BoolType().mapFromDatabaseResponse(data['${effectivePrefix}isComplete'])!,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['taskType'] = Variable<int>(taskType);
    map['dayOfTask'] = Variable<DateTime>(dayOfTask);
    map['isComplete'] = Variable<bool>(isComplete);
    return map;
  }

  TaskLocalEntitiesCompanion toCompanion(bool nullToAbsent) {
    return TaskLocalEntitiesCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      taskType: Value(taskType),
      dayOfTask: Value(dayOfTask),
      isComplete: Value(isComplete),
    );
  }

  factory LocalTask.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return LocalTask(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      taskType: serializer.fromJson<int>(json['taskType']),
      dayOfTask: serializer.fromJson<DateTime>(json['dayOfTask']),
      isComplete: serializer.fromJson<bool>(json['isComplete']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'taskType': serializer.toJson<int>(taskType),
      'dayOfTask': serializer.toJson<DateTime>(dayOfTask),
      'isComplete': serializer.toJson<bool>(isComplete),
    };
  }

  LocalTask copyWith(
          {int? id, String? title, String? description, int? taskType, DateTime? dayOfTask, bool? isComplete}) =>
      LocalTask(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        taskType: taskType ?? this.taskType,
        dayOfTask: dayOfTask ?? this.dayOfTask,
        isComplete: isComplete ?? this.isComplete,
      );

  @override
  String toString() {
    return (StringBuffer('LocalTask(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('taskType: $taskType, ')
          ..write('dayOfTask: $dayOfTask, ')
          ..write('isComplete: $isComplete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(title.hashCode,
          $mrjc(description.hashCode, $mrjc(taskType.hashCode, $mrjc(dayOfTask.hashCode, isComplete.hashCode))))));

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalTask &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.taskType == this.taskType &&
          other.dayOfTask == this.dayOfTask &&
          other.isComplete == this.isComplete);
}

class TaskLocalEntitiesCompanion extends UpdateCompanion<LocalTask> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> description;
  final Value<int> taskType;
  final Value<DateTime> dayOfTask;
  final Value<bool> isComplete;

  const TaskLocalEntitiesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.taskType = const Value.absent(),
    this.dayOfTask = const Value.absent(),
    this.isComplete = const Value.absent(),
  });

  TaskLocalEntitiesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String description,
    required int taskType,
    required DateTime dayOfTask,
    required bool isComplete,
  })  : title = Value(title),
        description = Value(description),
        taskType = Value(taskType),
        dayOfTask = Value(dayOfTask),
        isComplete = Value(isComplete);

  static Insertable<LocalTask> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? taskType,
    Expression<DateTime>? dayOfTask,
    Expression<bool>? isComplete,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'name': title,
      if (description != null) 'description': description,
      if (taskType != null) 'taskType': taskType,
      if (dayOfTask != null) 'dayOfTask': dayOfTask,
      if (isComplete != null) 'isComplete': isComplete,
    });
  }

  TaskLocalEntitiesCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? description,
      Value<int>? taskType,
      Value<DateTime>? dayOfTask,
      Value<bool>? isComplete}) {
    return TaskLocalEntitiesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      taskType: taskType ?? this.taskType,
      dayOfTask: dayOfTask ?? this.dayOfTask,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['name'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (taskType.present) {
      map['taskType'] = Variable<int>(taskType.value);
    }
    if (dayOfTask.present) {
      map['dayOfTask'] = Variable<DateTime>(dayOfTask.value);
    }
    if (isComplete.present) {
      map['isComplete'] = Variable<bool>(isComplete.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskLocalEntitiesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('taskType: $taskType, ')
          ..write('dayOfTask: $dayOfTask, ')
          ..write('isComplete: $isComplete')
          ..write(')'))
        .toString();
  }
}

class $TaskLocalEntitiesTable extends TaskLocalEntities with TableInfo<$TaskLocalEntitiesTable, LocalTask> {
  final GeneratedDatabase _db;
  final String? _alias;

  $TaskLocalEntitiesTable(this._db, [this._alias]);

  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>('id', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: false, defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String?> title =
      GeneratedColumn<String?>('name', aliasedName, false, typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta = const VerificationMeta('description');
  late final GeneratedColumn<String?> description =
      GeneratedColumn<String?>('description', aliasedName, false, typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _taskTypeMeta = const VerificationMeta('taskType');
  late final GeneratedColumn<int?> taskType =
      GeneratedColumn<int?>('taskType', aliasedName, false, typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _dayOfTaskMeta = const VerificationMeta('dayOfTask');
  late final GeneratedColumn<DateTime?> dayOfTask =
      GeneratedColumn<DateTime?>('dayOfTask', aliasedName, false, typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _isCompleteMeta = const VerificationMeta('isComplete');
  late final GeneratedColumn<bool?> isComplete = GeneratedColumn<bool?>('isComplete', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true, defaultConstraints: 'CHECK (isComplete IN (0, 1))');

  @override
  List<GeneratedColumn> get $columns => [id, title, description, taskType, dayOfTask, isComplete];

  @override
  String get aliasedName => _alias ?? 'DailyTaskDB';

  @override
  String get actualTableName => 'DailyTaskDB';

  @override
  VerificationContext validateIntegrity(Insertable<LocalTask> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(_titleMeta, title.isAcceptableOrUnknown(data['name']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(_descriptionMeta, description.isAcceptableOrUnknown(data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('taskType')) {
      context.handle(_taskTypeMeta, taskType.isAcceptableOrUnknown(data['taskType']!, _taskTypeMeta));
    } else if (isInserting) {
      context.missing(_taskTypeMeta);
    }
    if (data.containsKey('dayOfTask')) {
      context.handle(_dayOfTaskMeta, dayOfTask.isAcceptableOrUnknown(data['dayOfTask']!, _dayOfTaskMeta));
    } else if (isInserting) {
      context.missing(_dayOfTaskMeta);
    }
    if (data.containsKey('isComplete')) {
      context.handle(_isCompleteMeta, isComplete.isAcceptableOrUnknown(data['isComplete']!, _isCompleteMeta));
    } else if (isInserting) {
      context.missing(_isCompleteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  @override
  LocalTask map(Map<String, dynamic> data, {String? tablePrefix}) {
    return LocalTask.fromData(data, _db, prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TaskLocalEntitiesTable createAlias(String alias) {
    return $TaskLocalEntitiesTable(_db, alias);
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TaskLocalEntitiesTable taskLocalEntities = $TaskLocalEntitiesTable(this);
  late final TaskDao taskDao = TaskDao(this as LocalDatabase);

  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [taskLocalEntities];
}
