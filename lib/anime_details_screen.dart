import 'package:flutter/material.dart';
import 'anime_service.dart';

class AnimeDetailsScreen extends StatelessWidget {
  final int id;
  
  const AnimeDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 148, 230, 16),
        title: const Text('Anime Details'),
        elevation: 0,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: AnimeService().fetchAnimeDetails(id),  // Llamamos al servicio para obtener detalles
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No details found'));
          } else {
            final anime = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      anime['images']['jpg']['image_url'],  // Imagen del anime
                      height: 225,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    anime['title'],
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 134, 76, 233),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Genres: ${anime['genres'].map((genre) => genre['name']).join(', ')}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Synopsis:',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    anime['synopsis'],
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Score: ${anime['score']}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
