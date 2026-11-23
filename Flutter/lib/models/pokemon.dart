
class Pokemon {
  final int id;
  final String name;
  final String image;
  final List<String> types;

  const Pokemon({
    required this.id,
    required this.name,
    required this.image,
    required this.types,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final List<dynamic> typesList = json['types'];

    final sprites = json['sprites'];
    final other = sprites['other'];
    final artwork = other['official-artwork'];

    return Pokemon(
      id: json['id'] as int,
      name: json['name'] as String,
      image: (artwork['front_default'] ??
              sprites['front_default'] ??
              '') as String,
      types: typesList.map((item) {
        return item['type']['name'] as String;
      }).toList(),
    );
  }
}
