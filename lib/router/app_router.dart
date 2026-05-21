import 'package:go_router/go_router.dart';
import 'package:karya_sarthi/features/books/hit_chaurasi/presentation/screens/hit_chaurasi_pad_list_screen.dart';
import 'package:karya_sarthi/features/home/presentation/screens/home_screen.dart';
import 'package:karya_sarthi/features/reminders/reminder_screen.dart';
import 'package:karya_sarthi/features/settings/settings_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(
      path: '/hit_chaurasi',
      builder: (context, state) => HitChaurasiPadListScreen(),
    ),
    GoRoute(
      path: '/reminders',
      builder: (context, state) => const ReminderScreen(),
    ),
    GoRoute(path: '/settings', builder: (context, state) => SettingsScreen()),
  ],
);
