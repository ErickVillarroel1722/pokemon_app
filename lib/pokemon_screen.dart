import 'package:flutter/material.dart';
import 'pokemon_service.dart';
import 'pokemon_model.dart';

class PokemonScreen extends StatefulWidget {
  @override
  _PokemonScreenState createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  final TextEditingController _controller = TextEditingController();
  late Future<Pokemon> _pokemon;
  String _pokemonName = 'ditto'; 
  final String _imageUrl = 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/International_Pok%C3%A9mon_logo.svg/1024px-International_Pok%C3%A9mon_logo.svg.png'; // Imagen URL personalizada

  @override
  void initState() {
    super.initState();
    _pokemon = PokemonService().fetchPokemon(_pokemonName);
  }

  void _searchPokemon() {
    setState(() {
      _pokemonName = _controller.text.toLowerCase();
      _pokemon = PokemonService().fetchPokemon(_pokemonName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.blueAccent,
        actions: [
          Container(
            padding: EdgeInsets.all(8),
            child: Image.network(
              _imageUrl, 
              width: 125, // Tamaño de la imagen
              height: 50, 
              fit: BoxFit.cover, // Ajuste de la imagen
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Escribe el nombre de un Pokémon',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchPokemon,
                ),
              ),
            ),
            SizedBox(height: 20),
            FutureBuilder<Pokemon>(
              future: _pokemon,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final pokemon = snapshot.data!;
                  return Column(
                    children: [
                      
                      Image.network(
                        pokemon.imageUrl,
                        height: 250, 
                        width: 250, 
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 20),
                      Text(
                        pokemon.name.toUpperCase(),
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Estadísticas:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      for (var stat in pokemon.stats)
                        Text(
                          '${stat.statName.capitalize()} : ${stat.value}',
                          style: TextStyle(fontSize: 18),
                        ),
                    ],
                  );
                } else {
                  return Text('No se encontró el Pokémon');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

extension StringCapitalize on String {
  String capitalize() {
    return this[0].toUpperCase() + this.substring(1);
  }
}
