import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_list/blocs/blocs.dart';
import 'package:todo_list/blocs/fetch_tasks/manage_tasks_bloc.dart';
import 'package:todo_list/blocs/fetch_tasks/manage_tasks_state.dart';
import 'package:todo_list/core/resources/app_colors.dart';
import 'package:todo_list/data/models/daily_task.dart';
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
      child: BlocBuilder(
        bloc: _manageTaskBloc,
        builder: (BuildContext context, BaseState state) {
          if (state is ErrorState) {
            Fluttertoast.showToast(
                msg: state.exception.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          return TextButton(
            onPressed: () {
              final _dailyTask = DailyTask(
                title: _title,
                taskType: _taskTypeIndex,
                dayOfTask: DateTime.parse(_dateCompletion),
                description: _description,
              );
              _manageTaskBloc.insertLocalTask(_dailyTask);
            },
            style: TextButton.styleFrom(
              fixedSize: Size(
                MediaQuery.of(context).size.width * 0.7,
                MediaQuery.of(context).size.height * 0.08,
              ),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              shadowColor: Colors.grey.withOpacity(0.3),
              backgroundColor: const Color(0xff00e1b5),
            ),
            child: _buildWidgetDependOnState(state),
          );
        },
      ),
    );
  }

  Widget _buildWidgetDependOnState(BaseState state) {
    const _defaultText = Text(
      'ADD TASK',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
    switch (state.runtimeType) {
      case InProgressState:
        return const Center(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 4));
      case InsertLocalTaskSuccessState:
        Fluttertoast.showToast(
            msg: 'Add new task successful !',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            backgroundColor: const Color(0xff10d2b8),
            textColor: Colors.white,
            fontSize: 16.0);
        break;
      default:
        return _defaultText;
    }
    return _defaultText;
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
