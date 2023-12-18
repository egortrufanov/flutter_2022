import 'package:equatable/equatable.dart';

import '../character_model.dart';

abstract class CharactersState extends Equatable {
  const CharactersState();

  @override
  List<Object> get props => [];
}

class InitialState extends CharactersState {}

class LoadingState extends CharactersState {}

class LoadedState extends CharactersState {
  final List<CharacterModel> characters;

  const LoadedState({required this.characters});
}

class FailedState extends CharactersState {
  final String errorMessage;

  const FailedState({
    required this.errorMessage,
  });
}
