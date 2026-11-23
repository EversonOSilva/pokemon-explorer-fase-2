
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String _key = 'favorite_pokemon_ids';

  // Busca os IDs dos Pokémon favoritos.
  Future<Set<int>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteIds = prefs.getStringList(_key) ?? [];

    return favoriteIds
        .map((id) => int.parse(id))
        .toSet();
  }

  // Verifica se um Pokémon está nos favoritos.
  Future<bool> isFavorite(int pokemonId) async {
    final favorites = await getFavorites();

    return favorites.contains(pokemonId);
  }

  // Adiciona ou remove um Pokémon dos favoritos.
  Future<bool> toggleFavorite(int pokemonId) async {
    final prefs = await SharedPreferences.getInstance();

    final favorites = await getFavorites();

    if (favorites.contains(pokemonId)) {
      favorites.remove(pokemonId);
    } else {
      favorites.add(pokemonId);
    }

    await prefs.setStringList(
      _key,
      favorites.map((id) => id.toString()).toList(),
    );

    return favorites.contains(pokemonId);
  }
}
