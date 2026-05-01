import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Citizen Science'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: Text('This is the login/landing page')
          )
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go to Navigation'),
          onPressed: () {
            Navigator.pushNamed(context, '/nav');
          }
        )
      )
    );
  }
}