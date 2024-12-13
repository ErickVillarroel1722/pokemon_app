import 'package:flutter/material.dart';
import 'pokemon_screen.dart';
import 'anime_screen.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokeanime',  
      theme: ThemeData(
        primarySwatch: Colors.blue,  
      ),
      home: MyHomePage(), 
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pokémon & Anime',
          style: TextStyle(color: Colors.white), 
        ),
        backgroundColor: Colors.blue,  
        actions: [
          
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnimeScreen()),
                );
              },
              child: Text(
                'Haz click para ver nuestras recomendaciones de anime',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      body: PokemonScreen(),  
    );
  }
}
