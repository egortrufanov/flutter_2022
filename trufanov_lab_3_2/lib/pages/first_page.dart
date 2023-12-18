import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/characters_provider.dart';
import 'second_page.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final providerWatch = context.watch<CharactersProvider>();
    final providerRead = context.read<CharactersProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Список персонажей")),
      body: Center(
        child: providerWatch.isLoading
            ? const CircularProgressIndicator.adaptive()
            : RefreshIndicator(
                onRefresh: () {
                  return providerRead.fetchCharacters();
                },
                child: ListView.builder(
                  itemCount: providerWatch.characters.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => SecondPage(
                              character: providerWatch.characters[index],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Container(
                          width: mediaQuery.size.width,
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                                  child: Image.network(
                                    providerWatch.characters[index].imageUrl,
                                    width: mediaQuery.size.width,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  providerWatch.characters[index].name,
                                  style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
