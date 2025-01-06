import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
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
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF1E88E5), // Azul primario
          secondary: Color.fromARGB(255, 67, 249, 255), // Naranja
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPage = 0; // Controla la página seleccionada

  // Lista de páginas
  final List<Widget> _pages = [
    const PokemonScreen(), // Pantalla de Pokémon
    const AnimeScreen(), // Pantalla de Anime
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[_currentPage], // Muestra la página seleccionada
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentPage,
          onDestinationSelected: (int index) {
            setState(() {
              _currentPage = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(IconBroken.Heart),
              label: 'Pokedex',
            ),
            NavigationDestination(
              icon: Icon(IconBroken.Ticket),
              label: 'Anime',
            ),
          ],
        ),
      ),
    );
  }
}
