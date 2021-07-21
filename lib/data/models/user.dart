import 'package:equatable/equatable.dart';
import 'package:todo_list/data/source/local/database/local_database.dart';

class DailyTask extends Equatable {
  int? id;
  final String title;
  final String description;
  final int taskType; //0: Work, 1: Home, 2: Personal
  final DateTime completionDate;

  DailyTask({
    this.id,
    required this.title,
    required this.description,
    required this.taskType,
    required this.completionDate,
  });

  factory DailyTask.fromLocal(LocalTask task) {
    return DailyTask(
      id: task.id,
      title: task.title,
      description: task.description,
      taskType: task.taskType,
      completionDate: task.completionDate,
    );
  }

  bool get isComplete => completionDate.isBefore(DateTime.now());

  @override
  List<Object?> get props => [id, title, description];
}
