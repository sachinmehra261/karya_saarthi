import 'package:flutter/material.dart';
import 'package:karya_sarthi/core/theme/app_colors.dart';

class HitChaurasi extends StatelessWidget {
  final int padSankhya;
  final String verse;

  const HitChaurasi({super.key, required this.padSankhya, required this.verse});
  @override
  Widget build(BuildContext context) {
    if (verse.isEmpty) {
      return Center(
        child: Text(
          "Not Found! जय जय श्री हित हरिवंश🙏",
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: AppColors.error),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,

      children: [
        Center(
          child: Text(
            "🌺🌸 आज का पद 🌸🌺\n$padSankhya.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),

        Card(
          margin: const EdgeInsets.all(12),

          child: Padding(
            padding: const EdgeInsets.all(16),

            child: Text(
              verse,

              textAlign: TextAlign.center,

              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      ],
    );
  }
}
