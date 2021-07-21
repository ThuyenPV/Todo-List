import 'package:equatable/equatable.dart';
import 'package:todo_list/data/source/local/database/local_database.dart';

class DailyTask extends Equatable {
  int? id;
  final String title;
  final String description;
  final int taskType; //0: Work, 1: Home, 2: Personal
  final DateTime dayOfTask;
  bool isComplete;

  DailyTask({
    this.id,
    required this.title,
    required this.description,
    required this.taskType,
    required this.dayOfTask,
    this.isComplete = false,
  });

  factory DailyTask.fromLocal(LocalTask task) {
    return DailyTask(
      id: task.id,
      title: task.title,
      description: task.description,
      taskType: task.taskType,
      dayOfTask: task.dayOfTask,
      isComplete: task.isComplete,
    );
  }

  factory DailyTask.copy(DailyTask task) {
    return DailyTask(
      id: task.id,
      title: task.title,
      description: task.description,
      taskType: task.taskType,
      dayOfTask: task.dayOfTask,
      isComplete: task.isComplete,
    );
  }

  bool compareTo(DailyTask task) {
    return id == task.id;
  }

  @override
  List<Object?> get props => [id, title, description];
}
