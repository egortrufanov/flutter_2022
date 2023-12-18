import 'package:flutter/material.dart' show MaterialApp, ThemeData, Colors;
import 'package:flutter/widgets.dart';

import 'first_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'trufanov Lab 2',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FirstPage(title: 'trufanov Lab II'),
    );
  }
}
