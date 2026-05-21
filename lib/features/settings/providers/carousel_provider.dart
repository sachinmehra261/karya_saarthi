import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final carouselProvider = NotifierProvider<CarouselNotifier, bool>(
  CarouselNotifier.new,
);

class CarouselNotifier extends Notifier<bool> {
  @override
  bool build() {
    load();
    return true;
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    state = prefs.getBool('imageCarousel') ?? true;
  }

  Future<void> toggle(bool value) async {
    state = value;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('imageCarousel', value);
  }
}
