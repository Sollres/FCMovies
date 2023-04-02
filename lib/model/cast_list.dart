class castList{
  final List<Cast> cast;

  CastList(this.cast);
}

class Cast{
  final String name;
  final String profilePath;
  final String caractere;

  Cast({this.name, this.profilePath, this.caractere});

  factory Cast.fromJson(dynamic json){
    if(json == null){
      return Cast();
    }

    return Cast(
      name: json['name'],
      profilePath: json['profil_path'],
      caractere: json['caractere']);

  }

}