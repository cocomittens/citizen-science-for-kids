import 'package:flutter/material.dart';
import 'package:citizen_science_mobile/widgets/background_image_wrapper_widget.dart';

class NavPage extends StatelessWidget {
  final Map<String, dynamic> projectData;

  const NavPage({
    super.key,
    required this.projectData,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(children: [
          Padding(
            padding: EdgeInsetsGeometry.only(top: 10.0),
            child: Text('Citizen Science', style: TextStyle(fontSize: 34)),
          ),
          Padding(
            padding: EdgeInsetsGeometry.only(bottom: 10.0),
            child: Text('Experiment/Project name goes here', style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white)),
          )
        ])
      ),
      body: BackgroundImageWrapper(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 40.0),
            child: Row(children: [
              Expanded(flex: 3, child: Container()),
              Expanded(flex: 3, child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(flex: 1),
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
                      )
                    ),
                    Spacer(flex: 1),
                    SizedBox(
                      width: double.infinity,
                      height: 40.0,
                      child: ElevatedButton(
                        child: const Text('View Class Observations'),
                        onPressed: () {
                          Navigator.pushNamed(context, '/view');
                        }
                      )
                    ),
                    Spacer(flex: 1),
                    SizedBox(
                      width: double.infinity,
                      height: 40.0,
                      child: ElevatedButton(
                        child: const Text('Add New Observation'),
                        onPressed: () {
                          Navigator.pushNamed(context, '/add');
                        }
                      )
                    ),
                    Spacer(flex: 1),
                    SizedBox(
                      width: double.infinity,
                      height: 40.0,
                      child: ElevatedButton(
                        child: const Text('Edit Current Observations'),
                        onPressed: () {
                          Navigator.pushNamed(context, 'edit');
                        }
                      )
                    ),
                    Spacer(flex: 1)
                  ]
                )
              ),
              Expanded(flex: 3, child: Container())
            ])
          )  
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
            Navigator.pushNamedAndRemoveUntil(context, '/landing', (Route<dynamic> route) => false);
          }
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}