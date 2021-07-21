import 'package:moor/moor.dart';
import 'package:todo_list/data/models/daily_task.dart';
import 'package:todo_list/data/source/local/database/entities/task_local_entity.dart';
import 'package:todo_list/data/source/local/database/local_database.dart';

part 'task_dao.g.dart';

@UseDao(tables: [TaskLocalEntities])
class TaskDao extends DatabaseAccessor<LocalDatabase> with _$TaskDaoMixin {
  TaskDao(LocalDatabase attachedDatabase) : super(attachedDatabase);

  Future<dynamic> insertTask(DailyTask task) {
    final taskEntity = TaskLocalEntitiesCompanion.insert(
      title: task.title,
      description: task.description,
      taskType: task.taskType,
      dayOfTask: task.dayOfTask,
      isComplete: task.isComplete,
    );
    return into(taskLocalEntities).insertOnConflictUpdate(taskEntity);
  }

  Future updateTask(DailyTask task) {
    final taskEntity = TaskLocalEntitiesCompanion(
      title: Value(task.title),
      description: Value(task.description),
      taskType: Value(task.taskType),
      dayOfTask: Value(task.dayOfTask),
      isComplete: Value(task.isComplete),
    );

    return update(taskLocalEntities).write(taskEntity);
  }

  Future<List<DailyTask>> get allTasks => select(taskLocalEntities).map((e) => DailyTask.fromLocal(e)).get();
}
