class Pharms {
  String id;
  String nom;

  Pharms({this.id, this.nom});

  factory Pharms.fromJson(Map<String, dynamic> json) {
    return Pharms(
      id: json["id"] as String,
      nom: json["nom"] as String,
    );
  }
}
