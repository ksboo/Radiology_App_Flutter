import 'package:flutter/material.dart';
import 'package:radiology/widgets/card_patient.dart';



class PatientProfile extends StatelessWidget {
  final int patientId;
  final String firstName;
  final String lastName;
  final String contactNumber;
  final int streetNumber;
  final String streetName;
  final String city;
  final String country;

  const PatientProfile({
    required this.patientId,
    required this.firstName,
    required this.lastName,
    required this.contactNumber,
    required this.streetNumber,
    required this.streetName,
    required this.city,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              color: Color.fromRGBO(218, 234, 226, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage('assets/patient_1.jpeg'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '$firstName $lastName',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'Patient',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone_outlined, color: Colors.black),
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Patient ID: ',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: '$patientId',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone_outlined, color: Colors.black),
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Phone: ',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: '$contactNumber',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.location_on_outlined, color: Colors.black),
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Address: ',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: '$streetNumber, $streetName, $city, $country',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15,),
            Container(height: 250, child: CardPatient(patientID: patientId)),
          ],
        ),
      ),
    );
  }
}
