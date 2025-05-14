class AppThemeEntity {
  final bool isDarkMode;

  const AppThemeEntity({required this.isDarkMode});

  AppThemeEntity copyWith({bool? isDarkMode}) {
    return AppThemeEntity(isDarkMode: isDarkMode ?? this.isDarkMode);
  }

  factory AppThemeEntity.fromJson(Map<String, dynamic> json) {
    return AppThemeEntity(isDarkMode: json['isDarkMode'] as bool? ?? false);
  }

  Map<String, dynamic> toJson() {
    return {'isDarkMode': isDarkMode};
  }
}
