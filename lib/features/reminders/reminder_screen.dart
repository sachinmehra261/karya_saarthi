import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:karya_sarthi/providers/notification_provider.dart';

class ReminderScreen extends ConsumerStatefulWidget {
  const ReminderScreen({super.key});

  @override
  ConsumerState<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends ConsumerState<ReminderScreen> {
  bool morning = false;
  bool evening = false;

  List<TimeOfDay> customTimes = [];

  int? intervalHours;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    final savedTimes = prefs.getStringList('customTimes') ?? [];

    customTimes = savedTimes.map((e) {
      final parts = e.split(':');

      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    }).toList();

    setState(() {
      morning = prefs.getBool('morning') ?? false;

      evening = prefs.getBool('evening') ?? false;

      intervalHours = prefs.getInt('intervalHours');
    });

    await updateNotifications();
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('morning', morning);

    await prefs.setBool('evening', evening);

    await prefs.setStringList(
      'customTimes',
      customTimes.map((t) => '${t.hour}:${t.minute}').toList(),
    );

    if (intervalHours != null) {
      await prefs.setInt('intervalHours', intervalHours!);
    } else {
      await prefs.remove('intervalHours');
    }
  }

  Future<void> updateNotifications() async {
    final times = <TimeOfDay>[];

    if (morning) {
      times.add(const TimeOfDay(hour: 7, minute: 0));
    }

    if (evening) {
      times.add(const TimeOfDay(hour: 20, minute: 0));
    }

    times.addAll(customTimes);

    // interval reminders:
    // e.g. every 4 hours
    if (intervalHours != null) {
      for (int hour = 0; hour < 24; hour += intervalHours!) {
        times.add(TimeOfDay(hour: hour, minute: 0));
      }
    }

    await ref.read(notificationProvider).scheduleNotifications(times);
  }

  Future<void> addReminder() async {
    final selected = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selected == null) return;

    setState(() {
      customTimes.add(selected);
    });

    await save();

    await updateNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reminders")),

      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Morning Reminder"),
            subtitle: const Text("7:00 AM"),
            value: morning,
            onChanged: (value) async {
              setState(() {
                morning = value;
              });

              await save();

              await updateNotifications();
            },
          ),

          SwitchListTile(
            title: const Text("Evening Reminder"),
            subtitle: const Text("8:00 PM"),
            value: evening,
            onChanged: (value) async {
              setState(() {
                evening = value;
              });

              await save();

              await updateNotifications();
            },
          ),

          const Divider(),

          ...customTimes.asMap().entries.map((entry) {
            final index = entry.key;

            final time = entry.value;

            return ListTile(
              title: Text(time.format(context)),

              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  setState(() {
                    customTimes.removeAt(index);
                  });

                  await save();

                  await updateNotifications();
                },
              ),
            );
          }),

          Padding(
            padding: const EdgeInsets.all(16),

            child: DropdownButtonFormField<int>(
              value: intervalHours,

              decoration: const InputDecoration(labelText: "Interval Reminder"),

              items: const [
                DropdownMenuItem(value: 1, child: Text("Every 1 hour")),

                DropdownMenuItem(value: 2, child: Text("Every 2 hours")),

                DropdownMenuItem(value: 4, child: Text("Every 4 hours")),

                DropdownMenuItem(value: 6, child: Text("Every 6 hours")),

                DropdownMenuItem(value: 12, child: Text("Every 12 hours")),
              ],

              onChanged: (value) async {
                setState(() {
                  intervalHours = value;
                });

                await save();

                await updateNotifications();
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),

            child: ElevatedButton.icon(
              onPressed: addReminder,

              icon: const Icon(Icons.add),

              label: const Text("Add Reminder"),
            ),
          ),
        ],
      ),
    );
  }
}
