import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_strings.dart';
import '../../core/providers/settings_provider.dart';
import '../../features/home/home_screen.dart';
import '../../features/list/list_screen.dart';
import '../../features/settings/settings_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ListScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<SettingsProvider>().locale;
    String s(String key) => AppStrings.get(key, locale);

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: s('nav_home'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.list_outlined),
            activeIcon: const Icon(Icons.list),
            label: s('nav_list'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            activeIcon: const Icon(Icons.settings),
            label: s('nav_settings'),
          ),
        ],
      ),
    );
  }
}
