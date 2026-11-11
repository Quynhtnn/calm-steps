import 'package:flutter/material.dart';
import '../services/storage.dart';
import '../services/notifications.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late DateTime selected =
      DateTime.tryParse(store.prefs.getString('reminder') ?? '') ??
      DateTime.now().add(const Duration(minutes: 2));
  late final title = TextEditingController(
    text: store.prefs.getString('reminderTitle') ?? 'Meditation Reminder',
  );
  String status = '';
  @override
  void dispose() {
    title.dispose();
    super.dispose();
  }

  Future<void> schedule({bool test = false}) async {
    try {
      if (title.text.trim().isEmpty) {
        throw Exception('Enter a reminder title.');
      }
      final when = test
          ? DateTime.now().add(const Duration(seconds: 15))
          : selected;
      await NotificationService.schedule(when, title.text.trim());
      await store.prefs.setString('reminder', when.toIso8601String());
      await store.prefs.setString('reminderTitle', title.text.trim());
      await store.prefs.setBool('notifications', true);
      if (mounted) {
        setState(() {
          selected = when;
          status = 'Scheduled. Minimize the app and wait for the system alert.';
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() => status = error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Notifications')),
    body: ListView(
      padding: const EdgeInsets.all(24),
      children: [
        SwitchListTile(
          title: const Text('Notifications enabled'),
          value: store.prefs.getBool('notifications') ?? false,
          onChanged: (value) async {
            if (value) {
              await schedule();
            } else {
              await NotificationService.cancel();
              await store.prefs.setBool('notifications', false);
              if (mounted) {
                setState(() => status = 'Reminder canceled.');
              }
            }
          },
        ),
        TextField(
          controller: title,
          decoration: const InputDecoration(labelText: 'Reminder title'),
        ),
        Text('Selected: ${selected.toLocal()}'),
        OutlinedButton(
          onPressed: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: selected.isBefore(DateTime.now())
                  ? DateTime.now()
                  : selected,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (date == null || !context.mounted) {
              return;
            }
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(selected),
            );
            if (time != null && mounted) {
              setState(
                () => selected = DateTime(
                  date.year,
                  date.month,
                  date.day,
                  time.hour,
                  time.minute,
                ),
              );
            }
          },
          child: const Text('Choose date and time'),
        ),
        FilledButton(
          onPressed: schedule,
          child: const Text('Schedule reminder'),
        ),
        OutlinedButton(
          onPressed: () => schedule(test: true),
          child: const Text('Test in 15 seconds'),
        ),
        Text(status),
        const Text(
          'One reminder at a time. A new reminder replaces the previous one. The switch represents the saved preference; system permissions can change outside the app.',
        ),
      ],
    ),
  );
}
