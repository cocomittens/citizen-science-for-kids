import 'package:flutter/material.dart';

class AddObsPage extends StatelessWidget {
  const AddObsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Citizen Science'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('This is where Adding Observations will be')
      )
    );
  }
}