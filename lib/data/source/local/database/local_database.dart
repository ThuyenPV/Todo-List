import 'dart:io';
import 'daos/task_dao.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:todo_list/core/common/constants/app_constant.dart';
import 'entities/task_local_entity.dart';

part 'local_database.g.dart';

@UseMoor(tables: [TaskLocalEntities], daos: [TaskDao])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  Future<void> clear() {
    return transaction(() async {
      for (var table in allTables) {
        await delete(table).go();
      }
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, AppConstant.DB_NAME));
    return VmDatabase(file);
  });
}
