import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
        controllers[fieldId] = TextEditingController();
      }
    }
    if (mounted) {
      setState(() {
        loading = false;
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
            onPressed: submitting ? null : submitObservation,
            child: Text(
              submitting ? 'Submitting...' : 'Submit Observation',
            )
          )
        ]
      )
    );
  }
}