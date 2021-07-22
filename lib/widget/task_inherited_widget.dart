import 'package:flutter/material.dart';
import 'package:todo_list/data/models/daily_task.dart';

class TaskInheritedWidget extends InheritedWidget {
  final Widget child;
  final Function(DailyTask dailyTask) onTapCompleteTask;

  const TaskInheritedWidget({
    Key? key,
    required this.child,
    required this.onTapCompleteTask,
  }) : super(key: key, child: child);

  static TaskInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskInheritedWidget>();
  }

  @override
  bool updateShouldNotify(TaskInheritedWidget oldWidget) {
    return true;
  }
}
