import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pokemon_service.dart';
import 'pokemon_model.dart';
import 'combat_screen.dart';


class PokemonScreen extends StatefulWidget {
  const PokemonScreen({super.key});

  @override
  _PokemonScreenState createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  final TextEditingController _controller = TextEditingController();
  late Future<Pokemon> _pokemon;
  String _pokemonName = 'ditto';
  final String _imageUrl = 'https://png.pngtree.com/background/20230528/original/pngtree-pokemon-adventure-forest-the-art-world-of-pokemon-wallpaper-picture-image_2778719.jpg';

  @override
  void initState() {
    super.initState();
    _pokemon = PokemonService().fetchPokemon(_pokemonName);
  }

  void _searchPokemon() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _pokemonName = _controller.text.toLowerCase();
        _pokemon = PokemonService().fetchPokemon(_pokemonName);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingresa un nombre de Pokémon.'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Escribe el nombre de un Pokémon',
                    labelStyle: GoogleFonts.pressStart2p(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 241, 236, 236),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search, color: Colors.blueAccent),
                      onPressed: _searchPokemon,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FutureBuilder<Pokemon>(
                  future: _pokemon,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text(
                        'Error: ${snapshot.error}',
                        style: GoogleFonts.pressStart2p(
                          color: Colors.red,
                          fontSize: 14,
                          shadows: [
                            const Shadow(
                              blurRadius: 4,
                              color: Colors.black,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasData) {
                      final pokemon = snapshot.data!;
                      return Column(
                        children: [
                          FadeInImage.assetNetwork(
                            placeholder: 'assets/placeholder.png',
                            image: pokemon.imageUrl,
                            height: 250,
                            width: 250,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            pokemon.name.toUpperCase(),
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
                          Text(
                            'Estadísticas:',
                            style: GoogleFonts.pressStart2p(
                              fontSize: 16,
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
                          const SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                                // ignore: deprecated_member_use
                                color: Colors.black.withOpacity(0.5),
                              ),
                              child: DataTable(
                                columnSpacing: 20,
                                headingRowHeight: 40,
                                dataRowHeight: 50,
                                columns: [
                                  DataColumn(
                                    label: Text(
                                      'Estadística',
                                      style: GoogleFonts.pressStart2p(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Valor',
                                      style: GoogleFonts.pressStart2p(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                                rows: pokemon.stats.map((stat) {
                                  return DataRow(cells: [
                                    DataCell(Text(
                                      stat.statName.capitalize(),
                                      style: GoogleFonts.pressStart2p(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    )),
                                    DataCell(Text(
                                      stat.value.toString(),
                                      style: GoogleFonts.pressStart2p(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    )),
                                  ]);
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              print('¡Combate iniciado con $_pokemonName!');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CombatScreen(pokemon: pokemon),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              textStyle: GoogleFonts.pressStart2p(
                                fontSize: 14,
                              ),
                            ),
                            child: const Text('Combate'),
                          ),
                        ],
                      );
                    } else {
                      return Text(
                        'No se encontró el Pokémon',
                        style: GoogleFonts.pressStart2p(
                          color: Colors.white,
                          shadows: [
                            const Shadow(
                              blurRadius: 4,
                              color: Colors.black,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension StringCapitalize on String {
  String capitalize() {
    return this[0].toUpperCase() + substring(1);
  }
}
