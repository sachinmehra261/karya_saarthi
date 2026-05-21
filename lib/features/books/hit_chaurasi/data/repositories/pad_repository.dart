import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:karya_sarthi/features/books/hit_chaurasi/data/models/pad.dart';

class PadRepository {
  Future<List<Pad>> getPads() async {
    final jsonString = await rootBundle.loadString(
      "assets/data/hit_chaurasi.json",
    );

    final data = jsonDecode(jsonString);

    return (data as List).map((e) => Pad.fromJson(e)).toList();
  }
}
