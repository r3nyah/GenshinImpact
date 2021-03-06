import 'package:Genshinimpact/src/Utils/ArrowDirection.dart';
import 'package:flutter/material.dart';

class ArrowButton extends StatelessWidget {
  const ArrowButton({
    Key? key,
    required this.direction,
    required this.image,
    required this.onTap
  }) : super(key: key);

  final ArrowDirection direction;
  final Image image;
  final Function(ArrowDirection) onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>onTap(
        direction
      ),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white10,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: image,
        ),
      ),
    );
  }
}
