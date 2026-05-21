import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  late final PageController controller;

  final images = [
    'assets/images/notification_image.png',
    'assets/images/radhavallabh_shree_harivansh_naam.webp',
    'assets/images/radha.webp',
  ];

  @override
  void initState() {
    super.initState();

    controller = PageController(initialPage: images.length * 1000);

    autoScroll();
  }

  void autoScroll() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 5));

      if (!mounted) {
        return false;
      }

      controller.nextPage(
        duration: const Duration(milliseconds: 500),

        curve: Curves.easeInOut,
      );

      return true;
    });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,

      child: PageView.builder(
        controller: controller,

        itemBuilder: (context, index) {
          final image = images[index % images.length];

          return Padding(
            padding: const EdgeInsets.all(8),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),

              child: Image.asset(image, fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
