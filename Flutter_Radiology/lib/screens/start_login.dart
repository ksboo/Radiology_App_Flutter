import 'package:flutter/material.dart';
import 'package:radiology/screens/patient_login.dart';
import 'package:radiology/screens/physician_login.dart';
import 'package:radiology/screens/staff_login.dart';

// import 'package:hospital_managment/patients_table.dart';

class start_login extends StatelessWidget {
  const start_login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        backgroundColor: Color.fromRGBO(218, 234, 226, 1),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/patient_1.jpeg'),
              ),
              SizedBox(height: 10.0),
              // Text(
              //   'John Doe',
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontSize: 24.0,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // SizedBox(height: 5.0),
              // Text(
              //   'Flutter Developer',
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontSize: 16.0,
              //   ),
              // ),
              // SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle login as physician
                  // String userType = 'physician'; // Define userType here
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PhysicianLogin()),
                  );
                },
                child: Text('Login as Physician'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Handle login as staff
                  // String userType = 'staff'; // Define userType here
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StaffLogin()),
                  );
                },
                child: Text('Login as Staff'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Handle login as patient
                  // String userType = 'patient'; // Define userType here
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PatientLogin()),
                  );
                },
                child: Text('Login as Patient'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
