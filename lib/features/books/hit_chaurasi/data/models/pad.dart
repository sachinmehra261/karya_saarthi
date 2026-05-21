class Pad {
  final int id;
  final String title;
  final String verse;

  const Pad({required this.id, required this.title, required this.verse});

  factory Pad.fromJson(Map<String, dynamic> json) {
    return Pad(id: json["id"], title: json["title"], verse: json["verse"]);
  }
}
