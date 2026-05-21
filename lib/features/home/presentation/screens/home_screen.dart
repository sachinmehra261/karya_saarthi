import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:karya_sarthi/core/widgets/app_bar_widget.dart';
import 'package:karya_sarthi/core/widgets/app_drawer.dart';
import 'package:karya_sarthi/features/books/hit_chaurasi/providers/pad_provider.dart';
import 'package:karya_sarthi/features/home/presentation/widgets/hit_chaurasi.dart';
import 'package:karya_sarthi/features/home/presentation/widgets/image_carousel.dart';
import 'package:karya_sarthi/features/settings/providers/carousel_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  int getDailyPadIndex(int totalPads) {
    final now = DateTime.now();

    final seed = now.year * 1000 + now.month * 100 + now.day;

    return Random(seed).nextInt(totalPads);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pads = ref.watch(padProvider);
    final carousel = ref.watch(carouselProvider);

    return Scaffold(
      drawer: const AppDrawer(),

      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(),
      ),

      body: pads.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (e, _) => Center(child: Text("$e")),

        data: (list) {
          final pad = list[getDailyPadIndex(list.length)];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),

              child: Column(
                children: [
                  if (carousel) const ImageCarousel(),

                  const SizedBox(height: 20),

                  if (!carousel)
                    Center(
                      child: Text(
                        "🌹जय जय श्री हित हरिवंश🌹",

                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),

                  const SizedBox(height: 20),

                  HitChaurasi(padSankhya: pad.id, verse: pad.verse),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
