import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/di/injection.dart';
import 'package:todo_list/pages/task/new_task_page.dart';
import 'package:todo_list/blocs/fetch_tasks/manage_tasks_bloc.dart';
import 'widgets/task_completed.dart';
import 'widgets/task_of_weeks.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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
      floatingActionButton: const CustomFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TaskCompleted(),
            TaskOfWeeks(),
          ],
        ),
      ),
    );
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 66,
      width: 66,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: const Color(0xff00e1b5),
          onPressed: () => Navigator.push(context, NewTaskPage.route),
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
}
