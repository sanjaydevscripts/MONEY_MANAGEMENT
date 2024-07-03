import 'package:flutter/material.dart';
import 'package:money_manager_flutter/screens/home/screen_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MONEY MANAGER',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 17, 146, 168)),
        useMaterial3: true,
      ),
      home: const ScreenHome(),
    );
  }
}