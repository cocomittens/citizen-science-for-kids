import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:citizen_science_mobile/globals.dart';

class PatchPage extends StatefulWidget {
  final Map<String, dynamic> observation;

  const PatchPage({super.key, required this.observation});

  @override State<PatchPage> createState() => _PatchPage();
}

class _PatchPage extends State<PatchPage> {
  final TextEditingController studentNameController = TextEditingController();

  final Map<String, TextEditingController> controllers = {};
  final Map<String, dynamic> answers = {};
  List<dynamic> fields = [];
  bool loading = false;
  bool submitting = false;

  @override
  void initState() {
    super.initState();
    loadFields();
  }

  void loadFields() {
    setState(() {
      loading = true;
    });

    final data = widget.observation;
    fields = data["values"];

    setState(() {
      if (fields.isEmpty) {
        fields = [];
      }
    });

    for (final field in fields) {
      final fieldId = field['field_id'];
      final fieldType = field['field_type'];

      if (fieldType != 'dropdown') {
        final existingValue = field['value']?.toString() ?? '';
        controllers[fieldId] = TextEditingController(text: existingValue);
      } else {
        answers[fieldId] = field['value']?.toString();
      }
    }
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> editObservation() async {
    final studentName = studentNameController.text.trim();

    if (studentName.isEmpty) {
      showMessage('Enter student name.');
      return;
    }

    final List<Map<String, dynamic>> values = [];

    for (final field in fields) {
      final fieldId = field['field_id'].toString();
      final fieldLabel = field['label'].toString();
      final fieldType = field['field_type'].toString();

      if (fieldType == 'dropdown') {
        final selectedAnswer = answers[fieldId];

        if (selectedAnswer == null || selectedAnswer.toString().isEmpty) {
          showMessage('Pick $fieldLabel.');
          return;
        }

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

        values.add({
          'field_id': fieldId,
          'value': value
        });
      }
    }

    final observationId = widget.observation['id'];

    final editedObservation = {
      'id': observationId,
      'student_name': studentName,
      'values': values
    };

    setState(() {
      submitting = true;
    });

    try {
      final response = await http.patch(
        Uri.parse('https://citizen-science-backend.fly.dev/api/projects/observations/$observationId'),
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode(editedObservation)
      );

      if (response.statusCode == 200 || response.statusCode == 202 || response.statusCode == 204) {
        
        showMessage('Observation edited');

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
      showMessage('Error submitting observation');
    }

    if (mounted) {
      setState(() {
        submitting = false;
      });
    }
  }

  Widget buildField(dynamic field) {
    final fieldId = field['field_id'];
    final fieldLabel = field['label'];
    final fieldType = field['field_type'];

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
            labelText: fieldLabel,
            border: const OutlineInputBorder()
          ),
          items: options.map((option) {
            return DropdownMenuItem<String>(
              value:option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              answers[fieldId] = value;
            });
          }
        )
      );
    }

    return Padding(
      padding: const EdgeInsetsGeometry.only(bottom: 16),
      child: TextField(
        controller: controllers[fieldId],
        keyboardType:
          fieldType == 'number' ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: fieldLabel,
          border: const OutlineInputBorder()
        )
      )
    );
  }

  void showMessage(String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message)
      )
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Observation')
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: studentNameController,
            decoration: InputDecoration(
              labelText: 'Student Name',
              hintText: '${widget.observation["student_name"]}',
              border: OutlineInputBorder()
            )
          ),
          const SizedBox(height: 16),

          if (loading)
            const Center(
              child: CircularProgressIndicator()
            )
          else if (fields.isEmpty)
            const Text(
              'No observation fields were found',
              textAlign: TextAlign.center
            )
          else
            for (final field in fields) buildField(field),

          const SizedBox(height: 8),

          ElevatedButton(
            onPressed: submitting ? null : editObservation,
            child: Text(
              submitting ? 'Editing...' : 'Edit Observation',
            )
          )
        ]
      )
    );
  }
}