import 'package:material_ui/material_ui.dart';

import '../models/pokemon.dart';
import '../models/move.dart';
import '../services/move_service.dart';
import 'move_detail_screen.dart';

class MoveListScreen extends StatefulWidget {
  final Pokemon pokemon;

  const MoveListScreen({super.key, required this.pokemon});

  @override
  State<MoveListScreen> createState() => _MoveListScreenState();
}

class _MoveListScreenState extends State<MoveListScreen> {
  final MoveService moveService = MoveService();

  late Future<List<Move>> movesFuture;

  static const navy = Color(0xFF19365B);
  static const background = Color(0xFFF5F7FC);
  static const red = Color(0xFFE74C3C);

  @override
  void initState() {
    super.initState();

    movesFuture = moveService.fetchMovesForPokemon(widget.pokemon.id);
  }

  String capitalize(String text) {
    if (text.isEmpty) return text;

    return text[0].toUpperCase() + text.substring(1);
  }

  String formatName(String name) {
    return name.replaceAll('-', ' ').split(' ').map(capitalize).join(' ');
  }

  String translateType(String type) {
    const translations = {
      'normal': 'Normal',
      'fire': 'Fogo',
      'water': 'Água',
      'electric': 'Elétrico',
      'grass': 'Planta',
      'ice': 'Gelo',
      'fighting': 'Lutador',
      'poison': 'Veneno',
      'ground': 'Terra',
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

    return translations[type] ?? capitalize(type);
  }

  Color typeColor(String type) {
    const colors = {
      'electric': Color(0xFFFFC928),
      'fire': Color(0xFFEF6C45),
      'water': Color(0xFF4599E8),
      'grass': Color(0xFF55B96B),
      'normal': Color(0xFF999999),
      'ice': Color(0xFF75CFCB),
      'fighting': Color(0xFFC65A45),
      'poison': Color(0xFF9B65B5),
      'ground': Color(0xFFBE9657),
      'flying': Color(0xFF8B9DE0),
      'psychic': Color(0xFFE36A9A),
      'bug': Color(0xFF94A83D),
      'rock': Color(0xFFAA965D),
      'ghost': Color(0xFF7663A8),
      'dragon': Color(0xFF6752C7),
      'dark': Color(0xFF625B55),
      'steel': Color(0xFF8D9DA8),
      'fairy': Color(0xFFE69DBB),
    };

    return colors[type] ?? navy;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: FutureBuilder<List<Move>>(
                future: movesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: navy),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, color: red, size: 40),
                          const SizedBox(height: 12),
                          const Text('Erro ao carregar movimentos.'),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                movesFuture = moveService.fetchMovesForPokemon(
                                  widget.pokemon.id,
                                );
                              });
                            },
                            child: const Text('Tentar novamente'),
                          ),
                        ],
                      ),
                    );
                  }

                  final moves = snapshot.data ?? [];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPokemonCard(),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 5, 16, 2),
                        child: const Text(
                          'Movimentos',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: navy,
                          ),
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Selecione um movimento para ver seus detalhes',
                          style: TextStyle(fontSize: 11, color: Colors.black54),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Expanded(
                        child: moves.isEmpty
                            ? const Center(
                                child: Text('Nenhum movimento encontrado.'),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.fromLTRB(
                                  12,
                                  0,
                                  12,
                                  12,
                                ),
                                itemCount: moves.length,
                                itemBuilder: (context, index) {
                                  return _buildMoveCard(moves[index]);
                                },
                              ),
                      ),
                    ],
                  );
                },
              ),
            ),

            _buildBottomMenu(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new, size: 17, color: navy),
          ),

          const Expanded(
            child: Text(
              'Pokémon Explorer',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: navy,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, size: 20, color: navy),
          ),
        ],
      ),
    );
  }

  Widget _buildPokemonCard() {
    final pokemon = widget.pokemon;

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 4, 12, 5),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),

      child: Row(
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F1F1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.network(
              pokemon.image,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.catching_pokemon,
                  size: 35,
                  color: navy,
                );
              },
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formatName(pokemon.name),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: navy,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  '#${pokemon.id.toString().padLeft(3, '0')} '
                  'Pokémon ${pokemon.types.isNotEmpty ? translateType(pokemon.types.first) : ""}',
                  style: const TextStyle(fontSize: 10, color: Colors.black54),
                ),

                const SizedBox(height: 5),

                if (pokemon.types.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: typeColor(pokemon.types.first),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      translateType(pokemon.types.first),
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoveCard(Move move) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
        side: const BorderSide(color: Color(0xFFE1E1E1)),
      ),

      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    formatName(move.name),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: navy,
                    ),
                  ),
                ),

                Text(
                  translateType(move.type),
                  style: TextStyle(
                    fontSize: 9,
                    color: typeColor(move.type),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),

            Text(
              'Poder: ${move.power ?? "—"}'
              ' • Precisão: ${move.accuracy == null ? "—" : "${move.accuracy}%"}'
              ' • PP: ${move.pp}',
              style: const TextStyle(fontSize: 9, color: Colors.black54),
            ),

            const SizedBox(height: 4),

            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MoveDetailScreen(
                          move: move,
                          pokemon: widget.pokemon,
                        );
                      },
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 2),
                  child: Text(
                    'Detalhes →',
                    style: TextStyle(
                      color: red,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomMenu() {
    return Container(
      height: 58,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE5E5E5))),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _menuItem(Icons.explore_outlined, 'Explorar', true),
          _menuItem(Icons.favorite_border, 'Favoritos', false),
          _menuItem(Icons.person_outline, 'Perfil', false),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String label, bool selected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 18, color: selected ? navy : Colors.blueGrey),
        const SizedBox(height: 3),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            color: selected ? navy : Colors.blueGrey,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
