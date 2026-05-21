import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:karya_sarthi/core/theme/app_colors.dart';
import 'package:karya_sarthi/core/widgets/app_bar_widget.dart';
import 'package:karya_sarthi/features/books/hit_chaurasi/presentation/widgets/hit_chaurasi_pad_list_widget.dart';
import 'package:karya_sarthi/features/books/hit_chaurasi/providers/search_provider.dart';
import 'package:karya_sarthi/features/books/hit_chaurasi/providers/search_bar_visibility_provider.dart';

class HitChaurasiPadListScreen extends ConsumerStatefulWidget {
  const HitChaurasiPadListScreen({super.key});

  @override
  ConsumerState<HitChaurasiPadListScreen> createState() =>
      _HitChaurasiPadListScreenState();
}

class _HitChaurasiPadListScreenState
    extends ConsumerState<HitChaurasiPadListScreen> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      final query = ref.read(searchProvider);

      ref
          .read(searchBarVisibilityProvider.notifier)
          .onScroll(controller.position.userScrollDirection, query);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showSearch = ref.watch(searchBarVisibilityProvider);

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(),
      ),

      body: GestureDetector(
        behavior: HitTestBehavior.opaque,

        onTap: FocusManager.instance.primaryFocus?.unfocus,

        child: Padding(
          padding: const EdgeInsets.all(12),

          child: Column(
            children: [
              ClipRect(
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 300),

                  curve: Curves.easeInOut,

                  child: SizedBox(
                    height: showSearch ? 60 : 0,

                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),

                      opacity: showSearch ? 1 : 0,

                      child: SearchBar(
                        hintText: "पद संख्या खोजें",
                        textStyle: WidgetStatePropertyAll(
                          Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                ? AppColors.card
                                : null,
                          ),
                        ),
                        backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.black12
                              : null,
                        ),

                        keyboardType: TextInputType.number,

                        elevation: const WidgetStatePropertyAll(0),

                        onChanged: (value) {
                          ref.read(searchProvider.notifier).updateSearch(value);
                        },
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Expanded(child: HitChaurasiPadListWidget(controller: controller)),
            ],
          ),
        ),
      ),
    );
  }
}
