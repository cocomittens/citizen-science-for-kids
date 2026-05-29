import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:citizen_science_mobile/observation.dart';

class ViewObsPage extends StatefulWidget {
  final Map<String, dynamic> projectData;

  const ViewObsPage({
    super.key,
    required this.projectData,
  });

  @override
  State<ViewObsPage> createState() => _ViewObsPageState();
}

class _ViewObsPageState extends State<ViewObsPage> {
  late Future<List<Observation>> _observationsFuture;

  @override
  void initState() {
    super.initState();
    _observationsFuture = fetchObservations();
  }

  String get projectId {
    return widget.projectData['id']?.toString() ??
      widget.projectData['projectId']?.toString() ??
      widget.projectData['project_id']?.toString() ??
      '';
  }

  Future<List<Observation>> fetchObservations() async {
    final url = Uri.parse('https://citizen-science-backend.fly.dev/api/projects/$projectId/observations');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return observationFromJson(response.body);
    } else {
      throw Exception('Failed to load observations');
    }
  }
  //const ViewObsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Citizen Science'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Observation>>(
        future: _observationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No observations found'));
          }
          final observations = snapshot.data!;
          return ListView.builder(
            itemCount: observations.length,
            padding: const EdgeInsets.all(12.0),
            itemBuilder: (context, index) {
              final observation = observations[index];

              return Card(
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
                          Text(
                            observation.studentName
                          ),
                          Text('${observation.observedAt.toIso8601String().substring(0, 10)}')
                        ],
                      ),
                      const Divider(height: 20),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: observation.values.map<Widget>((field) {
                          return Chip(
                            label: Text('${field.label}: ${field.value}')
                          );
                        }).toList()
                      )
                    ]
                  )
                )
              );
            }
          );
        }
      )
    );
  }
}