class Villes {
  String id;
  String nom;

  Villes({this.id, this.nom});

  factory Villes.fromJson(Map<String, dynamic> json) {
    return Villes(
      id: json["id"] as String,
      nom: json["nom"] as String,
    );
  }
}
