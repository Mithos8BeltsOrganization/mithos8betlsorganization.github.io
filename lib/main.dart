import 'package:flutter/material.dart';
import 'domain/entities/coordinates.dart';
import 'ui/error/error_state.dart';
import 'ui/error/error_state_params.dart';
import 'ui/login/login.dart';
import 'ui/successful/successful_state.dart';
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
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.white),
                bodyMedium: TextStyle(color: Colors.white),
                bodySmall: TextStyle(color: Colors.white),
                displayLarge: TextStyle(color: Colors.white),
                displayMedium: TextStyle(color: Colors.white),
                displaySmall: TextStyle(color: Colors.white),
                headlineLarge: TextStyle(color: Colors.white),
                headlineMedium: TextStyle(color: Colors.white),
                headlineSmall: TextStyle(color: Colors.white),
                labelLarge: TextStyle(color: Colors.white),
                labelMedium: TextStyle(color: Colors.white),
                labelSmall: TextStyle(color: Colors.white),
                titleLarge: TextStyle(color: Colors.white),
                titleMedium: TextStyle(color: Colors.white),
                titleSmall: TextStyle(color: Colors.white),
              ),
              inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                hintStyle: TextStyle(color: Colors.white54),
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            routes: {
              'index': (context) => const Login(),
              'successful': (context) {
                final modalRoute = ModalRoute.of(context);
                final isFirst = modalRoute?.isFirst ?? true;
                if (isFirst) {
                  return const Login();
                }

                if (modalRoute?.settings.arguments case final coordinates
                    when coordinates is Coordinates) {
                  return SuccessfulState(
                    coordinates: coordinates,
                  );
                }

                return const Login();
              },
              'error': (context) {
                final modalRoute = ModalRoute.of(context);
                final isFirst = modalRoute?.isFirst ?? true;
                if (isFirst) {
                  return const Login();
                }

                final stateParams = modalRoute?.settings.arguments;
                if (stateParams is ErrorStateParams) {
                  return ErrorState(stateParams: stateParams);
                }

                return const ErrorState(stateParams: ErrorStateParams.empty());
              },
            },
            initialRoute: 'index',
            home: const Login(),
          ),
        ),
      ),
    );
  }
}
