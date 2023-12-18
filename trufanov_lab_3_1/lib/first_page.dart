import 'package:flutter/material.dart'
    show AppBar, CircularProgressIndicator, Colors, MaterialPageRoute, RefreshIndicator, Scaffold;
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'characters_provider.dart';
import 'second_page.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    context.read<CharactersProvider>().fetchCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final providerWatch = context.watch<CharactersProvider>();
    final providerRead = context.read<CharactersProvider>();
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
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
