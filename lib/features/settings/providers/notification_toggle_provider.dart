import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:karya_sarthi/providers/notification_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final notificationToggleProvider =
    NotifierProvider<NotificationToggleNotifier, bool>(
      NotificationToggleNotifier.new,
    );

class NotificationToggleNotifier extends Notifier<bool> {
  @override
  bool build() {
    Future(load);

    return true;
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    state = prefs.getBool('notifications') ?? true;
  }

  Future<void> toggle(bool value) async {
    state = value;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('notifications', value);

    final service = ref.read(notificationProvider);

    if (!value) {
      for (int i = 0; i < 20; i++) {
        await service.plugin.cancel(id: i);
      }
    } else {
      final savedTimes = prefs.getStringList('customTimes') ?? [];

      final times = savedTimes.map((e) {
        final p = e.split(':');

        return TimeOfDay(hour: int.parse(p[0]), minute: int.parse(p[1]));
      }).toList();

      await service.scheduleNotifications(times);
    }
  }
}
