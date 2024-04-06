import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatelessWidget {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _contactnoController = TextEditingController();
  TextEditingController _streetNumberController = TextEditingController();
  TextEditingController _streetNameController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _sendInputToBackend() async {
    String url = 'http://127.0.0.1:5000/insert_patient';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'dateOfBirth': _dobController.text,
      'gender': _genderController.text,
      'contactno': _contactnoController.text,
      'streetNumber': _streetNumberController.text,
      'streetName': _streetNameController.text,
      'city': _cityController.text,
      'country': _countryController.text,
      'password': _passwordController.text,
    };
    String jsonBody = jsonEncode(body);

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: jsonBody);
      if (response.statusCode == 200) {
        print('Input sent successfully');
      } else {
        print('Failed to send input: ${response.statusCode}');
        // Handle error more gracefully (e.g., display a Snackbar or AlertDialog)
      }
    } catch (error) {
      print('Error sending input: $error');
      // Handle error more gracefully (e.g., display a Snackbar or AlertDialog)
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter App'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                ),
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(labelText: 'Last Name'),
                ),
                TextField(
                  controller: _dobController,
                  decoration: InputDecoration(labelText: 'Date of Birth (YYYY-MM-DD)'),
                ),
                TextField(
                  controller: _genderController,
                  decoration: InputDecoration(labelText: 'Gender (Male/Female)'),
                ),
                TextField(
                  controller: _contactnoController,
                  decoration: InputDecoration(labelText: 'Contact Number'),
                ),
                TextField(
                  controller: _streetNumberController,
                  decoration: InputDecoration(labelText: 'Street Number'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _streetNameController,
                  decoration: InputDecoration(labelText: 'Street Name'),
                ),
                TextField(
                  controller: _cityController,
                  decoration: InputDecoration(labelText: 'City'),
                ),
                TextField(
                  controller: _countryController,
                  decoration: InputDecoration(labelText: 'Country'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _sendInputToBackend,
                  child: Text('Send Input'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
