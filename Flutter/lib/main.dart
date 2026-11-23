
import 'package:material_ui/material_ui.dart';

import 'models/pokemon.dart';
import 'services/pokemon_service.dart';
import 'services/favorites_service.dart';

import 'screens/favorites_screen.dart';
import 'screens/profile_screen.dart';

import 'widgets/pokemon_card.dart';
import 'widgets/bottom_menu.dart';
import 'widgets/app_header.dart';
import 'widgets/search_bar.dart';
import 'widgets/type_filter_sheet.dart';
import 'widgets/active_type_filters.dart';

// ============================================================
// CONFIGURAÇÕES VISUAIS
// ============================================================

const Color navy = Color(0xFF19365B);
const Color background = Color(0xFFF5F7FC);
const Color yellow = Color(0xFFFFC928);

const int pageSize = 25;

// Tradução dos tipos de Pokémon.
const Map<String, String> pokemonTypes = {
  'normal': 'Normal',
  'fire': 'Fogo',
  'water': 'Água',
  'electric': 'Elétrico',
  'grass': 'Planta',
  'ice': 'Gelo',
  'fighting': 'Lutador',
  'poison': 'Veneno',
  'ground': 'Terrestre',
  'flying': 'Voador',
  'psychic': 'Psíquico',
  'bug': 'Inseto',
  'rock': 'Pedra',
  'ghost': 'Fantasma',
  'dragon': 'Dragão',
  'dark': 'Sombrio',
  'steel': 'Aço',
  'fairy': 'Fada',
};

// ============================================================
// INICIALIZAÇÃO
// ============================================================

void main() {
  runApp(const PokemonExplorerApp());
}

class PokemonExplorerApp extends StatelessWidget {
  const PokemonExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokémon Explorer',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: navy,
        ),
      ),
      home: const PokedexScreen(),
    );
  }
}

// ============================================================
// TELA PRINCIPAL - POKÉDEX
// ============================================================

class PokedexScreen extends StatefulWidget {
  const PokedexScreen({super.key});

