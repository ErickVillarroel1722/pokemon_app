import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pokemon_model.dart';
import 'pokemon_service.dart';

class CombatScreen extends StatefulWidget {
  final Pokemon pokemon;

  const CombatScreen({super.key, required this.pokemon});

  @override
  _CombatScreenState createState() => _CombatScreenState();
}

class _CombatScreenState extends State<CombatScreen> {
  late Future<Pokemon> _randomPokemon;
  Pokemon? _winnerPokemon;
  final String _imageUrl =
      'https://png.pngtree.com/background/20230528/original/pngtree-pokemon-adventure-forest-the-art-world-of-pokemon-wallpaper-picture-image_2778719.jpg';

  @override
  void initState() {
    super.initState();
    _randomPokemon = _fetchRandomPokemon();
  }

  // Obtener un Pokémon aleatorio
  Future<Pokemon> _fetchRandomPokemon() async {
    const randomPokemonNames = ['pikachu', 'bulbasaur', 'charmander', 'squirtle'];
    final randomName = randomPokemonNames[DateTime.now().second % randomPokemonNames.length];
    return await PokemonService().fetchPokemon(randomName);
  }

  // Iniciar el combate y determinar el ganador
  void _startCombat(Pokemon randomPokemon) {
    setState(() {
      // Elegir un Pokémon al azar como ganador
      final randomResult = [widget.pokemon, randomPokemon]..shuffle();
      _winnerPokemon = randomResult.first;
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
                Text(
                  '¡Combate Pokémon!',
                  style: GoogleFonts.pressStart2p(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      const Shadow(
                        blurRadius: 4,
                        color: Colors.black,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                if (_winnerPokemon == null)
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
                            _buildPokemonCard(widget.pokemon),
                            const SizedBox(height: 20),
                            _buildPokemonCard(randomPokemon),
                            const SizedBox(height: 40),
                            ElevatedButton(
                              onPressed: () {
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
                if (_winnerPokemon != null)
                  Column(
                    children: [
                      Text(
                        '¡Ganador!',
                        style: GoogleFonts.pressStart2p(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            const Shadow(
                              blurRadius: 4,
                              color: Colors.black,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildPokemonCard(_winnerPokemon!),
                    ],
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
