class Pokemon {
  final String name;
  final String imageUrl;
  final List<Stat> stats;

  Pokemon({
    required this.name,
    required this.imageUrl,
    required this.stats,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    var statsFromJson = json['stats'] as List;
    List<Stat> statsList = statsFromJson.map((i) => Stat.fromJson(i)).toList();

    return Pokemon(
      name: json['name'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
      stats: statsList,
    );
  }

  get attack => null;
}

class Stat {
  final String statName;
  final int value;

  Stat({required this.statName, required this.value});

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
      statName: json['stat']['name'],
      value: json['base_stat'],
    );
  }
}
