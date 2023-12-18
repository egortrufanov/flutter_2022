class CharacterModel {
  final int id;
  final String name;
  final String imageUrl;

  CharacterModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  static CharacterModel fromJson(dynamic json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image'],
    );
  }
}
