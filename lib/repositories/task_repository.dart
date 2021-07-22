import 'package:todo_list/di/injection.dart';
import 'package:todo_list/data/models/daily_task.dart';
import 'package:todo_list/repositories/repositories.dart';
import 'package:todo_list/data/source/local/datasources/local_user_datasource.dart';

abstract class TaskRepository extends BaseRepository {
  Future<List<DailyTask>> getAllTasksFromLocal();

  Future insertTaskToLocal(DailyTask task);

  Future<bool> updateTask(DailyTask task);
}

class TaskRepositoryImpl extends TaskRepository {
  final TaskLocalDataSource _taskLocalDataSource;

  TaskRepositoryImpl() : _taskLocalDataSource = getIt<TaskLocalDataSource>();

  @override
  Future<List<DailyTask>> getAllTasksFromLocal() {
    return _taskLocalDataSource.getAllTasks();
  }

  @override
  Future insertTaskToLocal(DailyTask task) {
    return _taskLocalDataSource.insertTask(task);
  }

  @override
  Future<bool> updateTask(DailyTask task) {
    return _taskLocalDataSource.updateTask(task);
  }
}
