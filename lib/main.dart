import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(CarbonCalculatorApp());
}

class CarbonCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carbon Calculator',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),
      home: HomeScreen(),
    );
  }
}
