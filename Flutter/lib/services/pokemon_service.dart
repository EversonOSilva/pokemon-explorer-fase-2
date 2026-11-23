
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/pokemon.dart';

class PokemonService {
  // Endereço principal da PokéAPI.
  static const String baseUrl = 'https://pokeapi.co/api/v2';

  // Busca uma lista de Pokémon com paginação.
  Future<List<Pokemon>> fetchPokemons({
    int limit = 25,
    int offset = 0,
  }) async {
    final url = Uri.parse(
      '$baseUrl/pokemon?limit=$limit&offset=$offset',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar lista de Pokémon.');
    }

    final data = jsonDecode(response.body);
    final results = data['results'] as List;

    // Busca os detalhes de cada Pokémon encontrado.
    final pokemons = await Future.wait(
      results.map((item) async {
        final pokemonUrl = Uri.parse(
          item['url'] as String,
        );

        final detailResponse = await http.get(pokemonUrl);

        if (detailResponse.statusCode != 200) {
          throw Exception('Erro ao buscar detalhes do Pokémon.');
        }

        final detail = jsonDecode(detailResponse.body);

        return Pokemon.fromJson(detail);
      }),
    );

    return pokemons;
  }

  // Busca um Pokémon específico pelo seu número (ID).
  // Utilizado principalmente na tela de Favoritos.
  Future<Pokemon> fetchPokemonById(int id) async {
    final url = Uri.parse('$baseUrl/pokemon/$id');

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar Pokémon favorito.');
    }

    final data = jsonDecode(response.body);

    return Pokemon.fromJson(data);
  }
}
