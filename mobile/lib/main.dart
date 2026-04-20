import 'package:flutter/material.dart';

void main() {
  runApp(const CitizenScienceApp());
}

class CitizenScienceApp extends StatelessWidget {
  const CitizenScienceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Citizen Science',
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(
          child: Text('Citizen Science Mobile App'),
        ),
      ),
    );
  }
}