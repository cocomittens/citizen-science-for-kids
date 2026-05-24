import 'package:flutter/material.dart';
import 'screens/landing_page.dart';
import 'screens/nav_page.dart';
import 'screens/add_obs_page.dart';
import 'screens/description_page.dart';
import 'screens/view_obs_page.dart';
import 'screens/edit_page.dart';
import 'styles/app_theme.dart';

void main() {
  runApp(const CitizenScienceApp());
}

class CitizenScienceApp extends StatelessWidget {
  const CitizenScienceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      title: 'Citizen Science',
      debugShowCheckedModeBanner: false,
      home: const LandingPage(),
      routes: {
        '/landing': (context) => const LandingPage(),

        '/nav': (context) {
          final projectData =
              ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

          return NavPage(projectData: projectData);
        },

        '/add': (context) {
          final projectData =
              ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

          return AddObservationPage(projectData: projectData);
        },

        '/description': (context) {
          final projectData =
              ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

          return DescriptionPage(projectData: projectData);
        },

        '/view': (context) => ViewObsPage(),

        '/edit': (context) => const EditPage(),
      },
    );
  }
}