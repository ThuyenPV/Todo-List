import 'package:moor/moor.dart';
import 'package:todo_list/data/models/daily_task.dart';
import 'package:todo_list/data/source/local/database/local_database.dart';

extension DateOnlyCompare on DailyTask {
  TaskLocalEntitiesCompanion get getTaskLocalEntity {
    return TaskLocalEntitiesCompanion(
      title: Value(this.title),
      description: Value(this.description),
      dayOfTask: Value(this.dayOfTask),
      isComplete: Value(this.isComplete),
      taskType: Value(this.taskType),
    );
  }
}
