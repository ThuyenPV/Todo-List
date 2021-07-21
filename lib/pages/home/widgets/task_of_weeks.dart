import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/data/models/user.dart';
import 'package:todo_list/widget/circle_painter.dart';

class TaskOfWeeks extends StatefulWidget {
  final List<DailyTask> tasks;

  const TaskOfWeeks({Key? key, required this.tasks}) : super(key: key);

  @override
  _TaskOfWeeksState createState() => _TaskOfWeeksState();
}

class _TaskOfWeeksState extends State<TaskOfWeeks> {
  late DateTime _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = DateTime.now();
  }

  @override
  void dispose() {
    super.dispose();
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
                    setState(() {
                      _selectedValue = date;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _dailyTasks.length,
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
            blurRadius: 2,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TaskSelected(
            isComplete: false,
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
  final bool isComplete;

  const TaskSelected({
    Key? key,
    required this.isComplete,
  }) : super(key: key);

  @override
  _TaskSelectedState createState() => _TaskSelectedState();
}

class _TaskSelectedState extends State<TaskSelected> {
  late ValueNotifier<bool> _isCompletedTask;

  @override
  void initState() {
    _isCompletedTask = ValueNotifier(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isCompletedTask,
      builder: (_, bool isComplete, __) {
        return GestureDetector(
          onTap: () {
            _isCompletedTask.value = !isComplete;
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
