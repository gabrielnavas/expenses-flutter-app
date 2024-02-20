import 'package:flutter/material.dart';

import 'package:expenses_flutter_app/screens/principal_home.dart';

void main() => runApp(const Expenses());

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(fontFamily: 'Quicksand');
    return MaterialApp(
      home: const PrincipalHome(),
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
            primary: Colors.purple,
            secondary: Colors.amber,
            background: Colors.white),
        textTheme: theme.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          titleSmall: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          titleMedium: const TextStyle(
            fontSize: 17.5,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.purple,
            titleTextStyle: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
            actionsIconTheme: IconThemeData(color: Colors.white)),
      ),
    );
  }
}
