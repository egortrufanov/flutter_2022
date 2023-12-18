import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/pokemon_model.dart';
import 'widgets/pokemon_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = false;
  List<PokemonModel> pokemons = [];

  Future<void> _fetchPokemons() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/');
    final response = await http.get(url);
    final decodedResponse = jsonDecode(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      pokemons.clear();
      for (var item in decodedResponse['results']) {
        // print(item);
        pokemons.add(
          PokemonModel(
            id: item['id'],
            name: item['name'],
            // height: item['height'],
            //       // isDefault: item['is_default'],
            order: item['order'],
            //       // weight: item['weight'],
            //       // sprite: item['front_default'],
          ),
        );
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _fetchPokemons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : pokemons.isNotEmpty
                ? ListView(
                    children: <Widget>[
                      for (var pokemon in pokemons)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PokemonCard(
                            name: pokemon.name,
                            // height: pokemon.height,
                            // isDefault: pokemon.isDefault,
                            order: pokemon.order,
                            // weight: pokemon.weight,
                            // sprite: pokemon.sprite,
                          ),
                        ),
                    ],
                  )
                : const Center(
                    child: Text("Покемоны не загружены"),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchPokemons,
        tooltip: 'Increment',
        child: pokemons.isEmpty
            ? const Icon(Icons.download)
            : const Icon(Icons.refresh),
      ),
    );
  }
}
