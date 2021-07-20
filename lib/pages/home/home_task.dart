import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/blocs/fetch_tasks/search_users_bloc.dart';
import 'package:todo_list/core/common/constants/string_constant.dart';
import 'package:todo_list/di/injection.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late SearchUsersBloc _fetchUsersBloc;

  @override
  void initState() {
    super.initState();
    _fetchUsersBloc = getIt<SearchUsersBloc>();

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      _fetchUsersBloc.getLocalTasks();
    });
  }

  @override
  void dispose() {
    _fetchUsersBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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

class TaskCompleted extends StatelessWidget {
  const TaskCompleted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text(
              StringConstant.homeTasks,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
            SizedBox(height: 5),
            Text('3/4 tasks completed'),
            SizedBox(height: 5),
            SizedBox(
              width: 200,
              height: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                  value: 0.7,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xff00ffff),
                  ),
                  backgroundColor: Color(0xffD6D6D6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskOfWeeks extends StatelessWidget {
  const TaskOfWeeks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Today',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
            Container(
              color: Colors.red,
              height: 80,
              width: double.infinity,
              child: Column(
                children: [],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const TaskItem();
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
  const TaskItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TaskSelected(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Icon(
                    Icons.ac_unit,
                    size: 25,
                    color: Colors.lightGreenAccent,
                  ),
                  Text('Cleaning'),
                ],
              ),
              const Text('Clean the house'),
            ],
          ),
        ],
      ),
    );
  }
}

class TaskSelected extends StatefulWidget {
  const TaskSelected({Key? key}) : super(key: key);

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
            child: Icon(
              isComplete ? Icons.done : Icons.ac_unit,
              size: 50,
              color: isComplete ? Colors.green : Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
