import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/data/models/daily_task.dart';
import 'package:todo_list/pages/home/widgets/task_item.dart';
import 'package:todo_list/core/extensions/extension.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:todo_list/widget/task_inherited_widget.dart';

class TaskOfWeeks extends StatefulWidget {
  final List<DailyTask> tasks;

  const TaskOfWeeks({Key? key, required this.tasks}) : super(key: key);

  @override
  _TaskOfWeeksState createState() => _TaskOfWeeksState();
}

class _TaskOfWeeksState extends State<TaskOfWeeks> with AutomaticKeepAliveClientMixin {
  final _scrollTaskController = ScrollController();
  late ValueNotifier<List<DailyTask>> _dailyTasksNotifier;
  late ValueNotifier<DateTime> _dateTimeNotifier;
  late DateTime _currentSelectedDate = DateTime.now();

  final _dayOfWeeksStyle = const TextStyle(
    color: Color(0xffababab),
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  @override
  void initState() {
    super.initState();
    _dailyTasksNotifier = ValueNotifier(filterTasksByDate(_currentSelectedDate));
    _dateTimeNotifier = ValueNotifier(DateTime.now());
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _scrollTaskController.animateTo(
        _scrollTaskController.position.minScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  @override
  void didUpdateWidget(covariant TaskOfWeeks oldWidget) {
    _dailyTasksNotifier.value = filterTasksByDate(_currentSelectedDate);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final taskState = TaskInheritedWidget.of(context);
    return Flexible(
      flex: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
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
              height: 110,
              width: double.infinity,
              alignment: Alignment.center,
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
              child: ValueListenableBuilder(
                valueListenable: _dateTimeNotifier,
                builder: (BuildContext context, DateTime selectedDate, __) {
                  return CalendarWeek(
                    showMonth: false,
                    todayBackgroundColor:
                        selectedDate.isSameDate(DateTime.now()) ? const Color(0xff02dfb4) : Colors.transparent,
                    todayDateStyle: selectedDate.isSameDate(DateTime.now())
                        ? _dayOfWeeksStyle
                        : const TextStyle(color: Color(0xffababab)),
                    marginDayOfWeek: const EdgeInsets.symmetric(vertical: 10),
                    dateStyle: _dayOfWeeksStyle,
                    backgroundColor: Colors.white,
                    minDate: DateTime.now().add(const Duration(days: -365)),
                    maxDate: DateTime.now().add(const Duration(days: 365)),
                    pressedDateBackgroundColor: const Color(0xff02dfb4),
                    pressedDateStyle: _dayOfWeeksStyle,
                    dayOfWeekStyle: _dayOfWeeksStyle,
                    weekendsStyle: _dayOfWeeksStyle,
                    onDatePressed: (selectedDate) {
                      _currentSelectedDate = selectedDate;
                      _dateTimeNotifier.value = selectedDate;
                      _dailyTasksNotifier.value = filterTasksByDate(selectedDate);
                      taskState!.onRefresh;
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _dailyTasksNotifier,
                builder: (_, List<DailyTask> dailyTasks, __) {
                  return ListView.builder(
                    itemCount: dailyTasks.length,
                    controller: _scrollTaskController,
                    addAutomaticKeepAlives: true,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        dailyTask: dailyTasks[index],
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  List<DailyTask> filterTasksByDate(DateTime dateTime) {
    return widget.tasks.where((it) => it.dayOfTask.isSameDate(dateTime)).toList();
  }

  @override
  bool get wantKeepAlive => true;
}
