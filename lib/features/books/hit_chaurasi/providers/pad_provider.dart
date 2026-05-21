import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/pad.dart';
import '../data/repositories/pad_repository.dart';

final padProvider =
    FutureProvider<List<Pad>>(
  (ref) async {
    return PadRepository()
        .getPads();
  },
);