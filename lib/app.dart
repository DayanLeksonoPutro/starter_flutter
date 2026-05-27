import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_config.dart';
import 'core/constants/app_theme.dart';
import 'core/providers/settings_provider.dart';
import 'core/utils/app_transitions.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'shared/widgets/bottom_nav.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, _) {
        return MaterialApp(
          title: AppConfig.appName,
          debugShowCheckedModeBanner: false,
          themeMode: settings.themeMode,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          home: AnimatedSwitcher(
            duration: AppTransitions.duration,
            transitionBuilder: (child, anim) => FadeTransition(
              opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
              child: child,
            ),
            child: settings.onboardingDone
                ? const MainNavigation(key: ValueKey('main'))
                : const OnboardingScreen(key: ValueKey('onboarding')),
          ),
        );
      },
    );
  }
}
