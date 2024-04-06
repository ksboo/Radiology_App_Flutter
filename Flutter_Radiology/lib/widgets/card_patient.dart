import 'package:flutter/material.dart';
import 'package:radiology/screens/appointment_history.dart';
import 'package:radiology/screens/book_appointment.dart';

class CardPatient extends StatelessWidget {
  final int patientID;

  const CardPatient({Key? key, required this.patientID}) : super(key: key);

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
                      'Patient Treatment Features',
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
            right: 24.0,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookAppointment()),
                );
              },
              child: Text(
                'Book Appointment',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Positioned(
            bottom: 15.0,
            right: 210.0,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppointmentHistoryPage(patientID: patientID)),
                );
              },
              child: Text(
                'History',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
