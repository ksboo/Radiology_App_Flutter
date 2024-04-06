import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:radiology/screens/PatientTapList.dart';

class Patient {
  final int patientid;
  final String firstName;
  final String lastName;
  final String contactNumber;
  final int streetNumber;
  final String streetName;
  final String city;
  final String country;

  Patient({
    required this.patientid,
    required this.firstName,
    required this.lastName,
    required this.contactNumber,
    required this.streetNumber,
    required this.streetName,
    required this.city,
    required this.country,
  });

  // Factory constructor to convert JSON data to Patient object
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      patientid: json['patientid'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      contactNumber: json['contactNumber'],
      streetNumber: int.parse(json['streetNumber']),
      streetName: json['streetName'],
      city: json['city'],
      country: json['country'],
    );
  }
}

class PatientsListPage extends StatefulWidget {
  @override
  _PatientsListPageState createState() => _PatientsListPageState();
}

class _PatientsListPageState extends State<PatientsListPage> {
  List<Patient> patients = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/patients')); // Replace with your API endpoint
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        // Convert JSON data to a list of Patient objects
        patients = data.map((item) => Patient.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patients List'),
      ),
      body: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final patient = patients[index];
          return ListTile(
            title: Text('${patient.firstName} ${patient.lastName}'),
            subtitle: Text('Contact: ${patient.contactNumber}'),
            onTap: () {
              // Navigate to a detailed view of the patient if needed
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PatientDetailsPage(patient: patient),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
