import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:karya_sarthi/features/home/presentation/providers/theme_provider.dart';

class AppBarWidget extends ConsumerWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return AppBar(
      centerTitle: false,
      elevation: 1,

      actionsPadding: const EdgeInsets.only(right: 10),

      title: const _Logo(),

      actions: [
        IconButton(
          onPressed: () {
            ref.read(themeProvider.notifier).toggleTheme();
          },

          icon: Icon(
            themeMode == ThemeMode.dark
                ? Icons.light_mode
                : Icons.dark_mode_outlined,
            size: 27,
          ),
        ),
      ],
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/images/logo_without_bg.png", height: 140);
  }
}
