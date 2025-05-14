import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:kanachat/core/common/entities/app_theme_entity.dart';

class AppThemeCubit extends HydratedCubit<AppThemeEntity> {
  AppThemeCubit() : super(AppThemeEntity(isDarkMode: false));

  void toggleTheme() {
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
  }

  @override
  AppThemeEntity? fromJson(Map<String, dynamic> json) {
    return AppThemeEntity.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AppThemeEntity state) {
    return state.toJson();
  }
}
