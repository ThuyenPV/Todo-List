import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/core/common/constants/string_constant.dart';

class TaskCompleted extends StatefulWidget {
  const TaskCompleted({Key? key}) : super(key: key);

  @override
  _TaskCompletedState createState() => _TaskCompletedState();
}

class _TaskCompletedState extends State<TaskCompleted> with SingleTickerProviderStateMixin {
  late AnimationController progressController;
  late Animation<double> progressAnimation;

  @override
  void initState() {
    super.initState();
    progressController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    progressAnimation = Tween(begin: 0.0, end: 0.8).animate(progressController)
      ..addListener(() => setState(() {}));
    progressController.forward();
  }

  @override
  void dispose() {
    progressController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              StringConstant.homeTasks,
              style: TextStyle(
                fontSize: 22,
                color: Color(0xff606060),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 16),
                children: [
                  TextSpan(
                    text: '3/4 ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff9c9c9c),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: 'tasks completed',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff9c9c9c),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 200,
              height: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: LinearProgressIndicator(
                  backgroundColor: const Color(0xffd9e5f6),
                  color: const Color(0xff377fd7),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xff04cafb)),
                  value: progressAnimation.value,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
