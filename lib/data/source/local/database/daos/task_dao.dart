import 'package:moor/moor.dart';
import 'package:todo_list/data/models/user.dart';
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
      completionDate: task.completionDate,
    );
    return into(taskLocalEntities).insertOnConflictUpdate(taskEntity);
  }

  Future<List<DailyTask>> get allTasks => select(taskLocalEntities).map((e) => DailyTask.fromLocal(e)).get();
}
