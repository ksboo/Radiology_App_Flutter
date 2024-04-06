import 'package:flutter/material.dart';
import 'package:radiology/screens/pneumonia_detection.dart';
// import 'package:hospital_managment/pneumonia_detection.dart';

class card_physician extends StatelessWidget {
  const card_physician({super.key, required int physicianid});

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
                      'Physicians Features',
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
            right: 10.0,
            child: ElevatedButton(
              //style: ButtonStyle( ),
              onPressed: () {
                // Add your button's functionality here
            //     Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => Staff_profile()),
            // );

                print('Button pressed');
              },
              child: Text('Patient list', style: TextStyle(color: Colors.black),),
            ),
          ),
          Positioned(
            bottom: 15.0,
            right: 135.0,
            child: ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Physician_profile()),
                // );
                // Add your button's functionality here
                print('Button pressed');
              },
              child: Text('Appointments', style: TextStyle(color: Colors.black),),
            ),
          ),
          Positioned(
            bottom: 15.0,
            right: 285.0,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PneumoniaDetectionScreen()),
                );
                // Add your button's functionality here
                print('Button pressed');
              },
              child: Text('ML Model', style: TextStyle(color: Colors.black),),
            ),
          ),
        ],
      ),
    );
  }
}
