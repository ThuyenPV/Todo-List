import 'package:flutter/cupertino.dart';
import 'package:todo_list/di/injection.dart';
import 'package:todo_list/pages/application/application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(Application());
}
