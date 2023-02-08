import 'package:flutter/material.dart';
import 'package:rest_api/example_two.dart';
//import 'package:rest_api/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const ExampleTwo(),
    );
  }
}
