import 'package:flutter/material.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Citizen Science'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('This is where Edit Observations will be')
      )
    );
  }
}