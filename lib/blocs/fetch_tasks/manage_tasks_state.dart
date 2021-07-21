import '../blocs.dart';
import 'package:todo_list/data/models/daily_task.dart';

class SearchTaskSuccessState extends BaseState {
  final List<DailyTask> tasks;
  final bool isHasNext;

  SearchTaskSuccessState({
    this.tasks = const [],
    this.isHasNext = false,
  });

  @override
  List<Object?> get props => [tasks, isHasNext];
}

class GetLocalTasksSuccessState extends BaseState {
  final List<DailyTask> tasks;

  GetLocalTasksSuccessState({
    this.tasks = const [],
  });

  @override
  List<Object?> get props => [tasks];
}

class InsertLocalTaskSuccessState extends BaseState {
  @override
  List<Object?> get props => [DateTime.now().microsecondsSinceEpoch];
}

class UpdateLocalTaskSuccessState extends BaseState {
  @override
  List<Object?> get props => [DateTime.now().microsecondsSinceEpoch];
}
