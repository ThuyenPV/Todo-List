import 'package:moor/moor.dart';

@DataClassName('LocalTask')
class TaskLocalEntities extends Table {
  IntColumn get id => integer().named('id')();

  TextColumn get title => text().named('name')();

  TextColumn get description => text().named('description')();

  IntColumn get taskType => intEnum().named('taskType')();

  DateTimeColumn get completionDate => dateTime().named('completionDate')();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => "DailyTaskDB";
}
