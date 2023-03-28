class Genre {
  final int? id;
  final String name;

  String? error;

  Genre({this.id, required this.name});
  Genre.withError(this.error, this.id, this.name);

  factory Genre.fromJson(dynamic json) {
    if(json == null){
      return Genre(name: '');
    }
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
}