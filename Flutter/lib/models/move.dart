
class Move {
  final int id;
  final String name;
  final int? power;
  final int? accuracy;
  final int pp;
  final int? effectChance;
  final String type;
  final String damageClass;
  final String description;

  const Move({
    required this.id,
    required this.name,
    required this.power,
    required this.accuracy,
    required this.pp,
    required this.effectChance,
    required this.type,
    required this.damageClass,
    required this.description,
  });

  factory Move.fromJson(Map<String, dynamic> json) {
    final effectEntries =
        json['effect_entries'] as List<dynamic>;

    final englishEffect = effectEntries.firstWhere(
      (item) => item['language']['name'] == 'en',
      orElse: () => null,
    );

    return Move(
      id: json['id'] as int,
      name: json['name'] as String,
      power: json['power'] as int?,
      accuracy: json['accuracy'] as int?,
      pp: json['pp'] as int? ?? 0,
      effectChance: json['effect_chance'] as int?,
      type: json['type']['name'] as String,
      damageClass: json['damage_class']['name'] as String,
      description: englishEffect == null
          ? 'Descrição não disponível.'
          : englishEffect['effect'] as String,
    );
  }
}
