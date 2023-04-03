class Person {
  final String id;
  final String gender;
  final String name;
  final String? profilePath;
  final String knownForDepartment;
  final String popularity;

  Person({
    required this.id,
    required this.gender,
    required this.name,
    required this.profilePath,
    required this.knownForDepartment,
    required this.popularity,
  });

  factory Person.fromJson(dynamic json) {
    if (json == null) {
      return Person(id: '', gender: '', knownForDepartment: '', name: '', popularity: '', profilePath: '', );
    }

    return Person(
      id: json['id'].toString(),
      gender: json['gender'].toString(),
      name: json['name'],
      profilePath: json['profilePath'],
      knownForDepartment: json['known_for_department'],
      popularity: json['popularity'].toString(),
    );
  }
}
