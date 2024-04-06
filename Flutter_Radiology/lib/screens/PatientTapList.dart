import 'package:flutter/material.dart';
import 'package:radiology/screens/patients_table.dart';
// import Patient// Import the Patient model

class PatientDetailsPage extends StatelessWidget {
  final Patient patient; // The selected patient object

  PatientDetailsPage({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${patient.firstName} ${patient.lastName}',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text('Contact Number: ${patient.contactNumber}'),
            SizedBox(height: 10.0),
            Text('Street Address: ${patient.streetNumber} ${patient.streetName}'),
            SizedBox(height: 10.0),
            Text('City: ${patient.city}'),
            SizedBox(height: 10.0),
            Text('Country: ${patient.country}'),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
