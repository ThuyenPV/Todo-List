import '../blocs.dart';
import 'package:todo_list/data/models/user.dart';

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
