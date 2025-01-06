import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icon_broken/icon_broken.dart';
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
        backgroundColor: Colors.transparent,
        centerTitle: true,
        flexibleSpace: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Image.asset('assets/pokemon-logo-png-1428.png')
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/dbVhEdt.jpg'
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Buscar Pokemón',
                    labelStyle: GoogleFonts.pressStart2p(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    suffix: IconButton(onPressed: _searchPokemon, icon: const Icon(IconBroken.Search))
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    width: MediaQuery.sizeOf(context).width,
                    child: FutureBuilder<Pokemon>(
                      future: _pokemon,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            width: MediaQuery.sizeOf(context).width,
                            height: MediaQuery.sizeOf(context).height / 2,
                            child: Column(
                              spacing: 16,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(IconBroken.Danger, size: 50, color: Colors.white),
                                Text("Oh no! Ese pokemón no existe",
                                  style: GoogleFonts.pressStart2p(color: Colors.red, textStyle: const TextStyle(fontSize: 20)),
                                  textAlign: TextAlign.center,
                                ),
                                Text("Intenta nuevamente.",
                                  style: GoogleFonts.pressStart2p(color: Colors.white, textStyle: const TextStyle(fontSize: 18)),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )
                          );
                        } else if (snapshot.hasData) {
                          final pokemon = snapshot.data!;
                          if (kDebugMode) {
                            print(pokemon);
                          }
                          return Column(
                            children: [
                              Row(
                                spacing: 18,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: pokemon.imageUrl,
                                    placeholder: (context, url) => const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                    width: 120,
                                    height: 120,
                                  ),
                                  Text(
                                    pokemon.name.toUpperCase(),
                                    style: GoogleFonts.pressStart2p(
                                      fontSize: 20,
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
                                ],
                              ),
                              const SizedBox(height: 40),
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
                              Container(
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
                              const SizedBox(height: 20),
                              FilledButton(
                                onPressed: () {
                                  if (kDebugMode) {
                                    print('¡Combate iniciado con $_pokemonName!');
                                  }
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CombatScreen(pokemon: pokemon),
                                    ),
                                  );
                                },
                                child: Text('Combate', style: GoogleFonts.pressStart2p(color: Colors.white),),
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
                  ),
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
