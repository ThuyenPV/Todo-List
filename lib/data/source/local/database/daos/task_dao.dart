import 'package:moor/moor.dart';
import 'package:todo_list/data/models/daily_task.dart';
import 'package:todo_list/data/source/local/database/daos/base_dao_mixin.dart';
import 'package:todo_list/data/source/local/database/entities/task_local_entity.dart';
import 'package:todo_list/data/source/local/database/local_database.dart';

part 'task_dao.g.dart';

typedef Expression<bool> FilterFunction(var e);

@UseDao(tables: [TaskLocalEntities])
class TaskDao extends DatabaseAccessor<LocalDatabase>
    with _$TaskDaoMixin, BaseDaoMixin<LocalTask, $TaskLocalEntitiesTable, TaskLocalEntitiesCompanion> {
  TaskDao(LocalDatabase attachedDatabase) : super(attachedDatabase);

  Future<List<DailyTask>> get allTasks => select(taskLocalEntities).map((e) => DailyTask.fromLocal(e)).get();

  @override
  TableInfo<$TaskLocalEntitiesTable, LocalTask> get table => taskLocalEntities;
}
