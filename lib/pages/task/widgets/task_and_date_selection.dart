import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class TaskAndDateSelection extends StatelessWidget {
  final Function(int index) onTapTaskIndex;
  final ValueChanged<String>? onDateTimeChanged;

  const TaskAndDateSelection({
    Key? key,
    required this.onTapTaskIndex,
    required this.onDateTimeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 26, vertical: 6),
            child: Text(
              'Filter',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TaskTypeSelection(
            onTapTaskIndex: onTapTaskIndex,
          ),
          DateSelection(
            onDateTimeChanged: onDateTimeChanged,
          ),
        ],
      ),
    );
  }
}

class TaskTypeSelection extends StatefulWidget {
  final Function(int index) onTapTaskIndex;

  const TaskTypeSelection({
    Key? key,
    required this.onTapTaskIndex,
  }) : super(key: key);

  @override
  _TaskTypeSelectionState createState() => _TaskTypeSelectionState();
}

class _TaskTypeSelectionState extends State<TaskTypeSelection> with TickerProviderStateMixin {
  late ValueNotifier<int> _taskIndexNotifier;
  final List<String> _taskTypes = ['Work', 'Home', 'Personal'];
  final List<Color> _taskTypeColors = [
    const Color(0xffee383a),
    const Color(0xff00b0fe),
    const Color(0xff10d2b8),
  ];

  @override
  void initState() {
    _taskIndexNotifier = ValueNotifier(0);
    super.initState();
  }

  @override
  void dispose() {
    _taskIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      alignment: Alignment.center,
      child: ListView.separated(
        itemCount: _taskTypes.length,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) => _buildItemTask(index),
        separatorBuilder: (_, __) => const SizedBox(width: 20),
      ),
    );
  }

  Widget _buildItemTask(int index) {
    final taskItemShadow = BoxShadow(
      color: Colors.grey.withOpacity(0.4),
      blurRadius: 7,
      spreadRadius: 3,
      offset: const Offset(0, 3),
    );
    return ValueListenableBuilder(
      valueListenable: _taskIndexNotifier,
      builder: (_, int taskIndex, __) {
        return GestureDetector(
          onTap: () {
            _taskIndexNotifier.value = index;
            widget.onTapTaskIndex(index);
          },
          child: Container(
            height: 80,
            width: 100,
            padding: const EdgeInsets.only(bottom: 12),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: taskIndex == index ? const Color(0xff141E61) : Colors.transparent,
              ),
              color: _taskTypeColors[index],
              boxShadow: [taskItemShadow],
            ),
            child: Text(
              _taskTypes[index],
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }
}

class DateSelection extends StatelessWidget {
  final ValueChanged<String>? onDateTimeChanged;

  const DateSelection({
    Key? key,
    required this.onDateTimeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
              child: Row(
                children: const [
                  Icon(
                    Icons.date_range,
                    size: 32,
                    color: Color(0xff0fd2b8),
                  ),
                  Text(
                    'Date',
                    style: TextStyle(
                      color: Color(0xff4b4b4b),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 4),
              child: DateTimePicker(
                type: DateTimePickerType.date,
                dateMask: 'dd-MM-yyyy',
                initialValue: DateTime.now().toString(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                icon: null,
                dateLabelText: '',
                timeLabelText: 'Hour',
                onChanged: onDateTimeChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
