
class Pharms {
  String id;
  String nom;
  String responsable;
  String tel;
  Null jourGarde;
  String image;
  String lati;
  String longi;
  String idVille;

  Pharms(
      {
      this.id,
      this.nom,
      this.responsable,
      this.tel,
      this.jourGarde,
      this.image,
      this.lati,
      this.longi,
      this.idVille});

  Pharms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    responsable = json['responsable'];
    tel = json['tel'];
    jourGarde = json['jourGarde'];
    image = json['image'];
    lati = json['lati'];
    longi = json['longi'];
    idVille = json['idVille'];
  }

}

