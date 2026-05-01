import 'package:flutter/material.dart';

class NavPage extends StatelessWidget {
  const NavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Citizen Science'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: Text('Experiment/Project name goes here')
          )
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
              child: const Text('Your Observations'),
              onPressed: () {
                Navigator.pushNamed(context, '/view');
              }
            ),
            ElevatedButton(
              child: const Text('Add New Observation'),
              onPressed: () {
                Navigator.pushNamed(context, '/add');
              }
            )
          ]
        )
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const AutomaticNotchedShape(
          RoundedRectangleBorder(),
          StadiumBorder()
        ),
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