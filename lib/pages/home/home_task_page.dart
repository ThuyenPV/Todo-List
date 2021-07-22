import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_list/blocs/blocs.dart';
import 'package:todo_list/blocs/fetch_tasks/manage_tasks_state.dart';
import 'package:todo_list/data/models/daily_task.dart';
import 'package:todo_list/data/source/local/database/local_database.dart';
import 'package:todo_list/di/injection.dart';
import 'package:todo_list/pages/task/new_task_page.dart';
import 'package:todo_list/blocs/fetch_tasks/manage_tasks_bloc.dart';
import 'package:todo_list/widget/task_inherited_widget.dart';
import 'widgets/task_completed.dart';
import 'widgets/task_of_weeks.dart';
import 'package:todo_list/core/extensions/extension.dart';

class HomeTaskPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeTaskPageState();
}

class HomeTaskPageState extends State<HomeTaskPage> {
  late ManageTaskBloc _manageTaskBloc;
  late List<DailyTask> _currentDailyTasks = [];
  late ValueNotifier<int> _amountOfTaskNotifier;

  @override
  void initState() {
    super.initState();
    _manageTaskBloc = getIt<ManageTaskBloc>()..getLocalTasks();
    _amountOfTaskNotifier = ValueNotifier(0);
  }

  @override
  void dispose() {
    _manageTaskBloc.close();
    super.dispose();
  }

  void _onTapCompleteTask(DailyTask taskSelected) {
    for (var i = 0; i < _currentDailyTasks.length; i++) {
      if (_currentDailyTasks[i].compareTo(taskSelected)) {
        _amountOfTaskNotifier.value++;
      }
    }
  }

  void _onRefresh() {
    for (var i = 0; i < _currentDailyTasks.length; i++) {
      if (_currentDailyTasks[i].isComplete) {
        _amountOfTaskNotifier.value++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: _buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: BlocBuilder(
          bloc: _manageTaskBloc,
          builder: (context, state) {
            switch (state.runtimeType) {
              case InProgressState:
                return const Center(child: CircularProgressIndicator());
              case GetLocalTasksSuccessState:
                _currentDailyTasks = _getCurrentTaskByDate((state as GetLocalTasksSuccessState).tasks);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _amountOfTaskNotifier,
                      builder: (_, int amountOfTaskComplete, __) {
                        return TaskCompleted(
                          amountOfTaskComplete: amountOfTaskComplete,
                          totalTasks: _currentDailyTasks.length,
                        );
                      },
                    ),
                    TaskInheritedWidget(
                      onRefresh: _onRefresh,
                      onTapCompleteTask: _onTapCompleteTask,
                      child: TaskOfWeeks(
                        tasks: state.tasks,
                      ),
                    ),
                  ],
                );
              default:
                Fluttertoast.showToast(
                    msg: (state as ErrorState).exception.message,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
                break;
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  List<DailyTask> _getCurrentTaskByDate(List<DailyTask> dailyTasks) {
    return dailyTasks.where((it) => it.dayOfTask.isSameDate(DateTime.now())).toList();
  }

  SizedBox _buildFloatingActionButton(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: const Color(0xff00e1b5),
          onPressed: () => Navigator.push(context, NewTaskPage.route).then(onRefreshTasks),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(100.0),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff00e1b5).withOpacity(0.4),
                  spreadRadius: 10,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 35,
            ),
          ),
        ),
      ),
    );
  }

  FutureOr onRefreshTasks(dynamic value) {
    setState(() {
      _manageTaskBloc.getLocalTasks();
    });
  }
}
