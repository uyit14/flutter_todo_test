import 'package:flutter_todo_test/data/home/repositories/home_repository_impl.dart';
import 'package:flutter_todo_test/ui/home/blocs/home_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //repositories
  sl.registerLazySingleton(() => HomeRepositoryImpl());
  //bloc
  sl.registerLazySingleton(() => HomeBloc(homeRepositoryImpl: sl()));
}
