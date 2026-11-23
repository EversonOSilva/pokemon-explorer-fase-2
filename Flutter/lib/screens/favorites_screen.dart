
import 'package:material_ui/material_ui.dart';

import '../models/pokemon.dart';
import '../services/favorites_service.dart';
import '../services/pokemon_service.dart';
import '../main.dart';
import 'move_list_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FavoritesService favoritesService = FavoritesService();
  final PokemonService pokemonService = PokemonService();

  late Future<List<Pokemon>> favoritesFuture;

  @override
  void initState() {
    super.initState();
    favoritesFuture = loadFavorites();
  }

  Future<List<Pokemon>> loadFavorites() async {
    final ids = await favoritesService.getFavorites();

    final pokemons = await Future.wait(
      ids.map((id) => pokemonService.fetchPokemonById(id)),
    );

    pokemons.sort((a, b) => a.id.compareTo(b.id));

    return pokemons;
  }

  Future<void> removeFavorite(int id) async {
    await favoritesService.toggleFavorite(id);

    if (!mounted) return;

    setState(() {
      favoritesFuture = loadFavorites();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pokémon removido dos favoritos.'),
      ),
    );
  }

  String capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        title: const Text('Meus Favoritos'),
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: favoritesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: navy),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Não foi possível carregar os favoritos.'),
            );
          }

          final pokemons = snapshot.data ?? [];

          if (pokemons.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 65,
                    color: Colors.blueGrey,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Você ainda não tem favoritos.',
                    style: TextStyle(
                      color: navy,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text('Volte à Pokédex e marque seus Pokémon preferidos.'),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: pokemons.length,
            itemBuilder: (context, index) {
              final pokemon = pokemons[index];

              return Card(
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: Image.network(
                    pokemon.image,
                    width: 65,
                    errorBuilder: (_, _, _) =>
                        const Icon(Icons.catching_pokemon),
                  ),
                  title: Text(
                    capitalize(pokemon.name),
                    style: const TextStyle(
                      color: navy,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '#${pokemon.id.toString().padLeft(3, '0')}',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            MoveListScreen(pokemon: pokemon),
                      ),
                    );
                  },
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    onPressed: () => removeFavorite(pokemon.id),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
