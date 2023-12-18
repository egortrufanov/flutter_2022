import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/characters_provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    context.read<CharactersProvider>().readDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final providerWatch = context.watch<CharactersProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("История зарпосов")),
      body: SizedBox(
        height: mediaQuery.size.height,
        child: ListView.builder(
          itemCount: providerWatch.queriesHistory.length,
          itemBuilder: (context, index) {
            final foundedQuery = providerWatch.queriesHistory[index];
            return ListTile(
              title: Text("Загружено персонажей: ${providerWatch.queriesHistory[index].foundedCharactersNumber}"),
              subtitle: Text(
                "${foundedQuery.queryExecuteDateTime.day}.${foundedQuery.queryExecuteDateTime.month}.${foundedQuery.queryExecuteDateTime.year} ${providerWatch.queriesHistory[index].queryExecuteDateTime.hour}:${foundedQuery.queryExecuteDateTime.minute}",
              ),
            );
          },
        ),
      ),
    );
  }
}
