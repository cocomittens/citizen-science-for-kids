import 'package:flutter/material.dart';

class NavPage extends StatelessWidget {
  const NavPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(children: [
          Text('Citizen Science', style: TextStyle(fontSize: 34)),
          Text('Experiment/Project name goes here', style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal))
        ])
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 30.0,
          children: [
            ElevatedButton(
              child: const Text('Project Description'),
              onPressed: () {
                Navigator.pushNamed(context, '/description');
              },
            ),
            ElevatedButton(
              child: const Text('View Class Observations'),
              onPressed: () {
                Navigator.pushNamed(context, '/view');
              }
            ),
            ElevatedButton(
              child: const Text('Add New Observation'),
              onPressed: () {
                Navigator.pushNamed(context, '/add');
              }
            ),
            ElevatedButton(
              child: const Text('Edit Current Observations'),
              onPressed: () {
                Navigator.pushNamed(context, 'edit');
              }
            )
          ]
        )
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5.0,
        child: Container(height: 30.0),
      ),
      floatingActionButton: SizedBox(
        height: 50.0,
        width: 80.0,
        child: FloatingActionButton(
          child: const Text('Exit Project'),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/landing', (Route<dynamic> route) => false);
          }
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}