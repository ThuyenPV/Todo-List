import 'package:todo_list/di/injection.dart';
import 'package:todo_list/data/models/user.dart';
import 'package:todo_list/repositories/repositories.dart';
import 'package:todo_list/data/source/local/datasources/local_user_datasource.dart';

abstract class TaskRepository extends BaseRepository {
  Future<List<DailyTask>> getAllTasksFromLocal();
}

class TaskRepositoryImpl extends TaskRepository {
  final TaskLocalDataSource _userLocalDataSource;

  TaskRepositoryImpl() : _userLocalDataSource = getIt<TaskLocalDataSource>();

  @override
  Future<List<DailyTask>> getAllTasksFromLocal() {
    return _userLocalDataSource.getAllTasks();
  }
}
