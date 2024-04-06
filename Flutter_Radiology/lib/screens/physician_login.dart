import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:radiology/screens/physician_profile.dart';


class PhysicianLogin extends StatefulWidget {
  @override
  _PhysicianLoginState createState() => _PhysicianLoginState();
}

class _PhysicianLoginState extends State<PhysicianLogin> {
  TextEditingController _contactNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
  String url = 'http://127.0.0.1:5000/physician_login'; // Replace with your backend URL
  Map<String, String> headers = {'Content-Type': 'application/json'};
  Map<String, dynamic> body = {
    'contactNumber': _contactNumberController.text,
    'password': _passwordController.text,
  };
  String jsonBody = jsonEncode(body);

  try {
    final response = await http.post(Uri.parse(url), headers: headers, body: jsonBody);
    if (response.statusCode == 200) {
      final physicianData = jsonDecode(response.body);
      print(physicianData['firstName']);

      if (physicianData != null && physicianData.containsKey('firstName')) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => physician_profile(
              physicianid: physicianData['physicianid'],
              firstName: physicianData['firstName'],
              lastName: physicianData['lastName'],
              contactNumber: physicianData['contactNumber'],
              specialization: physicianData['specialization'],
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
              
            ],
          ),
        ),
      ),
    );
  }
}
