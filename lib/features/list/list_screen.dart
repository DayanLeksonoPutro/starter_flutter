import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_theme.dart';
import '../../core/providers/settings_provider.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<SettingsProvider>().locale;
    String s(String key) => AppStrings.get(key, locale);
    final theme = Theme.of(context);

    // Dummy data — replace with real data from DatabaseHelper or a repository
    final items = List.generate(12, (i) => '${s('list_item_prefix')} ${i + 1}');

    return Scaffold(
      appBar: AppBar(title: Text(s('list_title'))),
      body: items.isEmpty
          ? Center(
              child: Text(s('list_empty'), style: theme.textTheme.bodyMedium),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingMd,
                vertical: AppTheme.spacingSm,
              ),
              itemCount: items.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
                    ),
                  ),
                  title: Text(items[index]),
                  subtitle: Text(
                    'Subtitle for item ${index + 1}',
                    style: theme.textTheme.bodySmall,
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
