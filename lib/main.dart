import 'package:flutter/material.dart';
import 'ui/login/login.dart';
import 'utils/layout_scope.dart';
import 'utils/widget_cache.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => WidgetCache(
        value: Breakpoint(width: constraints.maxWidth),
        builder: (context, value) => LayoutScope(
          constraints: constraints,
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const Login(),
          ),
        ),
      ),
    );
  }
}
