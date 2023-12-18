import 'package:flutter/material.dart';

class PokemonCard extends StatelessWidget {
  final String name;
  // final int? height;
  // final String isDefault;
  final int? order;
  // final String weight;
  // final String sprite;

  const PokemonCard({
    required this.name,
    // required this.height,
    // required this.isDefault,
    required this.order,
    // required this.weight,
    // required this.sprite,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // const SizedBox(height: 8),
            // Image.network(sprite),
            const SizedBox(height: 8),
            Text(name),
            const SizedBox(height: 8),
            // Text(height.toString()),
            // const SizedBox(height: 8),
            // Text(isDefault),
            // const SizedBox(height: 8),
            Text(order.toString()),
            const SizedBox(height: 8),
            // Text(weight),
            // const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
