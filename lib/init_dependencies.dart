import 'package:get_it/get_it.dart';
import 'package:kanachat/core/common/bloc/app_theme_cubit/app_theme_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  _initThemes();
}

void _initThemes() {
  sl.registerLazySingleton(() => AppThemeCubit());
}
