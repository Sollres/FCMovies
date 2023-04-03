class CastList{
  final List<Cast> cast;

  CastList(this.cast);
}

class Cast{
  final String name;
  final String profilePath;
  final String caractere;

  Cast({required this.name, required this.profilePath, required this.caractere});

  factory Cast.fromJson(dynamic json){
    if(json == null){
      return Cast(caractere: '', name: '', profilePath: '');
    }

    return Cast(
      name: json['name'],
      profilePath: json['profil_path'],
      caractere: json['caractere']);

  }

}