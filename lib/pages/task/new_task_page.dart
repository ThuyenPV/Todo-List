import 'package:flutter/material.dart';
import 'package:todo_list/blocs/fetch_tasks/manage_tasks_bloc.dart';
import 'package:todo_list/core/resources/app_colors.dart';
import 'package:todo_list/data/models/user.dart';
import 'package:todo_list/di/injection.dart';

import 'widgets/add_new_task.dart';
import 'widgets/task_and_date_selection.dart';

class NewTaskPage extends StatefulWidget {
  NewTaskPage({Key? key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (BuildContext context) => NewTaskPage(),
      );

  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  late String _title = '';
  late String _description = '';
  late int _taskTypeIndex = 0;
  late String _dateCompletion = DateTime.now().toString();
  late final ManageTaskBloc _manageTaskBloc;

  @override
  void initState() {
    super.initState();
    _manageTaskBloc = getIt<ManageTaskBloc>();
  }

  @override
  void dispose() {
    _manageTaskBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              AddNewTask(
                onTitleChanged: (title) => _title = title,
                onDescriptionChanged: (description) => _description = description,
              ),
              TaskAndDateSelection(
                onTapTaskIndex: (int index) {
                  _taskTypeIndex = index;
                },
                onDateTimeChanged: (dateTime) => _dateCompletion = dateTime,
              ),
              _buildAddTaskButton(),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Align _buildAddTaskButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: TextButton(
        onPressed: () {
          final _dailyTask = DailyTask(
            title: _title,
            taskType: _taskTypeIndex,
            completionDate: DateTime.parse(_dateCompletion),
            description: _description,
          );
          _manageTaskBloc.insertLocalTask(_dailyTask);
        },
        style: TextButton.styleFrom(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          shadowColor: Colors.grey.withOpacity(0.3),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 80),
          backgroundColor: const Color(0xff00e1b5),
        ),
        child: const Text(
          'ADD TASK',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  PreferredSize _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40.0),
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_sharp,
          ),
        ),
      ),
    );
  }
}