  @override
  State<PokedexScreen> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {

  // ==========================================================
  // SERVIÇOS
  // ==========================================================

  final PokemonService pokemonService = PokemonService();
  final FavoritesService favoritesService = FavoritesService();

  // ==========================================================
  // CAMPO DE PESQUISA
  // ==========================================================

  final TextEditingController searchController =
      TextEditingController();

  // ==========================================================
  // DADOS
  // ==========================================================

  late Future<List<Pokemon>> pokemonFuture;

  List<Pokemon> loadedPokemons = [];

  Set<int> favoriteIds = {};

  Set<String> selectedTypes = {};

  // ==========================================================
  // ESTADOS DA TELA
  // ==========================================================

  String searchText = '';

  int selectedMenu = 0;

  bool isLoadingMore = false;

  bool hasMore = true;

  // ==========================================================
  // CICLO DE VIDA
  // ==========================================================

  @override
  void initState() {
    super.initState();

    pokemonFuture = loadInitialPokemons();

    loadSavedFavorites();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // ==========================================================
  // CARREGAMENTO DOS POKÉMON
  // ==========================================================

  Future<List<Pokemon>> loadInitialPokemons() async {
    final pokemons = await pokemonService.fetchPokemons(
      limit: pageSize,
      offset: 0,
    );

    loadedPokemons = pokemons;

    hasMore = pokemons.length == pageSize;

    return pokemons;
  }

  Future<void> loadMorePokemons() async {
    if (isLoadingMore || !hasMore) return;

    setState(() {
      isLoadingMore = true;
    });

    try {
      final newPokemons = await pokemonService.fetchPokemons(
        limit: pageSize,
        offset: loadedPokemons.length,
      );

      if (!mounted) return;

      setState(() {
        loadedPokemons.addAll(newPokemons);

        hasMore = newPokemons.length == pageSize;

        isLoadingMore = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        isLoadingMore = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Não foi possível carregar mais Pokémon.',
          ),
        ),
      );
    }
  }

  void reloadPokemons() {
    setState(() {
      searchController.clear();

      searchText = '';

      selectedTypes.clear();

      loadedPokemons = [];

      hasMore = true;

      isLoadingMore = false;

      pokemonFuture = loadInitialPokemons();
    });
  }

  // ==========================================================
  // SISTEMA DE FAVORITOS
  // ==========================================================

  Future<void> loadSavedFavorites() async {
    final favorites = await favoritesService.getFavorites();

    if (!mounted) return;

    setState(() {
      favoriteIds = favorites;
    });
  }

  Future<void> toggleFavorite(Pokemon pokemon) async {
    final isFavorite =
        await favoritesService.toggleFavorite(pokemon.id);

    if (!mounted) return;

    setState(() {
      if (isFavorite) {
        favoriteIds.add(pokemon.id);
      } else {
        favoriteIds.remove(pokemon.id);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite
              ? '${capitalize(pokemon.name)} adicionado aos favoritos!'
              : '${capitalize(pokemon.name)} removido dos favoritos!',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ==========================================================
  // FUNÇÕES AUXILIARES
  // ==========================================================

  String translateType(String type) {
    return pokemonTypes[type] ?? type;
  }

  String capitalize(String value) {
    if (value.isEmpty) return value;

    return value[0].toUpperCase() + value.substring(1);
  }

  // ==========================================================
  // PESQUISA E FILTROS
  // ==========================================================

  List<Pokemon> get filteredPokemons {
    return loadedPokemons.where((pokemon) {
      final nameMatches = pokemon.name
          .toLowerCase()
          .contains(searchText);

      final numberMatches = pokemon.id
          .toString()
          .contains(searchText);

      final searchMatches =
          searchText.isEmpty || nameMatches || numberMatches;

      final typeMatches = selectedTypes.isEmpty ||
          pokemon.types.any(
            (type) => selectedTypes.contains(type),
          );

      return searchMatches && typeMatches;
    }).toList();
  }

  Future<void> openTypeFilters() async {
    final result = await showModalBottomSheet<Set<String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (context) {
        return TypeFilterSheet(
          selectedTypes: selectedTypes,
          pokemonTypes: pokemonTypes,
        );
      },
    );

    if (result != null && mounted) {
      setState(() {
        selectedTypes = result;
      });
    }
  }

  // ==========================================================
  // FILTROS ATIVOS
  // ==========================================================

  Widget buildActiveFilters() {
    return ActiveTypeFilters(
      selectedTypes: selectedTypes,
      translateType: translateType,
      onRemove: (type) {
        setState(() {
          selectedTypes.remove(type);
        });
      },
    );
  }

  // ==========================================================
  // CONSTRUÇÃO DA TELA PRINCIPAL
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  22,
                  12,
                  22,
                  12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppHeader(),

                    const SizedBox(height: 27),

                    const Text(
                      'Pokédex',
                      style: TextStyle(
                        color: navy,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 3),

                    const Text(
                      'Explore o mundo Pokémon',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 17),

                    buildSearch(),

                    if (selectedTypes.isNotEmpty)
                      buildActiveFilters(),

                    const SizedBox(height: 18),

                    buildPokemonList(),
                  ],
                ),
              ),
            ),

            buildBottomMenu(),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // CAMPO DE PESQUISA
  // ==========================================================

  Widget buildSearch() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 43,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: PokemonSearchField(
              controller: searchController,
              searchText: searchText,
              onChanged: (value) {
                setState(() {
                  searchText = value.trim().toLowerCase();
                });
              },
              onClear: () {
                searchController.clear();

                setState(() {
                  searchText = '';
                });
              },
            ),
          ),
        ),

        const SizedBox(width: 10),

        Container(
          width: 43,
          height: 43,
          decoration: BoxDecoration(
            color: navy,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Stack(
            children: [
              IconButton(
                onPressed: openTypeFilters,
                icon: const Icon(
                  Icons.tune,
                  color: Colors.white,
                  size: 21,
                ),
              ),

              if (selectedTypes.isNotEmpty)
                Positioned(
                  right: 5,
                  top: 5,
                  child: Container(
                    width: 9,
                    height: 9,
                    decoration: const BoxDecoration(
                      color: yellow,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // LISTA DE POKÉMON
  // ==========================================================

  Widget buildPokemonList() {
    return FutureBuilder<List<Pokemon>>(
      future: pokemonFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.only(top: 65),
            child: Center(
              child: CircularProgressIndicator(
                color: navy,
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                const Text(
                  'Não foi possível carregar os Pokémon.',
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 12),

                ElevatedButton(
                  onPressed: reloadPokemons,
                  child: const Text('Tentar novamente'),
                ),
              ],
            ),
          );
        }

        final results = filteredPokemons;

        if (results.isEmpty) {
          return const Padding(
            padding: EdgeInsets.only(top: 45),
            child: Center(
              child: Text('Nenhum Pokémon encontrado.'),
            ),
          );
        }

        return Column(
          children: [
            ...results.map((pokemon) {
              return PokemonCard(
                pokemon: pokemon,
                translateType: translateType,
                capitalize: capitalize,
                isFavorite: favoriteIds.contains(pokemon.id),
                onFavoriteTap: () => toggleFavorite(pokemon),
              );
            }),

            if (searchText.isEmpty &&
                selectedTypes.isEmpty) ...[
              const SizedBox(height: 8),

              if (isLoadingMore)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(
                    color: navy,
                  ),
                )
              else if (hasMore)
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: loadMorePokemons,
                    icon: const Icon(Icons.add),
                    label: const Text(
                      'Carregar mais Pokémon',
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: navy,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                    ),
                  ),
                )
              else
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Não há mais Pokémon para carregar.',
                  ),
                ),
            ],

            const SizedBox(height: 15),
          ],
        );
      },
    );
  }

  // ==========================================================
  // MENU INFERIOR
  // ==========================================================

  Widget buildBottomMenu() {
    return BottomMenu(
      selectedIndex: selectedMenu,
      onItemSelected: (index) {
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const FavoritesScreen(),
            ),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProfileScreen(
                trainerName: 'Treinador Pokémon',
                favoritesCount: favoriteIds.length,
                loadedPokemonCount: loadedPokemons.length,
              ),
            ),
          );
        } else {
          setState(() {
            selectedMenu = 0;
          });
        }
      },
    );
  }
}
