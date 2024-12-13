import 'package:flutter/material.dart';
import 'anime_service.dart';  
import 'anime_details_screen.dart';  

class AnimeScreen extends StatefulWidget {
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
        backgroundColor: const Color.fromARGB(255, 16, 108, 230),
        title: Text('Anime List'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _animes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No anime found'));
          } else {
            final animes = snapshot.data!;
            return ListView.builder(
              itemCount: animes.length,
              itemBuilder: (context, index) {
                final anime = animes[index];
                return ListTile(
                  title: Text(anime['title']
                  ),  
                  leading: Image.network(anime['images']['jpg']['image_url']),  // Imagen del anime
                  onTap: () {
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnimeDetailsScreen(id: anime['mal_id']),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
