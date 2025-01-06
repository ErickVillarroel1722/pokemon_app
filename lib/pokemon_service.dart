import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'pokemon_model.dart';

class PokemonService {
  Future<Pokemon> fetchPokemon(String pokemonName) async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonName'));

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }
      return Pokemon.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Pokemon');
    }
  }
}
