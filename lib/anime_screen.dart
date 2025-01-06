import 'package:flutter/material.dart';
import 'anime_service.dart';
import 'anime_details_screen.dart';

class AnimeScreen extends StatefulWidget {
  const AnimeScreen({super.key});

  @override
  _AnimeScreenState createState() => _AnimeScreenState();
}

class _AnimeScreenState extends State<AnimeScreen> {
  late Future<List<dynamic>> _animes;

  @override
  void initState() {
    super.initState();
    _animes = AnimeService().fetchAnimes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 127, 230),
        title: const Text('Anime List', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _animes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No anime found'));
          } else {
            final animes = snapshot.data!;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://image.cdn2.seaart.me/2023-10-11/19597303690060805/9dce93ad8db660aa78705c3cac1183beb663a09d_high.webp'),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView.builder(
                itemCount: animes.length,
                itemBuilder: (context, index) {
                  final anime = animes[index];
                  return Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: Hero(
                        tag: anime['mal_id'],
                        child: Image.network(anime['images']['jpg']['image_url'])
                      ),
                      title: Text(
                        anime['title'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Genres: ${anime['genres'].map((genre) => genre['name']).join(', ')}'),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward_ios_rounded, size: 20, color: Theme.of(context).primaryColor),
                        onPressed: () {
                          // Aquí se navega a la pantalla de detalles con Hero
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AnimeDetailsScreen(id: anime['mal_id']),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
