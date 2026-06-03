import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum ThemeType {
  light('淺色'),
  dark('深色'),
  system('跟隨系統'),
  ;

  final String desc;
  const ThemeType(this.desc);

  ThemeMode get toThemeMode => switch (this) {
    ThemeType.light => ThemeMode.light,
    ThemeType.dark => ThemeMode.dark,
    ThemeType.system => ThemeMode.system,
  };

  Icon get icon => switch (this) {
    ThemeType.light => const Icon(MdiIcons.weatherSunny),
    ThemeType.dark => const Icon(MdiIcons.weatherNight),
    ThemeType.system => const Icon(MdiIcons.themeLightDark),
  };
}
