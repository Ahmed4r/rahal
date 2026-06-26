import 'package:flutter/material.dart';
import 'package:rahal/screens/home/home_page.dart';

void main() {
  runApp(const Rahal());
}

class Rahal extends StatelessWidget {
  const Rahal({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rahal',
      home: HomePage(),
    );
  }
}
