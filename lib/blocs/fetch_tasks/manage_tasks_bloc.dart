import 'package:todo_list/blocs/fetch_tasks/manage_tasks_state.dart';
import 'package:todo_list/data/models/daily_task.dart';
import 'package:todo_list/di/injection.dart';
import 'package:todo_list/repositories/task_repository.dart';

import '../blocs.dart';

class ManageTaskBloc extends BaseBloc with SingleBlocMixin {
  final TaskRepository _userRepository = getIt<TaskRepository>();

  void getLocalTasks() {
    single<List<DailyTask>>(
      () => _userRepository.getAllTasksFromLocal(),
      onSuccess: (data) => GetLocalTasksSuccessState(
        tasks: data,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  void insertLocalTask(DailyTask task) {
    single(
      () => _userRepository.insertTaskToLocal(task),
      onSuccess: (_) => InsertLocalTaskSuccessState(),
    );
  }

  void updateLocalTask(DailyTask task) {
    single<bool>(
      () => _userRepository.updateTask(task),
      onSuccess: (_) => UpdateLocalTaskSuccessState(),
    );
  }
}
