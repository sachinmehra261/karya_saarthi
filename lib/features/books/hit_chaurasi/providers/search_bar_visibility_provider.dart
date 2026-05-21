import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchBarVisibilityNotifier extends Notifier<bool> {
  ScrollDirection _lastDirection = ScrollDirection.idle;

  @override
  bool build() => true;

  void onScroll(ScrollDirection direction, String query) {
    // Keep visible while searching
    if (query.isNotEmpty) {
      state = true;
      return;
    }

    if (_lastDirection == direction) {
      return;
    }

    _lastDirection = direction;

    if (direction == ScrollDirection.reverse) {
      state = false;
    }

    if (direction == ScrollDirection.forward) {
      state = true;
    }
  }
}

final searchBarVisibilityProvider =
    NotifierProvider<SearchBarVisibilityNotifier, bool>(
      SearchBarVisibilityNotifier.new,
    );
