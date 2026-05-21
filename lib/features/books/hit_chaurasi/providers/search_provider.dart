import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchNotifier extends Notifier<String> {
  @override
  String build() => '';

  void updateSearch(String value) {
    state = value;
  }

  void clear() {
    state = '';
  }
}

final searchProvider = NotifierProvider<SearchNotifier, String>(
  SearchNotifier.new,
);
