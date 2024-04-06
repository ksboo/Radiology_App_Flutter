import 'package:flutter/material.dart';
import 'package:radiology/screens/patients_table.dart';

class card_staff extends StatelessWidget {
  const card_staff({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Container(
            height: 250.0,
            child: Card(
              color: Color.fromRGBO(159, 226, 191, 1.0),
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
                      'Staff Features to Help',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '\nStep in and use the features we provide to help make your experience at the hospital more efficient.',
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
            bottom: 15.0,
            right: 20.0,
            child: ElevatedButton(
              //style: ButtonStyle( ),
              onPressed: () {
                // Add your button's functionality here
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PatientsListPage()),
            );

                print('Button pressed');
              },
              child: Text('See all patients', style: TextStyle(color: Colors.black),),
            ),
          ),
          Positioned(
            bottom: 15.0,
            right: 190.0,
            child: ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Physician_profile()),
                // );
                // Add your button's functionality here
                print('Button pressed');
              },
              child: Text('Assign Appointment', style: TextStyle(color: Colors.black),),
            ),
          ),
        ],
      ),
    );
  }
}
