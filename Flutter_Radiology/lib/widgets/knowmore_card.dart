import 'package:flutter/material.dart';
import 'package:radiology/screens/patient_login.dart';
// import 'package:hospital_managment/patient_profile.dart';

class knowMore_card extends StatelessWidget {
  const knowMore_card({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Container(
            // color: Color.fromRGBO(3, 4, 94, 1),
            height: 300.0,
            child: Card(
              color: Color.fromRGBO(159, 226, 191, 1.0),
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Patient\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(' login in here')
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            bottom: 20.0,
            right: 16.0,
            child: ElevatedButton(
              //style: ButtonStyle( ),
              onPressed: () {
                // Add your button's functionality here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PatientLogin()),
                );

                print('Button pressed');
              },
              child: Text(
                'Patients login here',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
