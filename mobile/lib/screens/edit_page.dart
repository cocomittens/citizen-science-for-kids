import 'package:flutter/material.dart';
import 'package:citizen_science_mobile/widgets/background_image_wrapper.dart';
import 'package:citizen_science_mobile/widgets/custom_appbar.dart';
import 'package:citizen_science_mobile/globals.dart';
import 'package:citizen_science_mobile/screens/patch_page.dart';

class EditPage extends StatefulWidget {
  final Map<String, dynamic> projectData;

  const EditPage({
    super.key,
    required this.projectData
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  //const EditPage({super.key});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final projectTitle = widget.projectData['title']?.toString() ??
      widget.projectData['projectTitle']?.toString() ??
      widget.projectData['name']?.toString() ??
      '';

    Theme.of(context);

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Edit Your Observations',
        subtitle: projectTitle
      ),
      body: BackgroundImageWrapper(
        child: ListView.builder(
          itemCount: Globals.current_observations.length,
          padding: const EdgeInsets.all(12.0),
          itemBuilder: (context, index) {
            final observation = Globals.current_observations[index];

            return InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatchPage(observation: observation, index: index, projectData: widget.projectData),
                  )
                );
                if (mounted) {
                  setState(() {});
                }
              },
              child: Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(observation["student_name"])
                        ]
                      ),
                      const Divider(height: 20),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: observation["values"].map<Widget>((field) {
                          return Chip(
                            label: Text(
                              '${field["label"]}: ${field["value"]}'
                            )
                          );
                        }).toList()
                      )
                    ]
                  )
                )
              )
            );
          },
        )
      )
    );
  }
}