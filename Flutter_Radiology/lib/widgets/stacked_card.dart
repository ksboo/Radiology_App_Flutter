import 'package:flutter/material.dart';
import 'package:radiology/screens/physician_login.dart';
import 'package:radiology/screens/staff_login.dart';


class StackedCard extends StatelessWidget {
  const StackedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Container(
            height: 250.0,
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Radiology Management',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '\nStep in as one of the following roles and use the features we provide to help make this hospital more efficient.',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 45.0,
            right: 24.0,
            child: ElevatedButton(
              //style: ButtonStyle( ),
              onPressed: () {
                // Add your button's functionality here
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StaffLogin()),
            );

                print('Button pressed');
              },
              child: Text('Staff Member', style: TextStyle(color: Colors.black),),
            ),
          ),
          Positioned(
            bottom: 45.0,
            right: 180.0,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PhysicianLogin()),
                );
                // Add your button's functionality here
                print('Button pressed');
              },
              child: Text('Physician', style: TextStyle(color: Colors.black),),
            ),
          ),
        ],
      ),
    );
  }
}
