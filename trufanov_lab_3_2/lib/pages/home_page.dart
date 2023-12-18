import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/characters_provider.dart';
import 'first_page.dart';
import 'history_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  @override
  void initState() {
    context.read<CharactersProvider>().fetchCharacters();
    super.initState();
  }

  Widget getPageByIndex() {
    switch (currentPageIndex) {
      case 0:
        return const FirstPage();
      case 1:
        return const HistoryPage();
      default:
        return const Center(child: Text("Как вы сюда попали?"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex,
        onTap: (page) {
          setState(() {
            currentPageIndex = page;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Персонажи"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "История"),
        ],
      ),
      body: getPageByIndex(),
    );
  }
}
