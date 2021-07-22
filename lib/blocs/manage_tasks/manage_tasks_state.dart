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
  final int timestamp;

  GetLocalTasksSuccessState({
    this.tasks = const [],
    required this.timestamp,
  });

  @override
  List<Object?> get props => [tasks, timestamp];
}

class InsertLocalTaskSuccessState extends BaseState {
  @override
  List<Object?> get props => [];
}

class UpdateLocalTaskSuccessState extends BaseState {
  @override
  List<Object?> get props => [];
}
