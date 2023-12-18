import 'package:flutter/material.dart'
    show
        AppBar,
        CircularProgressIndicator,
        Colors,
        MaterialPageRoute,
        RefreshIndicator,
        Scaffold;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';
import 'bloc/event.dart';
import 'bloc/state.dart';
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
    context.read<CharactersBloc>().add(LoadDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: BlocBuilder<CharactersBloc, CharactersState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const CircularProgressIndicator.adaptive();
            }
            if (state is LoadedState) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<CharactersBloc>().add(LoadDataEvent());
                },
                child: ListView.builder(
                  itemCount: state.characters.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => SecondPage(
                              character: state.characters[index],
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
                                    state.characters[index].imageUrl,
                                    width: mediaQuery.size.width,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  state.characters[index].name,
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
              );
            }
            if (state is FailedState) {
              return Text(state.errorMessage);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
