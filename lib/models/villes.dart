class Villes {
  String id;
  String nom;
  String image;
  Villes({this.id, this.nom, this.image});

  factory Villes.fromJson(Map<String, dynamic> json) {
    return Villes(
      id: json["id"] as String,
      nom: json["nom"] as String,
      image: json["image"] as String,
    );
  }
}
