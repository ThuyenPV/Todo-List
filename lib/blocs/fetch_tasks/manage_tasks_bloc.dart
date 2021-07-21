import 'package:todo_list/blocs/fetch_tasks/manage_tasks_state.dart';
import 'package:todo_list/data/models/user.dart';
import 'package:todo_list/di/injection.dart';
import 'package:todo_list/repositories/user_repository.dart';

import '../blocs.dart';

class ManageTaskBloc extends BaseBloc with SingleBlocMixin {
  final TaskRepository _userRepository = getIt<TaskRepository>();

  void getLocalTasks() {
    single<List<DailyTask>>(
      () => _userRepository.getAllTasksFromLocal(),
      onSuccess: (data) => GetLocalTasksSuccessState(tasks: data),
    );
  }

  void insertLocalTask(DailyTask task) {
    single(
      () => _userRepository.insertTaskToLocal(task),
      onSuccess: (data) {
        return InsertLocalTaskSuccessState(isSuccess: true);
      },
    );
  }
}
