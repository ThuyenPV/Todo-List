import 'package:flutter/material.dart';
import 'package:todo_list/blocs/fetch_tasks/manage_tasks_bloc.dart';
import 'package:todo_list/data/models/daily_task.dart';
import 'package:todo_list/di/injection.dart';
import 'package:todo_list/widget/circle_painter.dart';
import 'package:todo_list/widget/task_inherited_widget.dart';

class TaskItem extends StatelessWidget {
  final DailyTask dailyTask;

  const TaskItem({
    Key? key,
    required this.dailyTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TaskSelected(
            dailyTask: dailyTask,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: getCircleDecorationByTask(dailyTask.taskType),
                  ),
                  Text(
                    dailyTask.title,
                    style: const TextStyle(
                      color: Color(0xff4e4e4e),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Text(
                dailyTask.description,
                style: const TextStyle(
                  color: Color(0xff9c9c9c),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration getCircleDecorationByTask(int taskIndex) {
    switch (taskIndex) {
      case 1:
        return BoxDecoration(
          color: const Color(0xff00a9ff),
          borderRadius: BorderRadius.circular(10.0),
        );
      case 2:
        return BoxDecoration(
          color: const Color(0xff0dd5b8),
          borderRadius: BorderRadius.circular(10.0),
        );
      case 0:
      default:
        return BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10.0),
        );
    }
  }
}

class TaskSelected extends StatefulWidget {
  final DailyTask dailyTask;

  const TaskSelected({
    Key? key,
    required this.dailyTask,
  }) : super(key: key);

  @override
  _TaskSelectedState createState() => _TaskSelectedState();
}

class _TaskSelectedState extends State<TaskSelected> {
  late ValueNotifier<bool> _isCompletedTask;
  late ManageTaskBloc _manageTaskBloc;

  @override
  void initState() {
    super.initState();
    _isCompletedTask = ValueNotifier(false);
    _manageTaskBloc = getIt<ManageTaskBloc>();
  }

  @override
  void dispose() {
    _isCompletedTask.dispose();
    _manageTaskBloc.close();
    super.dispose();
  }

  DailyTask get dailyTask => widget.dailyTask;

  @override
  Widget build(BuildContext context) {
    final taskState = TaskInheritedWidget.of(context);
    return ValueListenableBuilder(
      valueListenable: _isCompletedTask,
      builder: (_, bool isComplete, __) {
        return GestureDetector(
          onTap: () {
            _isCompletedTask.value = !isComplete;
            final _dailyTask = DailyTask.copy(dailyTask);
            _dailyTask.isComplete = !isComplete;
            _manageTaskBloc.updateLocalTask(_dailyTask);
            taskState!.onTapCompleteTask(_dailyTask);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: 40,
              height: 40,
              child: isComplete
                  ? const Icon(
                      Icons.done_sharp,
                      size: 50,
                      color: Color(0xff02e1b6),
                    )
                  : CustomPaint(painter: CirclePainter()),
            ),
          ),
        );
      },
    );
  }
}
