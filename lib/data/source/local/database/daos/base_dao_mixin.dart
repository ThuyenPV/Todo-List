import 'package:moor/moor.dart';
import 'package:todo_list/data/source/local/database/local_database.dart';

typedef Expression<bool> FilterFunction(var e);

mixin BaseDaoMixin<D extends DataClass, T extends Table, UC extends UpdateCompanion<D>>
    on DatabaseAccessor<LocalDatabase> {
  TableInfo<T, D> get table;

  Future<int> insertOne(UC data) async {
    return into(table).insertOnConflictUpdate(data);
  }

  Future<int> updateWhere(List<FilterFunction> filters, UC data) {
    var updatingTable = update(table);
    filters.forEach((e) => updatingTable..where(e));
    return updatingTable.write(data);
  }

  Future<List<D>> get all => select(table).get();
}
