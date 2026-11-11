import 'package:flutter/material.dart';
import '../services/storage.dart';
import '../services/notifications.dart';
import 'api_screen.dart';
import 'home.dart';
import 'notifications_screen.dart';

class SettingsMenu extends StatelessWidget {
  const SettingsMenu({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Settings menu')),
    body: ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Favorites / Profile'),
          onTap: () => openScreen(context, const FavoritesScreen()),
        ),
        ListTile(
          leading: const Icon(Icons.public),
          title: const Text('Mindful world — external API'),
          onTap: () => openScreen(context, const ApiScreen()),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Theme and preferences'),
          onTap: () => openScreen(context, const SettingsScreen()),
        ),
        ListTile(
          leading: const Icon(Icons.notifications),
          title: const Text('Notifications'),
          onTap: () => openScreen(context, const NotificationsScreen()),
        ),
        ListTile(
          leading: const Icon(Icons.help),
          title: const Text('Help'),
          onTap: () => showAboutDialog(
            context: context,
            applicationName: 'Calm Steps',
            applicationVersion: '1.0.0',
            children: [
              const Text(
                'Choose a meditation, save favorites, and schedule a reminder. One local account per installation.',
              ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Log out'),
          onTap: () async {
            await NotificationService.cancel();
            await store.prefs.setBool('notifications', false);
            await store.setSession(false);
            if (context.mounted) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
          },
        ),
      ],
    ),
  );
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Settings')),
    body: ListView(
      children: [
        SwitchListTile(
          title: const Text('Dark mode'),
          value: store.dark,
          onChanged: store.setDark,
        ),
        ListTile(
          title: const Text('Practice duration'),
          trailing: DropdownButton<int>(
            value: store.prefs.getInt('durationMinutes') ?? 5,
            items: [1, 5, 10, 15]
                .map(
                  (minutes) => DropdownMenuItem(
                    value: minutes,
                    child: Text('$minutes min'),
                  ),
                )
                .toList(),
            onChanged: (value) async {
              if (value != null) {
                await store.prefs.setInt('durationMinutes', value);
                if (mounted) {
                  setState(() {});
                }
              }
            },
          ),
        ),
        const ListTile(title: Text('Language'), subtitle: Text('English')),
        ListTile(
          title: const Text('Configure notifications'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => openScreen(context, const NotificationsScreen()),
        ),
      ],
    ),
  );
}
