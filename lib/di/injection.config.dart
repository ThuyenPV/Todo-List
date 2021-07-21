import 'package:get_it/get_it.dart';
import 'package:todo_list/blocs/fetch_tasks/manage_tasks_bloc.dart';
import 'package:todo_list/data/source/local/database/local_database.dart';
import 'package:todo_list/data/source/local/datasources/local_user_datasource.dart';
import 'package:todo_list/repositories/task_repository.dart';

GetIt $initGetIt(GetIt getIt) {
  getIt.registerSingleton<LocalDatabase>(LocalDatabase());

  registerDataSource(getIt);
  registerRepository(getIt);
  registerBloC(getIt);

  return getIt;
}

void registerDataSource(GetIt getIt) {
  getIt.registerLazySingleton<TaskLocalDataSource>(
    () => TaskLocalDataSourceImpl(),
  );
}

void registerRepository(GetIt getIt) {
  getIt.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl());
}

void registerBloC(GetIt getIt) {
  getIt.registerFactory<ManageTaskBloc>(() => ManageTaskBloc());
}
