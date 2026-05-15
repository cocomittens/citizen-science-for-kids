import 'package:flutter/material.dart';

class AddObservationPage extends StatefulWidget {
  const AddObservationPage({super.key});

  @override
  State<AddObservationPage> createState() => _AddObservationPageState();
}

class _AddObservationPageState extends State<AddObservationPage> {
  final TextEditingController studentNameController = TextEditingController();
  final TextEditingController observationController = TextEditingController();
  final TextEditingController countController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  String selectedCategory = 'Plant';

  final List<String> categories = [
    'Plant',
    'Animal',
    'Insect',
    'Weather',
    'Other',
  ];

  void saveObservation() {
    String studentName = studentNameController.text.trim();
    String observation = observationController.text.trim();
    String countText = countController.text.trim();
    String location = locationController.text.trim();
    String notes = notesController.text.trim();

    if (studentName.isEmpty ||
        observation.isEmpty ||
        countText.isEmpty ||
        location.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill out all required fields.'),
        ),
      );
      return;
    }

    int? count = int.tryParse(countText);

    if (count == null || count <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Count must be a positive number.'),
        ),
      );
      return;
    }

    Map<String, dynamic> newObservation = {
      'studentName': studentName,
      'category': selectedCategory,
      'observation': observation,
      'count': count,
      'location': location,
      'notes': notes,
    };

    Navigator.pop(context, newObservation);
  }

  @override
  void dispose() {
    studentNameController.dispose();
    observationController.dispose();
    countController.dispose();
    locationController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Observation'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: studentNameController,
              decoration: const InputDecoration(
                labelText: 'Student Name',
                hintText: 'Example: Alex',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                }
              },
            ),

            const SizedBox(height: 16),

            TextField(
              controller: observationController,
              decoration: const InputDecoration(
                labelText: 'Observation',
                hintText: 'Example: butterfly',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: countController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Count',
                hintText: 'Example: 3',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
                hintText: 'Example: school garden',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: saveObservation,
              child: const Text('Save Observation'),
            ),
          ],
        ),
      ),
    );
  }
}