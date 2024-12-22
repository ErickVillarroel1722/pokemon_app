import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';  // Importa url_launcher
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
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF1E88E5), // Azul primario
          secondary: const Color.fromARGB(255, 67, 249, 255), // Naranja
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 245, 239, 235), // Fondo gris claro
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E88E5), // Azul primario
          elevation: 0, // Sin sombra
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black), 
          bodyMedium: TextStyle(color: Colors.black),
          titleLarge: TextStyle(color: Colors.white), // Títulos en blanco
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 20, 200, 245), // Naranja
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
        ),
      ),
      home: const MyHomePage(), 
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null, // No necesitamos título, la imagen será el centro
        backgroundColor: const Color(0xFF1E88E5),  // Azul primario
        centerTitle: true,  // Asegura que todo esté centrado
        actions: [
          // Botón derecho
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: ElevatedButton(
              onPressed: () {
                // Redirigir a la página de Anime
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AnimeScreen()), 
                );
              },
              child: const Text(
                'Anime',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
        flexibleSpace: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/International_Pok%C3%A9mon_logo.svg/1024px-International_Pok%C3%A9mon_logo.svg.png', 
              width: 150,  // Tamaño de la imagen
              height: 50, 
              fit: BoxFit.cover, 
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: ElevatedButton(
            onPressed: () async {
              // Redirigir al enlace de Pokémon Showdown
              const url = 'https://play.pokemonshowdown.com/';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'No se pudo abrir la URL: $url';
              }
            },
            child: const Text(
              'Izquierda',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: const PokemonScreen(),  // Solo el contenido de Pokémon
    );
  }
}
