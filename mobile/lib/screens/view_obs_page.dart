import 'package:flutter/material.dart';

class ViewObsPage extends StatelessWidget {
  const ViewObsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Citizen Science'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('This is where Viewing Observations will be')
      )
    );
  }
}