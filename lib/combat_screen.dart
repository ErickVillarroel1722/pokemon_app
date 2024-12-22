import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pokemon_model.dart';
import 'pokemon_service.dart';
import 'dart:math';

class CombatScreen extends StatefulWidget {
  final Pokemon pokemon;

  const CombatScreen({super.key, required this.pokemon});

  @override
  _CombatScreenState createState() => _CombatScreenState();
}

class _CombatScreenState extends State<CombatScreen> {
  late Future<Pokemon> _randomPokemon;
  String _result = '';
  final String _imageUrl =
      'https://png.pngtree.com/background/20230528/original/pngtree-pokemon-adventure-forest-the-art-world-of-pokemon-wallpaper-picture-image_2778719.jpg';

  @override
  void initState() {
    super.initState();
    _randomPokemon = _fetchRandomPokemon();
  }

  // Función para obtener un Pokémon aleatorio (puedes cambiar esto para usar una API real si deseas)
  Future<Pokemon> _fetchRandomPokemon() async {
    const randomPokemonNames = ['pikachu', 'bulbasaur', 'charmander', 'squirtle'];
    final randomName = randomPokemonNames[DateTime.now().second % randomPokemonNames.length];
    return await PokemonService().fetchPokemon(randomName);
  }

  // Función para iniciar el combate y determinar el ganador de manera aleatoria
  void _startCombat(Pokemon randomPokemon) {
    setState(() {
      // Generamos un número aleatorio entre 0 y 2 para determinar el resultado
      final randomResult = Random().nextInt(3); // 0: Gana, 1: Pierde, 2: Empate

      if (randomResult == 0) {
        _result = '${widget.pokemon.name} gana el combate!';
      } else if (randomResult == 1) {
        _result = '${widget.pokemon.name} pierde el combate!';
      } else {
        _result = 'El combate terminó en empate!';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla de Combate'),
        backgroundColor: const Color(0xFF1E88E5),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(_imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 80),
                // Nombre del combate
                Text(
                  '¡Combate entre ${widget.pokemon.name} y un Pokémon aleatorio!',
                  style: GoogleFonts.pressStart2p(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // Mostrando Pokémon (Usuario arriba, Aleatorio abajo)
                FutureBuilder<Pokemon>(
                  future: _randomPokemon,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text(
                        'Error: ${snapshot.error}',
                        style: GoogleFonts.pressStart2p(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      );
                    } else if (snapshot.hasData) {
                      final randomPokemon = snapshot.data!;
                      return Column(
                        children: [
                          // Pokémon consultado por el usuario (Arriba)
                          _buildPokemonCard(widget.pokemon),
                          const SizedBox(height: 20),
                          // Pokémon aleatorio (Abajo)
                          _buildPokemonCard(randomPokemon),
                        ],
                      );
                    } else {
                      return Text(
                        'No se encontró el Pokémon aleatorio',
                        style: GoogleFonts.pressStart2p(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 40),
                // Botón para iniciar el combate
                ElevatedButton(
                  onPressed: () {
                    // Llamamos a la función para determinar el ganador de manera aleatoria
                    final randomPokemon = _randomPokemon as Pokemon;
                    _startCombat(randomPokemon);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: GoogleFonts.pressStart2p(
                      fontSize: 14,
                    ),
                  ),
                  child: const Text('Iniciar Combate'),
                ),
                const SizedBox(height: 40),
                // Mostrar el resultado del combate
                if (_result.isNotEmpty)
                  Text(
                    _result,
                    style: GoogleFonts.pressStart2p(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPokemonCard(Pokemon pokemon) {
    return Card(
      color: Colors.black.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FadeInImage.assetNetwork(
              placeholder: 'assets/placeholder.png',
              image: pokemon.imageUrl,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Text(
              pokemon.name.toUpperCase(),
              style: GoogleFonts.pressStart2p(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
