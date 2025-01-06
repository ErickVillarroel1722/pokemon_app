import 'dart:convert';
import 'package:http/http.dart' as http;

class AnimeService {
  static const String baseUrl = 'https://api.jikan.moe/v4/anime';

  Future<List<dynamic>> fetchAnimes() async {
    final response = await http.get(Uri.parse('$baseUrl?page=1'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to load animes');
    }
  }

  Future<Map<String, dynamic>> fetchAnimeDetails(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to load anime details');
    }
  }
}
