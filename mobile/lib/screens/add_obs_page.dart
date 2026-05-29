import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:citizen_science_mobile/globals.dart';
import 'package:citizen_science_mobile/widgets/custom_appbar.dart';
import 'package:citizen_science_mobile/widgets/background_image_wrapper.dart';

class AddObservationPage extends StatefulWidget {
  final Map<String, dynamic> projectData;

  const AddObservationPage({
    super.key,
    required this.projectData,
  });

  @override
  State<AddObservationPage> createState() => _AddObservationPageState();
}

class _AddObservationPageState extends State<AddObservationPage> {
  final TextEditingController studentNameController = TextEditingController();

  final Map<String, TextEditingController> controllers = {};
  final Map<String, dynamic> answers = {};

  List<dynamic> fields = [];
  bool loading = false;
  bool submitting = false;

  String get projectId {
    return widget.projectData['id']?.toString() ??
        widget.projectData['projectId']?.toString() ??
        widget.projectData['project_id']?.toString() ??
        '';
  }

  String get fieldsUrl {
    return 'https://citizen-science-backend.fly.dev/api/projects/$projectId/fields';
  }

  String get observationsUrl {
    return 'https://citizen-science-backend.fly.dev/api/projects/$projectId/observations';
  }

  @override
  void initState() {
    super.initState();
    loadFields();
  }

  Future<void> loadFields() async {
    if (projectId.isEmpty) {
      showMessage('Project ID is missing.');
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(fieldsUrl),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          if (data is List) {
            fields = data;
          } else if (data is Map && data['fields'] is List) {
            fields = data['fields'];
          } else {
            fields = [];
          }
        });

        print(fields);

        for (final field in fields) {
          final fieldId = field['id'].toString();
          final fieldType = field['field_type'].toString();

          if (fieldType != 'dropdown') {
            controllers[fieldId] = TextEditingController();
          }
        }
      } else {
        print('Field status code: ${response.statusCode}');
        print('Field response body: ${response.body}');
        showMessage('Could not load fields.');
      }
    } catch (error) {
      print('Field error: $error');
      showMessage('Error loading fields.');
    }

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> submitObservation() async {
    final studentName = studentNameController.text.trim();

    if (studentName.isEmpty) {
      showMessage('Enter student name.');
      return;
    }

    final List<Map<String, dynamic>> values = [];
    final List<Map<String, dynamic>> stored_values = [];

    for (final field in fields) {
      final fieldId = field['id'].toString();
      final fieldLabel = field['label'].toString();
      final fieldType = field['field_type'].toString();
      final fieldOptions = field['options'];

      if (fieldType == 'dropdown') {
        final selectedAnswer = answers[fieldId];

        if (selectedAnswer == null || selectedAnswer.toString().isEmpty) {
          showMessage('Pick $fieldLabel.');
          return;
        }

        stored_values.add({
          'field_id': fieldId,
          'field_type': fieldType,
          'label': fieldLabel,
          'value': selectedAnswer.toString(),
          'options': fieldOptions
        });

        values.add({
          'field_id': fieldId,
          'value': selectedAnswer.toString(),
        });
      } else {
        final value = controllers[fieldId]?.text.trim() ?? '';

        if (value.isEmpty) {
          showMessage('Enter $fieldLabel.');
          return;
        }

        stored_values.add({
          'field_id': fieldId,
          'field_type': fieldType,
          'label': fieldLabel,
          'value': value,
          'options': fieldOptions
        });

        values.add({
          'field_id': fieldId,
          'value': value,
        });
      }
    }

    final observationId = const Uuid().v4();

    final newObservation = {
      'id': observationId,
      'student_name': studentName,
      'values': values,
    };

    final storedObservation = {
      'id': observationId,
      'student_name': studentName,
      'values': stored_values,
    };

    setState(() {
      submitting = true;
    });

    try {
      final response = await http.post(
        Uri.parse(observationsUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(newObservation),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Globals.current_observations.add(storedObservation);

        showMessage('Observation submitted.');

        if (!mounted) {
          return;
        }

        Navigator.pop(context);
      } else {
        print('Submit status code: ${response.statusCode}');
        print('Submit response body: ${response.body}');
        showMessage('Could not submit observation.');
      }
    } catch (error) {
      print('Submit error: $error');
      showMessage('Error submitting observation.');
    }

    if (mounted) {
      setState(() {
        submitting = false;
      });
    }
  }

  Widget buildField(dynamic field) {
    final fieldId = field['id'].toString();
    final fieldLabel = field['label'].toString();
    final fieldType = field['field_type'].toString();

    if (fieldType == 'dropdown') {
      final optionsText = field['options']?.toString() ?? '';

      final options = optionsText
          .split(',')
          .map((option) => option.trim())
          .where((option) => option.isNotEmpty)
          .toList();

      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: DropdownButtonFormField<String>(
          initialValue: answers[fieldId],
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: fieldLabel,
            border: const OutlineInputBorder(),
          ),
          items: options.map((option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              answers[fieldId] = value;
            });
          },
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controllers[fieldId],
        keyboardType:
            fieldType == 'number' ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: fieldLabel,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void showMessage(String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  void dispose() {
    studentNameController.dispose();

    for (final controller in controllers.values) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projectTitle = widget.projectData['title']?.toString() ??
        widget.projectData['projectTitle']?.toString() ??
        widget.projectData['name']?.toString() ??
        'Add Observation';

    return Scaffold(
      appBar: CustomAppbar(
        title: "Add New Observation",
        subtitle: projectTitle,
      ),
      body: BackgroundImageWrapper(
        child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 16),
          TextField(
            controller: studentNameController,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Student Name',
              hintText: 'Example: Megan',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          if (loading)
            const Center(
              child: CircularProgressIndicator(),
            )
          else if (fields.isEmpty)
            const Text(
              'No observation fields were found.',
              textAlign: TextAlign.center,
            )
          else
            for (final field in fields) buildField(field),

          const SizedBox(height: 8),

          ElevatedButton(
            onPressed: submitting ? null : submitObservation,
            child: Text(
              submitting ? 'Submitting...' : 'Submit Observation',
            ),
          ),
        ],
      ))
    );
  }
}