import 'package:todo_list/di/injection.dart';
import 'package:todo_list/data/models/daily_task.dart';
import 'package:todo_list/data/source/local/database/local_database.dart';

abstract class TaskLocalDataSource {
  Future<List<DailyTask>> getAllTasks();

  Future saveAllTasks(List<DailyTask> tasks);

  Future insertTask(DailyTask task);

  Future updateTask(DailyTask task);
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
    // TODO: Temporary
    for (int i = 0; i < tasks.length; i++) {
      await _localDatabase.taskDao.insertTask(tasks[i]);
    }
  }

  @override
  Future insertTask(DailyTask task) {
    return _localDatabase.taskDao.insertTask(task);
  }

  @override
  Future updateTask(DailyTask task) {
    return _localDatabase.taskDao.updateTask(task);
  }
}
