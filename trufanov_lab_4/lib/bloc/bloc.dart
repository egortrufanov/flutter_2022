import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';

import '../character_model.dart';
import 'event.dart';
import 'state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  CharactersBloc() : super(InitialState()) {
    on<LoadDataEvent>(_loadData);
  }

  Future<void> _loadData(
      LoadDataEvent event, Emitter<CharactersState> emit) async {
    try {
      emit(LoadingState());
      final uri = Uri.parse('https://rickandmortyapi.com/api/character');
      final response = await http.get(uri);
      final decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      print(decodedResponse['results']);
      if (decodedResponse['results'] != null) {
        final characters = <CharacterModel>[];
        for (final item in decodedResponse['results']) {
          characters.add(CharacterModel.fromJson(item));
        }
        emit(LoadedState(characters: characters));
      }
    } catch (e) {
      emit(FailedState(errorMessage: e.toString()));
    }
  }
}
