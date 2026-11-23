
import 'package:material_ui/material_ui.dart';

import '../models/pokemon.dart';
import '../screens/move_list_screen.dart';

// Cor utilizada nos indicadores dos tipos Pokémon.
const Color pokemonYellow = Color(0xFFFFC928);

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  final String Function(String) translateType;

  final String Function(String) capitalize;

  final bool isFavorite;

  final VoidCallback onFavoriteTap;

  const PokemonCard({
    super.key,
    required this.pokemon,
    required this.translateType,
    required this.capitalize,
    required this.isFavorite,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cartão principal do Pokémon.
          Container(
            width: double.infinity,
            height: 198,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(19),
              border: Border.all(
                color: const Color(0xFFE3E6ED),
                width: 1.3,
              ),
            ),
            child: Column(
              children: [
                // Nome, número e favorito.
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      capitalize(pokemon.name),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '#${pokemon.id.toString().padLeft(3, '0')}',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: onFavoriteTap,
                          padding: EdgeInsets.zero,
                          constraints:
                              const BoxConstraints(),
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isFavorite
                                ? Colors.red
                                : Colors.blueGrey,
                            size: 23,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const Spacer(),

                // Imagem do Pokémon.
                Container(
                  width: 138,
                  height: 116,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9EAEC),
                    borderRadius: BorderRadius.circular(19),
                  ),
                  child: Image.network(
                    pokemon.image,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.catching_pokemon,
                        size: 65,
                        color: Colors.grey,
                      );
                    },
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),

          const SizedBox(height: 9),

          // Tipos do Pokémon.
          Wrap(
            spacing: 6,
            children: pokemon.types.map((type) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: pokemonYellow,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  translateType(type),
                  style: const TextStyle(
                    color: Color(0xFF8C5900),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 9),

          // Acesso aos movimentos.
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return MoveListScreen(
                      pokemon: pokemon,
                    );
                  },
                ),
              );
            },
            child: const Row(
              children: [
                Text(
                  'Ver movimentos',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 13,
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.blueGrey,
                  size: 17,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
