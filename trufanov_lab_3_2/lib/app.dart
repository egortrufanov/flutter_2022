import 'package:flutter/material.dart' show MaterialApp, ThemeData, Colors;
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'providers/characters_provider.dart';
import 'pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CharactersProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Trufanov Lab 3',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomePage(),
      ),
    );
  }
}
