import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart'
    show
        AppBar,
        CircularProgressIndicator,
        Colors,
        MaterialPageRoute,
        RefreshIndicator,
        Scaffold;
import 'package:flutter/widgets.dart';
import 'package:trufanov_lab_2/character_model.dart';
import 'package:trufanov_lab_2/second_page.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final List<CharacterModel> _characters = [];
  bool _isLoading = false;

  Future<void> _fetchCharacters() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    final uri = Uri.parse('https://rickandmortyapi.com/api/character');
    final response = await http.get(uri);
    final decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    print(decodedResponse['results']);
    if (decodedResponse['results'] != null) {
      _characters.clear();
      for (final item in decodedResponse['results']) {
        _characters.add(CharacterModel.fromJson(item));
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _fetchCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator.adaptive()
            : RefreshIndicator(
                onRefresh: () {
                  return _fetchCharacters();
                },
                child: ListView.builder(
                  itemCount: _characters.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => SecondPage(
                              character: _characters[index],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16)),
                                  child: Image.network(
                                    _characters[index].imageUrl,
                                    width: mediaQuery.size.width,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  _characters[index].name,
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
