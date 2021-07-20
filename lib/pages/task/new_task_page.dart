import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/core/resources/app_colors.dart';

class NewTaskPage extends StatelessWidget {
  const NewTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        leading: IconButton(
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: const [
              AddNewTask(),
              TaskAndDateSelection(),
            ],
          ),
        ),
      ),
    );
  }
}

class AddNewTask extends StatelessWidget {
  const AddNewTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Column(
        children: [
          const Text(
            'ADD TASK',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Title here',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Title here',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TaskAndDateSelection extends StatelessWidget {
  const TaskAndDateSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text('Filter'),
          ),
          TaskTypeSelection(),
        ],
      ),
    );
  }
}

class TaskTypeSelection extends StatefulWidget {
  const TaskTypeSelection({Key? key}) : super(key: key);

  @override
  _TaskTypeSelectionState createState() => _TaskTypeSelectionState();
}

class _TaskTypeSelectionState extends State<TaskTypeSelection> {
  late ValueNotifier<int> _selectTaskTypeNotifier;

  @override
  void initState() {
    _selectTaskTypeNotifier = ValueNotifier(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _selectTaskTypeNotifier,
      builder: (_, taskType, __) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 80,
              width: 100,
              color: Colors.red,
              alignment: Alignment.bottomCenter,
              child: const Text(
                'WORK',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              height: 80,
              width: 100,
              color: Colors.red,
            ),
            Container(
              height: 80,
              width: 100,
              color: Colors.red,
            ),
          ],
        );
      },
    );
  }
}

class DateSelection extends StatelessWidget {
  const DateSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
