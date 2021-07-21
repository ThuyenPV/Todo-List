import 'package:moor/moor.dart';

@DataClassName('LocalTask')
class TaskLocalEntities extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().named('name')();

  TextColumn get description => text().named('description')();

  IntColumn get taskType => integer().named('taskType')();

  DateTimeColumn get completionDate => dateTime().named('completionDate')();

  @override
  String get tableName => "DailyTaskDB";
}
