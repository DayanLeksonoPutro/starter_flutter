import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'core/constants/app_config.dart';
import 'core/providers/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settings = SettingsProvider();
  await Future.wait([
    AppConfig.init(),
    settings.load(),
  ]);

  runApp(
    ChangeNotifierProvider.value(
      value: settings,
      child: const App(),
    ),
  );
}
