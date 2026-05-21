import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:karya_sarthi/core/theme/app_colors.dart';
import 'package:karya_sarthi/features/books/hit_chaurasi/providers/pad_provider.dart';
import 'package:karya_sarthi/features/books/hit_chaurasi/providers/search_provider.dart';

class HitChaurasiPadListWidget extends ConsumerWidget {
  final ScrollController controller;

  const HitChaurasiPadListWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pads = ref.watch(padProvider);

    final query = ref.watch(searchProvider);

    return pads.when(
      loading: () => const Center(child: CircularProgressIndicator()),

      error: (e, _) => Center(child: Text("$e")),

      data: (list) {
        final brightness = Theme.of(context).brightness;

        final filteredList = list.where((pad) {
          if (query.isEmpty) {
            return true;
          }

          return pad.id.toString() == query;
        }).toList();

        return filteredList.length > 0
            ? ListView.builder(
                controller: controller,

                itemCount: filteredList.length,

                itemBuilder: (context, index) {
                  final pad = filteredList[index];

                  return KeyedSubtree(
                    key: ValueKey("${pad.id}-$brightness"),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,

                      children: [
                        Center(
                          child: Text(
                            "(${pad.id})",

                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),

                        Card(
                          elevation: 2,

                          margin: const EdgeInsets.all(12),

                          shadowColor: AppColors.secondary,

                          child: Padding(
                            padding: const EdgeInsets.all(16),

                            child: Text(
                              pad.verse,

                              textAlign: TextAlign.center,

                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  "कोई पद नहीं मिला",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: AppColors.primary),
                ),
              );
      },
    );
  }
}
