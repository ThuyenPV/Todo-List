import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/data/models/daily_task.dart';
import 'package:todo_list/pages/home/widgets/task_item.dart';

class TaskOfWeeks extends StatefulWidget {
  final List<DailyTask> tasks;

  const TaskOfWeeks({Key? key, required this.tasks}) : super(key: key);

  @override
  _TaskOfWeeksState createState() => _TaskOfWeeksState();
}

class _TaskOfWeeksState extends State<TaskOfWeeks> {
  final _scrollTaskController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _scrollTaskController.animateTo(
        _scrollTaskController.position.minScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  List<DailyTask> get _dailyTasks => widget.tasks;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Today',
              style: TextStyle(
                fontSize: 25,
                color: Color(0xff606060),
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              height: 5,
              width: 70,
              margin: const EdgeInsets.only(top: 4, bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff377fd7),
                    Color(0xff04cafb),
                  ],
                ),
              ),
            ),
            Container(
              height: 90,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 4,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: DatePicker(
                  DateTime.now(),
                  initialSelectedDate: DateTime.now(),
                  selectionColor: const Color(0xff00e1b5),
                  selectedTextColor: Colors.white,
                  monthTextStyle: const TextStyle(color: Colors.white),
                  onDateChange: (date) {
                    setState(() {});
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _dailyTasks.length,
                controller: _scrollTaskController,
                itemBuilder: (context, index) {
                  return TaskItem(
                    dailyTask: _dailyTasks[index],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
