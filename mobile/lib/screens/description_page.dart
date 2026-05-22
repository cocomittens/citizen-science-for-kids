import 'package:flutter/material.dart';
import 'package:citizen_science_mobile/widgets/background_image_wrapper.dart';
import 'package:citizen_science_mobile/widgets/custom_appbar.dart';

class DescriptionPage extends StatelessWidget {
  const DescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppbar(
        title: "Project Description", 
        subtitle: "Project name goes here"
      ),
      body: BackgroundImageWrapper(
        child: Center(
          child: Text('This is where Project Description will be')
        )
      )
    );
  }
}