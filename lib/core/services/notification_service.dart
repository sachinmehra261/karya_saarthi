import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:karya_sarthi/router/app_router.dart';
import 'package:path_provider/path_provider.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();

    try {
      final timezone = await FlutterTimezone.getLocalTimezone();

      tz.setLocalLocation(tz.getLocation(timezone.toString()));
    } catch (_) {
      tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
    }

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const settings = InitializationSettings(android: androidSettings);

    await plugin.initialize(
      settings: settings,

      onDidReceiveNotificationResponse: (response) {
        router.go('/');
      },
    );

    final android = plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await android?.requestNotificationsPermission();

    await android?.requestExactAlarmsPermission();

    final allowed = await android?.canScheduleExactNotifications();

    debugPrint('Exact alarm: $allowed');
  }

  Future<String> _saveAssetImage() async {
    final data = await rootBundle.load('assets/images/notification_image.png');

    final dir = await getTemporaryDirectory();

    final file = File('${dir.path}/notification_image.png');

    await file.writeAsBytes(data.buffer.asUint8List());

    return file.path;
  }

  Future<void> scheduleNotifications(List<TimeOfDay> times) async {
    for (int i = 0; i < 20; i++) {
      await plugin.cancel(id: i);
    }

    final imagePath = await _saveAssetImage();

    for (int i = 0; i < times.length; i++) {
      final time = times[i];

      await plugin.zonedSchedule(
        id: i,

        title: "राधावल्लभ श्री हरिवंश",

        body: "नाम जपते रहो नाम अपना प्रभाव दिखा कर रहेगा",

        scheduledDate: _nextTime(time.hour, time.minute),

        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            'daily_channel_v1',
            'Daily Reminder',

            channelDescription: 'Karya Saarthi reminders',

            importance: Importance.max,

            priority: Priority.high,

            playSound: true,

            enableVibration: true,

            sound: RawResourceAndroidNotificationSound(
              'radhavallabh_shree_harivansh',
            ),

            styleInformation: BigPictureStyleInformation(
              FilePathAndroidBitmap(imagePath),

              contentTitle: 'राधावल्लभ श्री हरिवंश',

              summaryText: "नाम जपते रहो नाम अपना प्रभाव दिखा कर रहेगा",
            ),
          ),
        ),

        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,

        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  tz.TZDateTime _nextTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);

    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    return scheduled;
  }
}
