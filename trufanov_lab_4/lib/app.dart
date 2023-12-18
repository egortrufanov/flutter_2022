import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'bloc/bloc.dart';
import 'first_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => CharactersBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Trufanov Lab 4',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const FirstPage(title: 'Trufanov Lab IV'),
      ),
    );
  }
}
