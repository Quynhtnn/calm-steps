import 'package:flutter/services.dart';

class NotificationService {
  static const channel = MethodChannel('calm_steps/reminders');
  static Future<void> schedule(DateTime when, String title) async {
    if (!when.isAfter(DateTime.now())) {
      throw Exception('Choose a future date and time.');
    }
    await channel.invokeMethod<void>('schedule', {
      'time': when.millisecondsSinceEpoch,
      'title': title,
    });
  }

  static Future<void> cancel() => channel.invokeMethod<void>('cancel');
}
