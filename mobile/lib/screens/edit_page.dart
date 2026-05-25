import 'package:flutter/material.dart';
import 'package:citizen_science_mobile/widgets/background_image_wrapper.dart';
import 'package:citizen_science_mobile/widgets/custom_appbar.dart';
import 'package:citizen_science_mobile/globals.dart';
import 'package:citizen_science_mobile/screens/patch_page.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPage createState() => _EditPage();
}

class _EditPage extends State<EditPage> {
  //const EditPage({super.key});

  @override
  void initState() {
    super.initState();
    printDataToConsole();
  }

  void printDataToConsole() {
    print('-------- Loading Global Map List ---------');
    for (var item in Globals.current_observations) {
      print('Item Found: $item');
    }
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context);

    return Scaffold(
      appBar: CustomAppbar(
        title: "Edit Your Observations",
        subtitle: "Project name goes here"
      ),
      body: ListView.builder(
        itemCount: Globals.current_observations.length,
        padding: const EdgeInsets.all(12.0),
        itemBuilder: (context, index) {
          final observation = Globals.current_observations[index];

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PatchPage(observation: observation),
                )
              );
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
    );
  }
}