import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Column(
        children: [

        ],
      )
    );
  }
  Widget buildTopBar(){
    return Row(
      children: [
        Column(
          children: [
            Text("Location,"),
            Text("Berlin"),
          ],
        ),
      ],
    );
  }
}