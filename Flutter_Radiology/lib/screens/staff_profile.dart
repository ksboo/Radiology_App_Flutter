import 'package:flutter/material.dart';
import 'package:radiology/widgets/card_staff.dart';

class staff_profile extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String contactNumber;
  final String role;
  final int streetNumber;
  final String streetName;
  final String city;
  final String country;

  const staff_profile({
    required this.firstName,
    required this.lastName,
    required this.contactNumber,
    required this.role,
    required this.streetNumber,
    required this.streetName,
    required this.city,
    required this.country,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff'),
        backgroundColor: Color.fromRGBO(218, 234, 226, 1),
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
                    backgroundImage: AssetImage('assets/nurse_1.jpeg'),
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
                    '$role',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20,),

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
                      text: 'Role: ',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: '$role',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.numbers, color: Colors.black),
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Staff ID: ',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: 'ABC123',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 100,),
            Container(height: 250,child: card_staff()), // You can replace this with your card widget
          ],
        ),
      ),
    );
  }
}