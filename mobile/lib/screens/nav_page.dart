import 'package:flutter/material.dart';
import 'package:citizen_science_mobile/widgets/background_image_wrapper.dart';
import 'package:citizen_science_mobile/widgets/custom_appbar.dart';
import 'package:citizen_science_mobile/globals.dart';

class NavPage extends StatelessWidget {
  final Map<String, dynamic> projectData;

  const NavPage({
    super.key,
    required this.projectData,
  });

  @override
  Widget build(BuildContext context) {
    final projectTitle =
        projectData['title']?.toString() ?? 'Project name goes here';

    return Scaffold(
      appBar: CustomAppbar(
        title: "Citizen Science",
        subtitle: projectTitle,
      ),
      body: BackgroundImageWrapper(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 40.0),
            child: Row(
              children: [
                Expanded(flex: 3, child: Container()),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(flex: 1),

                      SizedBox(
                        width: double.infinity,
                        height: 40.0,
                        child: ElevatedButton(
                          child: const Text('Project Description'),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/description',
                              arguments: projectData,
                            );
                          },
                        ),
                      ),

                      const Spacer(flex: 1),

                      SizedBox(
                        width: double.infinity,
                        height: 40.0,
                        child: ElevatedButton(
                          child: const Text('View Class Observations'),
                          onPressed: () {
                            Navigator.pushNamed(
                              context, '/view',
                              arguments: projectData
                            );
                          },
                        ),
                      ),

                      const Spacer(flex: 1),

                      SizedBox(
                        width: double.infinity,
                        height: 40.0,
                        child: ElevatedButton(
                          child: const Text('Add New Observation'),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/add',
                              arguments: projectData,
                            );
                          },
                        ),
                      ),

                      const Spacer(flex: 1),

                      SizedBox(
                        width: double.infinity,
                        height: 40.0,
                        child: ElevatedButton(
                          child: const Text('Edit Current Observations'),
                          onPressed: () {
                            Navigator.pushNamed(
                              context, '/edit',
                              arguments: projectData
                            );
                          },
                        ),
                      ),

                      const Spacer(flex: 1),
                    ],
                  ),
                ),
                Expanded(flex: 3, child: Container()),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5.0,
        height: 40.0,
        child: Container(height: 10.0),
      ),
      floatingActionButton: SizedBox(
        height: 50.0,
        width: 80.0,
        child: FloatingActionButton(
          child: const Text('Exit Project'),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    'Exit Project',
                    textAlign: TextAlign.center
                  ),
                  content: const Text(
                    'Are you sure you want to exit?',
                    textAlign: TextAlign.center
                  ),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();

                        Globals.current_observations = [];
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/landing',
                          (Route<dynamic> route) => false
                        );
                      },
                      child: const Text('Yes')
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('No')
                    )
                  ]
                );
              }
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}