import 'package:flutter/material.dart' show AppBar, Scaffold;
import 'package:flutter/widgets.dart';

import 'character_model.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({
    required this.character,
    Key? key,
  }) : super(key: key);

  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(character.id.toString())),
      body: Column(
        children: [
          Image.network(
            character.imageUrl,
            width: mediaQuery.size.width,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Text(
            character.name,
            style: const TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}
