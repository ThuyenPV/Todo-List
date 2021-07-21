import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_list/blocs/blocs.dart';
import 'package:todo_list/blocs/fetch_tasks/manage_tasks_state.dart';
import 'package:todo_list/di/injection.dart';
import 'package:todo_list/pages/task/new_task_page.dart';
import 'package:todo_list/blocs/fetch_tasks/manage_tasks_bloc.dart';
import 'widgets/task_completed.dart';
import 'widgets/task_of_weeks.dart';

class HomeTaskPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeTaskPageState();
}

class HomeTaskPageState extends State<HomeTaskPage> {
  late ManageTaskBloc _manageTaskBloc;

  @override
  void initState() {
    super.initState();
    _manageTaskBloc = getIt<ManageTaskBloc>()..getLocalTasks();
  }

  @override
  void dispose() {
    _manageTaskBloc.close();
    super.dispose();
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TaskCompleted(),
                    TaskOfWeeks(
                      tasks: (state as GetLocalTasksSuccessState).tasks,
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

  SizedBox _buildFloatingActionButton(BuildContext context) {
    return SizedBox(
      height: 66,
      width: 66,
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
    _manageTaskBloc.getLocalTasks();
  }
}
