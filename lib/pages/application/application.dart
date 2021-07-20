import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_list/core/resources/app_colors.dart';
import 'package:todo_list/pages/home/home_task.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      color: AppColors.white,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
