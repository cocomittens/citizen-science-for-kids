import 'package:flutter/material.dart';
import 'package:citizen_science_mobile/widgets/background_image_wrapper.dart';
import 'package:citizen_science_mobile/widgets/custom_appbar.dart';
import 'package:citizen_science_mobile/globals.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppbar(
        title: "Edit Your Observations",
        subtitle: "Project name goes here"
      ),
      body: BackgroundImageWrapper(
        child: Center(
          child: Text('This is where Edit Observations will be')
        )
      )
    );
  }
}