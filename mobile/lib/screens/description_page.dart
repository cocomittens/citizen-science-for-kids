import 'package:flutter/material.dart';
import 'package:citizen_science_mobile/widgets/background_image_wrapper.dart';
import 'package:citizen_science_mobile/widgets/custom_appbar.dart';

class DescriptionPage extends StatelessWidget {
  final Map<String, dynamic> projectData;

  const DescriptionPage({
    super.key,
    required this.projectData,
  });

  @override
  Widget build(BuildContext context) {
    final projectTitle = projectData['title']?.toString() ??
        projectData['projectTitle']?.toString() ??
        projectData['name']?.toString() ??
        'Project Title Not Available';

    final description = projectData['description']?.toString() ??
        'Project description not available.';

    return Scaffold(
      appBar: CustomAppbar(
        title: "Project Description",
        subtitle: projectTitle
      ),
      body: BackgroundImageWrapper(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Project title:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  projectTitle,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Description:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        )
      )
    );
  }
}