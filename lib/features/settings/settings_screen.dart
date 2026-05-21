import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:karya_sarthi/features/settings/providers/carousel_provider.dart';
import 'package:karya_sarthi/features/settings/providers/notification_toggle_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationToggleProvider);

    final carousel = ref.watch(carouselProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),

      body: Column(
        children: [
          SwitchListTile(
            title: Text(
              "Notifications",
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            value: notifications,

            onChanged: (value) async {
              await ref.read(notificationToggleProvider.notifier).toggle(value);
            },
          ),

          Divider(color: Theme.of(context).cardColor),

          SwitchListTile(
            title: Text(
              "Image Carousel",
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            value: carousel,

            onChanged: (value) async {
              await ref.read(carouselProvider.notifier).toggle(value);
            },
          ),
        ],
      ),
    );
  }
}
