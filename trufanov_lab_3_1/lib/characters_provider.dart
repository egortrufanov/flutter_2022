import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'character_model.dart';

class CharactersProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<CharacterModel> _characters = [];
  List<CharacterModel> get characters => _characters;

  Future<void> fetchCharacters() async {
    _isLoading = true;
    notifyListeners();
    final uri = Uri.parse('https://rickandmortyapi.com/api/character');
    final response = await http.get(uri);
    final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    print(decodedResponse['results']);
    if (decodedResponse['results'] != null) {
      _characters.clear();
      for (final item in decodedResponse['results']) {
        _characters.add(CharacterModel.fromJson(item));
      }
    }
    _isLoading = false;
    notifyListeners();
  }
}
