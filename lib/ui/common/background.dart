import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(43, 35, 162, 1),
            Color.fromRGBO(58, 32, 116, 1),
            Color.fromRGBO(116, 32, 53, 1),
          ],
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: DefaultTextStyle(
          style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          child: child,
        ),
      ),
    );
  }
}
