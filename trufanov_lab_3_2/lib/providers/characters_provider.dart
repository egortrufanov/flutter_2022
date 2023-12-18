import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../models/character/character_model.dart';
import '../models/query_data/query_data.dart';

class CharactersProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<CharacterModel> _characters = [];
  List<CharacterModel> get characters => _characters;

  final List<QueryData> _queriesHistory = [];
  List<QueryData> get queriesHistory => _queriesHistory;

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
      saveToDatabase();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveToDatabase() async {
    _isLoading = true;
    notifyListeners();
    var box = await Hive.openBox<QueryData>('QueryData');
    box.add(
      QueryData(
        foundedCharactersNumber: _characters.length,
        queryExecuteDateTime: DateTime.now(),
      ),
    );
    _isLoading = false;
    notifyListeners();
  }

  Future<void> readDatabase() async {
    queriesHistory.clear();
    _isLoading = true;
    notifyListeners();
    final box = await Hive.openBox<QueryData>('QueryData');
    queriesHistory.addAll(box.values.toList());
    _isLoading = false;
    notifyListeners();
  }
}
