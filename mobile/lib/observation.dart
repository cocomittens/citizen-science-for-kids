import 'dart:convert';

List<Observation> observationFromJson(String str) =>
  List<Observation>.from(json.decode(str).map((x) => Observation.fromJson(x)));

class Observation {
  final id;
  final projectID;
  final studentName;
  final observedAt;
  final values;

  Observation({
    required this.id,
    required this.projectID,
    required this.studentName,
    required this.observedAt,
    required this.values
  });

  factory Observation.fromJson(Map<String, dynamic> json) => Observation(
    id: json["id"],
    projectID: json["project_id"],
    studentName: json["student_name"],
    observedAt: DateTime.parse(json["observed_at"]),
    values: List<FieldValue>.from(
      json["values"].map((x) => FieldValue.fromJson(x)),
    )
  );
}

class FieldValue {
  final id;
  final observationId;
  final fieldId;
  final value;
  final label;
  final fieldType;

  FieldValue({
    required this.id,
    required this.observationId,
    required this.fieldId,
    required this.value,
    required this.label,
    required this.fieldType
  });

  factory FieldValue.fromJson(Map<String, dynamic> json) => FieldValue(
    id: json["id"],
    observationId: json["observationId"],
    fieldId: json["field_id"],
    value: json["value"],
    label: json["label"],
    fieldType: json["field_type"]
  );
}