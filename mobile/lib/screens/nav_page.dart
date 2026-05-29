import 'package:flutter/material.dart';
import 'package:citizen_science_mobile/widgets/background_image_wrapper.dart';
import 'package:citizen_science_mobile/widgets/custom_appbar.dart';

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
                            Navigator.pushNamed(context, '/edit');
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
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/landing',
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}