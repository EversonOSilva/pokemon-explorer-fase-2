
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/move.dart';

class MoveService {
  static const String baseUrl = 'https://pokeapi.co/api/v2';

  Future<List<Move>> fetchMovesForPokemon(int pokemonId) async {
    // Busca os dados do Pokémon
    final pokemonUrl = Uri.parse(
      '$baseUrl/pokemon/$pokemonId',
    );

    final pokemonResponse = await http.get(pokemonUrl);

    if (pokemonResponse.statusCode != 200) {
      throw Exception('Erro ao buscar Pokémon');
    }

    final pokemonData = jsonDecode(pokemonResponse.body);

    // Obtém a lista de movimentos
    final movesList = pokemonData['moves'] as List;

    // Seleciona os primeiros 20 movimentos
    final selectedMoves = movesList.take(20);

    // Busca os detalhes de cada movimento
    final moves = await Future.wait(
      selectedMoves.map((item) async {
        final moveUrl = Uri.parse(
          item['move']['url'] as String,
        );

        final moveResponse = await http.get(moveUrl);

        if (moveResponse.statusCode != 200) {
          throw Exception('Erro ao buscar movimento');
        }

        final moveData = jsonDecode(moveResponse.body);

        return Move.fromJson(moveData);
      }),
    );

    return moves;
  }
}
