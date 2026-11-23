import 'package:material_ui/material_ui.dart';

import '../models/move.dart';
import '../models/pokemon.dart';

class MoveDetailScreen extends StatelessWidget {
  final Move move;
  final Pokemon pokemon;

  const MoveDetailScreen({
    super.key,
    required this.move,
    required this.pokemon,
  });

  static const navy = Color(0xFF19365B);
  static const background = Color(0xFFF5F7FC);
  static const red = Color(0xFFFF5656);

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

    return translations[type] ?? type;
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

  String formatMoveName(String name) {
    return name
        .replaceAll('-', ' ')
        .split(' ')
        .map(
          (word) => word.isEmpty
              ? word
              : '${word[0].toUpperCase()}${word.substring(1)}',
        )
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(14, 8, 14, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMoveCard(),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildStatCard(move.power?.toString() ?? '—', 'Poder'),
                        const SizedBox(width: 8),
                        _buildStatCard(
                          move.accuracy == null ? '—' : '${move.accuracy}%',
                          'Precisão',
                        ),
                        const SizedBox(width: 8),
                        _buildStatCard(move.pp.toString(), 'PP'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Efeito especial',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      move.effectChance == null
                          ? 'Sem chance de efeito adicional informada.'
                          : 'Chance de efeito: ${move.effectChance}%',
                      style: const TextStyle(
                        color: Colors.black45,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: red,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: const Text(
                          'Voltar aos Movimentos',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildBottomMenu(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 2, 12, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, size: 18, color: navy),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(32, 32),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search, size: 18, color: navy),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(32, 32),
                ),
              ),
            ],
          ),
          const Text(
            'Detalhes do Movimento',
            style: TextStyle(
              color: navy,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoveCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(10, 7, 10, 8),
      decoration: BoxDecoration(
        color: const Color(0xFFECECEE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 110,
            height: 74,
            child: Image.network(
              pokemon.image,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.catching_pokemon,
                  color: navy,
                  size: 52,
                );
              },
            ),
          ),
          Text(
            formatMoveName(move.name),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              color: typeColor(move.type),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              translateType(move.type),
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ).copyWith(color: move.type == 'electric' ? navy : Colors.white),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            move.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black45,
              fontSize: 9,
              height: 1.15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Expanded(
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFFE8E8EA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(color: Colors.black54, fontSize: 8),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomMenu() {
    return Container(
      height: 54,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE5E5E5))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _menuItem(Icons.explore_outlined, 'Explorar', false),
          _menuItem(Icons.favorite, 'Favoritos', true),
          _menuItem(Icons.person_outline, 'Perfil', false),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String label, bool selected) {
    final color = selected ? navy : Colors.blueGrey;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 8,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        const SizedBox(height: 3),
        Container(
          width: 24,
          height: 2,
          color: selected ? color : Colors.transparent,
        ),
      ],
    );
  }
}
