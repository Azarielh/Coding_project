import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class HabitTileLeading extends StatelessWidget {
  final bool pair;

  const HabitTileLeading({Key? key, required this.pair}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: FadeInImage(
                image: AssetImage(
                  pair ? "assets/images/yoga.png" : "assets/images/yoga.png",
                ),
                placeholder: MemoryImage(kTransparentImage))),
        backgroundColor: pair ? Colors.orange[700] : Colors.indigo[500]);
  }
}
