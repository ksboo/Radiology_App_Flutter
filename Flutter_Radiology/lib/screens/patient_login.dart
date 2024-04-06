import 'package:flutter/material.dart';
// import 'package:hospital_managment/patient_profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:radiology/screens/patient_profile.dart';
import 'package:radiology/screens/signup_patient.dart';
// import 'package:hospital_managment/patient_profile.dart';
// import 'package:hospital_managment/signup_patient.dart';

class PatientLogin extends StatefulWidget {
  @override
  _PatientLoginState createState() => _PatientLoginState();
}

class _PatientLoginState extends State<PatientLogin> {
  TextEditingController _contactNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
  String url = 'http://127.0.0.1:5000/patient_login'; // Replace with your backend URL
  Map<String, String> headers = {'Content-Type': 'application/json'};
  Map<String, dynamic> body = {
    'contactNumber': _contactNumberController.text,
    'password': _passwordController.text,
  };
  String jsonBody = jsonEncode(body);

  try {
    final response = await http.post(Uri.parse(url), headers: headers, body: jsonBody);
    if (response.statusCode == 200) {
      final patientData = jsonDecode(response.body);
      print(patientData['firstName']);

      if (patientData != null && patientData.containsKey('firstName')) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PatientProfile(
              patientId: patientData['patientid'],
              firstName: patientData['firstName'],
              lastName: patientData['lastName'],
              contactNumber: patientData['contactNumber'],
              streetNumber: int.parse(patientData['streetNumber']),
              streetName: patientData['streetName'],
              city: patientData['city'],
              country: patientData['country'],
            ),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Invalid response from the server.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to login. Please try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  } catch (error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('Failed to connect to the server.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _contactNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _login(),
                child: Text('Login'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                },
                child: Text('Don\'t have an account? Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
