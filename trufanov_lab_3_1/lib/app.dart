import 'package:flutter/material.dart' show MaterialApp, ThemeData, Colors;
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'characters_provider.dart';
import 'first_page.dart';

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
        title: 'trufanov Lab 3',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const FirstPage(title: 'trufanov Lab III'),
      ),
    );
  }
}
