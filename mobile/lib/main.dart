import 'package:flutter/material.dart';
import 'screens/landing_page.dart';
import 'screens/nav_page.dart';
import '/screens/add_obs_page.dart';
import '/screens/description_page.dart';
import '/screens/view_obs_page.dart';

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
      home: const LandingPage(),
      routes: {
        '/landing': (context) => const LandingPage(),
        '/nav': (context) => const NavPage(),
        '/add': (context) => const AddObsPage(),
        '/description': (context) => const DescriptionPage(),
        '/view': (context) => const ViewObsPage(),
      }
    );
  }
}
     