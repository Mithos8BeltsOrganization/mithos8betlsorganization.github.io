import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(55, 26, 117, 1),
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
