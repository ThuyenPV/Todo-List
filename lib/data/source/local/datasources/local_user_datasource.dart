import 'package:moor/moor.dart';
import 'package:todo_list/di/injection.dart';
import 'package:todo_list/data/models/daily_task.dart';
import 'package:todo_list/data/source/local/database/local_database.dart';
import 'package:todo_list/core/extensions/local_entity_extension.dart';

abstract class TaskLocalDataSource {
  Future<List<DailyTask>> getAllTasks();

  Future saveAllTasks(List<DailyTask> tasks);

  Future insertTask(DailyTask task);

  Future<bool> updateTask(DailyTask task);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final LocalDatabase _localDatabase;

  TaskLocalDataSourceImpl() : _localDatabase = getIt<LocalDatabase>();

  @override
  Future<List<DailyTask>> getAllTasks() {
    return _localDatabase.taskDao.allTasks;
  }

  @override
  Future saveAllTasks(List<DailyTask> tasks) async {
    for (var i = 0; i < tasks.length; i++) {
      await _localDatabase.taskDao.insertOne(tasks[i].getTaskLocalEntity);
    }
  }

  @override
  Future insertTask(DailyTask task) {
    return _localDatabase.taskDao.insertOne(task.getTaskLocalEntity);
  }

  @override
  Future<bool> updateTask(DailyTask task) async {
    var updateRows = await _localDatabase.taskDao.updateWhere(
      [
        (e) => e.id.equals(task.id),
        (e) => e.title.equals(task.title),
      ],
      TaskLocalEntitiesCompanion(
        isComplete: Value(task.isComplete),
      ),
    );
    return updateRows > 0;
  }
}
