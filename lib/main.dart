import 'package:flutter/material.dart';
import 'screens/refeicoes_plano_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DietSync',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: RefeicaoPlanScreen(),
    );
  }
}
