import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/core/common/constants/string_constant.dart';

class TaskCompleted extends StatelessWidget {
  final int totalTasks;
  final int amountOfTaskComplete;

  const TaskCompleted({
    Key? key,
    this.totalTasks = 0,
    this.amountOfTaskComplete = 0,
  }) : super(key: key);

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
              text: TextSpan(
                style: const TextStyle(fontSize: 16),
                children: [
                  TextSpan(
                    text: '$amountOfTaskComplete/$totalTasks ',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xff9c9c9c),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const TextSpan(
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
            Container(
              height: 10,
              width: 200,
              decoration: BoxDecoration(
                color: const Color(0xffd9e5f6),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Stack(
                children: [
                  Container(
                    height: 10,
                    width: getPercentWidthTaskCompleted,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double get getPercentWidthTaskCompleted {
    if (totalTasks == 0) return 0;
    return ((amountOfTaskComplete / totalTasks) * 200);
  }
}
