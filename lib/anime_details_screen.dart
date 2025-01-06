import 'package:flutter/material.dart';
import 'anime_service.dart';
import 'package:url_launcher/url_launcher.dart'; // Importamos para lanzar URLs

class AnimeDetailsScreen extends StatelessWidget {
  final int id;

  const AnimeDetailsScreen({super.key, required this.id});

  // Función para abrir el enlace del trailer en YouTube
  Future<void> _launchURL(String animeTitle) async {
    final String youtubeSearchQuery = Uri.encodeFull('$animeTitle trailer');
    final Uri url = Uri.parse('https://www.youtube.com/results?search_query=$youtubeSearchQuery');

    if (await canLaunch(url.toString())) {
      await launch(url.toString());
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 152, 230),
        title: const Text('Detalle del Anime'),
        elevation: 0,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: AnimeService().fetchAnimeDetails(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No details found'));
          } else {
            final anime = snapshot.data!;
            print(anime);
            final String animeTitle = anime['title']; // Obtenemos el título del anime

            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxHK--azp-C_HO89_r-3drTiboplHrnDknIQ&s'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    // Hero widget for image
                    Hero(
                      tag: anime['mal_id'],
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          anime['images']['jpg']['image_url'],
                          height: 225,
                          fit: BoxFit.cover,
                        ),
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
                      'Synopsis: ',
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
                    const SizedBox(height: 20),
                    // Botón para abrir el trailer en YouTube
                    ElevatedButton(
                      onPressed: () => _launchURL(animeTitle),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Hecha un vistazo!!',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
